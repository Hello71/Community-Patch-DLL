/* This file shouldn't be included more than once, but gcc gets confused when doing PCH */
#ifndef CV_COMPAT_H
#define CV_COMPAT_H

#include <stddef.h>

#if defined(_LIBCPP_VERSION) && _LIBCPP_VERSION < 15000 && __cplusplus < 201402L
/* Backport https://reviews.llvm.org/D119891 */
#include <type_traits>
template <class _Tp, bool = std::is_enum<_Tp>::value>
struct __enum_hash
{
    size_t operator()(_Tp __v) const _NOEXCEPT
    {
        typedef typename std::underlying_type<_Tp>::type type;
        return std::hash<type>{}(static_cast<type>(__v));
    }
};
template <class _Tp>
struct __enum_hash<_Tp, false> {
    __enum_hash() = delete;
    __enum_hash(__enum_hash const&) = delete;
    __enum_hash& operator=(__enum_hash const&) = delete;
};

template <class _Tp>
struct std::hash : public __enum_hash<_Tp>
{
};
#endif

/* auto_ptr removed in C++17 */
#include <__memory/unique_ptr.h>
#define auto_ptr unique_ptr

/* MSVC 2008 only has std::tr1 */
#include <__memory/shared_ptr.h>
namespace std {
    inline namespace __1 {
        template<class, size_t> struct array;
        template<class, class, class, class, class> class unordered_map;
        template<class, class, class, class> class unordered_set;
    }
    namespace tr1 {
        using std::array;
        using std::hash;
        using std::shared_ptr;
        using std::unordered_map;
        using std::unordered_set;
    }
}

/* MSVC extensions */
#define __forceinline __attribute__((always_inline)) inline
#define _In_
#define _In_opt_
#define _In_opt_z_
#define _In_bytecount_(x)
#define _In_z_
#define _Ret_opt_
#define _Ret_opt_z_
#define _Ret_z_
#define _Ret_maybenull_
#define _Check_return_ __attribute__((warn_unused_result))
#define _Inout_z_cap_(x)
#define _Inout_z_cap_c_(x)
#define __checkReturn _Check_return_
#define _vsnprintf vsnprintf
#define _strdup strdup
#define _stricmp strcasecmp
#define _strnicmp strncasecmp
#define _wcsicmp wcscasecmp
#define _wcsnicmp wcsncasecmp
#define _malloca malloc
#define _freea free
#define MAX_PATH 260
#define TRUE 1
#define FALSE 0
#define UNREFERENCED_PARAMETER(x) ((void)(x))
#define DECLSPEC_DEPRECATED __attribute__((deprecated))

/* TODO: use icu functions */
#define _stricoll strcasecmp
#define _wcsicoll wcscasecmp

/* TODO: is this needed? or just remove __cdecl? */
#define __cdecl
/* __stdcall is actually supported on Linux, but Aspyr doesn't use it */
#define __stdcall

/* MSVC types */
#define __int64 long long
typedef unsigned char UINT8;
typedef signed char INT8;
typedef unsigned short UINT16;
typedef short INT16;
typedef unsigned int UINT32;
typedef int INT32;
typedef unsigned long long UINT64;
typedef long long INT64;

typedef unsigned char BYTE;
typedef int BOOL;
typedef short SHORT;
typedef unsigned short USHORT;
typedef int INT;
typedef unsigned int UINT;
typedef long LONG;
typedef unsigned long ULONG;
typedef long long LONGLONG;
typedef unsigned long ULONGLONG;

typedef unsigned short WORD, *LPWORD;
typedef int DWORD, *LPDWORD;
typedef void VOID, *LPVOID;

typedef void * HANDLE;
#define INVALID_HANDLE_VALUE ((HANDLE)(uintptr_t)(-1))

typedef wchar_t WCHAR, *LPWSTR;
typedef const wchar_t * LPCWSTR;

#ifdef _UNICODE
typedef wchar_t TCHAR;
#define _T(x) L ## x
#else
typedef char TCHAR;
#define _T(x) x
#define OutputDebugString OutputDebugStringA
#endif
typedef const TCHAR * LPCSTR;

typedef struct tagPOINT {
  LONG x;
  LONG y;
} POINT, *PPOINT, *NPPOINT, *LPPOINT;

/* MSVC functions */
__attribute__((always_inline, artificial))
static inline int __noop(...) {
    return 0;
}

