project('Vox Populi', 'cpp',
  default_options: [
    'buildtype=debugoptimized',
    'cpp_eh=none',
    'cpp_rtti=false',
    'cpp_std=c++11',
    'warning_level=0',
  ]
)

commit_id_inc = vcs_tag(command: ['git', 'describe'], input: 'commit_id.inc.in', output: 'commit_id.inc')

cpp = meson.get_compiler('cpp')
cpp_try_args = []
cpp_try_link_args = []
dll_cpp_args = ['-DFXS_IS_DLL', '-DNDEBUG', '-DFINAL_RELEASE']
dll_cpp_args += cpp.get_supported_arguments([
  # required for serialization
  '-Wno-invalid-offsetof',

  # TODO: fix
  '-Wno-tautological-constant-out-of-range-compare',
])

if get_option('vpdebug')
  dll_cpp_args += ['-DVPDEBUG']
endif

have_march = false
foreach cpp_arg : get_option('cpp_args')
  if cpp_arg.startswith('-march=')
    have_march = true
    break
  endif
endforeach
if not have_march
  cpp_try_args += ['-march=core2', '-mtune=generic']
endif

cpp_try_args += ['-mfpmath=sse', '-fno-math-errno', '-ffp-contract=off', '-ffinite-math-only', '-fno-signed-zeros', '-fno-trapping-math']
cpp_try_link_args += ['-Wl,-O2', '-Wl,--sort-common', '-Wl,--icf=all']

if host_machine.system() == 'linux'
  if host_machine.cpu_family() != 'x86'
    error_more = ''
    if host_machine.cpu_family() == 'x86_64'
      if cpp.get_id() == 'gcc'
        error_more = ' Try meson --cross-file meson-gcc.txt.'
      elif cpp.get_id() == 'clang'
        error_more = ' Try meson --cross-file meson-clang.txt.'
      endif
    endif
    error('Civilization V for Linux only supports 32-bit x86.' + error_more)
  endif

  dll_cpp_args += ['-include', '../compat.h']

  cpp_try_args += ['-fno-plt', '-fno-semantic-interposition']
  cpp_try_link_args += '-Wl,--hash-style=gnu'
else
  error('only Linux is currently supported')
endif

cpp_args = cpp.get_supported_arguments(cpp_try_args)
add_project_arguments(cpp_args, language: 'cpp')
add_project_link_arguments(cpp_args + cpp.get_supported_link_arguments(cpp_try_link_args), language: 'cpp')

if host_machine.system() == 'linux'
  if cpp.has_header_symbol('version', '_LIBCPP_VERSION', args: ['-stdlib=libc++'])
    libcxx = declare_dependency(compile_args: ['-stdlib=libc++'], link_args: ['-stdlib=libc++'])
  elif cpp.get_id() == 'gcc'
    libcxx_inc = get_option('libcxx_inc')
    if libcxx_inc == ''
      find_libcxx = run_command('sh', '-c', 'x=; for d in /usr/lib/llvm-*/include/c++/v1 /usr/include/c++/v1; do [ -f "$d/string" ] && x=$d; done; printf "%s" "$x"', check: true)
      libcxx_inc = find_libcxx.stdout()
      if libcxx_inc == ''
        error('failed to find libc++')
      endif
      message(f'auto-detected libc++ headers: @libcxx_inc@')
    endif

    libcxx_lib = cpp.find_library('c++', required: false)
    if libcxx_lib.found()
      libcxx = declare_dependency(
        compile_args: ['-nostdinc++', '-isystem', libcxx_inc],
        link_args: ['-nostdlib++', '-lc++']
      )
    else
      libcxx_empty = shared_library('c++', version: '1.0')
      libcxx = declare_dependency(
        compile_args: ['-nostdinc++', '-isystem', libcxx_inc],
        link_args: ['-nostdlib++', '-Wl,--push-state', '-Wl,--no-as-needed', libcxx_empty.full_path(), '-Wl,--as-needed'],
        link_with: [libcxx_empty]
      )
    endif
  else
    error('building Civ 5 DLL mods on Linux requires either -stdlib=libc++ or g++')
  endif

  Civ5XP_hook = shared_module('Civ5XP_hook',
    dependencies: [libcxx],
    override_options: ['cpp_std=c++17', 'warning_level=2'],
    sources: [
      'Civ5XP_hook.cpp'
    ]
  )
endif

dll_include_dirs = include_directories(
  'CvGameCoreDLLUtil/include',
  'CvGameDatabase/include',
  'CvLocalization/include',
  'CvWorldBuilderMap/include',
  'FirePlace/include',
  'FirePlace/include/FireWorks',
  'ThirdPartyLibs/Lua51/include',
)

subdir('CvGameCoreDLL_Expansion2')

if host_machine.system() == 'linux'
  tar_base = 'Vox Populi Linux'

  package = custom_target('package',
    build_always_stale: true,
    depends: [Civ5XP_hook, CvGameCoreDLL_Expansion2],
    output: tar_base + '.tar.xz',
    command: [
      files('./package.py'),
      '--tar-prefix', tar_base + '/',
      '--filter', 'xz --x86 --lzma2',
      meson.current_source_dir(),
      meson.current_build_dir(),
    ],
    capture: true,
  )
  package_alias = alias_target('package', package)
endif
