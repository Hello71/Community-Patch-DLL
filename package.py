#!/usr/bin/env python3

import argparse
import itertools
import os
import shlex
import subprocess
import sys
import tarfile
from typing import BinaryIO, IO, Iterator
from pathlib import Path

def my_walk(root: Path, subpath: Path) -> Iterator[str]:
    with os.scandir(root / subpath) as it:
        for f in it:
            if f.is_symlink():
                raise Exception('symlinks not currently supported')
            elif f.is_dir():
                yield from my_walk(root, os.path.join(subpath, f.name))
            elif f.is_file():
                if os.path.splitext(f.name)[-1] not in ['.civ5proj', '.civ5sln', '.dll']:
                    yield os.path.join(subpath, f.name)
            else:
                raise Exception('unhandled path type: %s' % f.path)

def gettarinfo(arcname: str, fileobj: IO) -> tarfile.TarInfo:
    st = os.fstat(fileobj.fileno())
    tar_info = tarfile.TarInfo()
    tar_info.name = arcname
    tar_info.size = st.st_size
    tar_info.mtime = st.st_mtime
    tar_info.mode = st.st_mode
    tar_info.type = tarfile.REGTYPE
    tar_info.uid = tar_info.gid = 0
    tar_info.uname = tar_info.gname = ''
    return tar_info

def write_tar(fileobj: BinaryIO, files: Iterator[str], args) -> None:
    with tarfile.open(fileobj=fileobj, mode='w|') as tar:
        def tar_add(name, arcname):
            with open(name, 'rb') as fo:
                tar.addfile(gettarinfo(args.tar_prefix + arcname, fo), fo)
        for f in files:
            tar_add(args.source_dir / f, f.lower())
        tar_add(args.source_dir / 'install.sh', 'install.sh')
        tar_add(args.build_dir / 'libCiv5XP_hook.so', 'libCiv5XP_hook.so')
        tar_add(args.build_dir / 'CvGameCoreDLL_Expansion2/libCvGameCoreDLL_Expansion2.so', '(1) community patch/libcvgamecoredll_expansion2.so')

def main(argv) -> None:
    parser = argparse.ArgumentParser(description='Create Vox Populi package.')
    parser.add_argument('source_dir', help='Source directory', type=Path)
    parser.add_argument('build_dir', help='Build directory', type=Path)
    parser.add_argument('-d', '--tar-prefix', help='Tar base directory (default: %(default)s)', default='Vox Populi/')
    parser.add_argument('-f', '--filter', help='Output filter')
    args = parser.parse_args(argv)

    dirs = [
        '(1) Community Patch',
        '(2) Vox Populi',
        '(3a) EUI Compatibility Files',
        '(3b) 43 Civs Community Patch',
        '(4a) Squads for VP',
        'UI_bc1',
        'VPUI',
        'VPUI Text',
    ]
    files = list(itertools.chain.from_iterable(my_walk(args.source_dir, Path(d)) for d in dirs))
    files.sort(key=lambda x: os.path.splitext(x)[::-1])

    if sys.stdout.isatty():
        raise Exception('refusing to write binary data to stdout')
    else:
        if args.filter:
            with subprocess.Popen(args.filter, stdin=subprocess.PIPE, shell=True) as proc:
                write_tar(proc.stdin, files, args)
        else:
            write_tar(sys.stdout.buffer, files, args)

if __name__ == '__main__':
    main(sys.argv[1:])