#define ZeroMemory(dest, length) (memset((dest), 0, (length)))

/* Aspyr porting aids (exported from Civ5XP) */
extern "C" {

/* Wrong but simple definitions */
typedef union _LARGE_INTEGER { LONGLONG QuadPart; } LARGE_INTEGER;
typedef void *LPSECURITY_ATTRIBUTES;
typedef void *LPOVERLAPPED;

typedef enum _HEAP_INFORMATION_CLASS {
    HeapCompatibilityInformation = 0,
    HeapEnableTerminationOnCorruption = 1,
    HeapOptimizeResources = 3,
    HeapTag
} HEAP_INFORMATION_CLASS;

typedef struct _SYSTEMTIME {
  WORD wYear;
  WORD wMonth;
  WORD wDayOfWeek;
  WORD wDay;
  WORD wHour;
  WORD wMinute;
  WORD wSecond;
  WORD wMilliseconds;
} SYSTEMTIME, *PSYSTEMTIME, *LPSYSTEMTIME;

HANDLE HeapCreate(DWORD, size_t, size_t);
BOOL HeapDestroy(HANDLE);
BOOL HeapFree(HANDLE, DWORD, void *);
__attribute__((alloc_size(3)))
#if __GNUC__ >= 11
__attribute__((malloc(HeapFree, 3)))
#else
__attribute__((malloc))
#endif
void *HeapAlloc(HANDLE, DWORD, size_t);
BOOL HeapSetInformation(HANDLE, HEAP_INFORMATION_CLASS, void *, size_t);

char *_strrev(char *str);
char *_strupr(char *str);
char *_strlwr(char *str);
wchar_t *_wcsrev(wchar_t *str);
wchar_t *_wcsupr(wchar_t *str);
wchar_t *_wcslwr(wchar_t *str);

typedef struct _GUID GUID;
DWORD CoCreateGuid(GUID *);

DWORD GetTickCount();
__attribute__((const))
DWORD GetCurrentThreadId();
DWORD timeGetTime();
void Sleep(DWORD milliseconds);
void OutputDebugStringA(const char *str);

#define CP_UTF8 65001
int MultiByteToWideChar(UINT CodePage, DWORD dwFlags, const char *lpMultiByteStr, int cbMultiByte, LPWSTR lpWideCharStr, int cchWideChar);

#define ERROR_FILE_NOT_FOUND 2
DWORD GetLastError();

#define INVALID_FILE_SIZE ((DWORD)0xffffffff)
DWORD GetFileSize(HANDLE, LPDWORD);

#define INVALID_FILE_ATTRIBUTES ((DWORD)-1)
BOOL GetFileAttributesW(LPCWSTR);

#define GENERIC_READ 0x80000000
#define GENERIC_WRITE 0x40000000
#define FILE_SHARE_READ 0x00000001
#define FILE_SHARE_WRITE 0x00000002
#define OPEN_EXISTING 3
#define FILE_FLAG_SEQUENTIAL_SCAN 0x8000000
HANDLE CreateFileW(LPCWSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES, DWORD, DWORD, HANDLE);

BOOL DeleteFileW(LPCWSTR);
BOOL ReadFile(HANDLE, LPVOID, DWORD, LPDWORD, LPOVERLAPPED);
BOOL CloseHandle(HANDLE);

BOOL QueryPerformanceCounter(LARGE_INTEGER *lpPerformanceCount);
BOOL QueryPerformanceFrequency(LARGE_INTEGER *lpFrequency);

}; // extern "C"

int strcpy_s(char *, size_t, const char *);
__attribute__((format(printf, 3, 4)))
int sprintf_s(char *, size_t, const char *, ...);
int wcscpy_s(wchar_t *, unsigned int, const wchar_t *);

/* Annex K functions, MS extensions */
template <size_t size>
__attribute__((always_inline, artificial))
static inline int strcpy_s(char (&dest)[size], const char *src) {
    return strcpy_s(dest, size, src);
}

template <size_t size, typename... Args>
__attribute__((always_inline, artificial))
static inline int sprintf_s(char (&buffer)[size], const char *format, const Args &...args) {
    return sprintf_s(buffer, size, format, args...);
}

/* Firaxis junk */
#define CvLocalizationAPI
#define CvGameDatabaseAPI

#endif
