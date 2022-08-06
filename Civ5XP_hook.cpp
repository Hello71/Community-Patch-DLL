#include <array>
#include <dlfcn.h>
#include <err.h>
#include <sqlite3.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <strings.h>
#include <sys/mman.h>
#include <unistd.h>
#include <utility>
#include <vector>

#define CIV5_BASE_ADDR reinterpret_cast<void*>(0x8048000)
#define CIV5_TEXT_SIZE 0x22a7000
#define CIV5_RODATA_SIZE 0x18000

enum CF_insn : unsigned char {
    CALL_REL = 0xe8,
    JMP_REL = 0xe9,
};

void DOS2MacPath(const char *, char *);
int main();

static char old_main[5];
static void *exe;

static const char * const sqlite3_funcs[] = {
    "sqlite3_aggregate_context",
    "sqlite3_auto_extension",
    "sqlite3_backup_finish",
    "sqlite3_backup_init",
    "sqlite3_backup_pagecount",
    "sqlite3_backup_remaining",
    "sqlite3_backup_step",
    "sqlite3_bind_blob",
    "sqlite3_bind_double",
    "sqlite3_bind_int",
    "sqlite3_bind_int64",
    "sqlite3_bind_null",
    "sqlite3_bind_parameter_count",
    "sqlite3_bind_parameter_index",
    "sqlite3_bind_parameter_name",
    "sqlite3_bind_text",
    "sqlite3_bind_text16",
    "sqlite3_bind_value",
    "sqlite3_bind_zeroblob",
    "sqlite3_blob_bytes",
    "sqlite3_blob_close",
    "sqlite3_blob_open",
    "sqlite3_blob_read",
    "sqlite3_blob_reopen",
    "sqlite3_blob_write",
    "sqlite3_busy_handler",
    "sqlite3_busy_timeout",
    "sqlite3_changes",
    "sqlite3_initialize",
    "sqlite3_clear_bindings",
    "sqlite3_close",
    "sqlite3_close_v2",
    "sqlite3_collation_needed",
    "sqlite3_collation_needed16",
    "sqlite3_column_blob",
    "sqlite3_column_bytes",
    "sqlite3_column_bytes16",
    "sqlite3_column_count",
    "sqlite3_column_decltype",
    "sqlite3_column_decltype16",
    "sqlite3_column_double",
    "sqlite3_column_int",
    "sqlite3_column_int64",
    "sqlite3_column_name",
    "sqlite3_column_name16",
    "sqlite3_column_text",
    "sqlite3_column_text16",
    "sqlite3_column_type",
    "sqlite3_column_value",
    "sqlite3_commit_hook",
    "sqlite3_config",
    "sqlite3_context_db_handle",
    "sqlite3_create_collation",
    "sqlite3_create_collation16",
    "sqlite3_create_collation_v2",
    "sqlite3_create_function",
    "sqlite3_create_function16",
    "sqlite3_create_function_v2",
    "sqlite3_data_count",
    "sqlite3_db_config",
    "sqlite3_db_filename",
    "sqlite3_db_handle",
    "sqlite3_db_mutex",
    "sqlite3_db_readonly",
    "sqlite3_db_release_memory",
    "sqlite3_db_status",
    "sqlite3_enable_load_extension",
    "sqlite3_errcode",
    "sqlite3_errmsg",
    "sqlite3_errmsg16",
    "sqlite3_errstr",
    "sqlite3_exec",
    "sqlite3_extended_errcode",
    "sqlite3_extended_result_codes",
    "sqlite3_file_control",
    "sqlite3_finalize",
    "sqlite3_free",
    "sqlite3_get_autocommit",
    "sqlite3_get_auxdata",
    "sqlite3_interrupt",
    "sqlite3_last_insert_rowid",
    "sqlite3_libversion",
    "sqlite3_libversion_number",
    "sqlite3_limit",
    "sqlite3_load_extension",
    "sqlite3_log",
    "sqlite3_malloc",
    "sqlite3_memory_highwater",
    "sqlite3_memory_used",
    "sqlite3_mprintf",
    "sqlite3_mutex_alloc",
    "sqlite3_mutex_enter",
    "sqlite3_mutex_free",
    "sqlite3_mutex_leave",
    "sqlite3_mutex_try",
    "sqlite3_next_stmt",
    "sqlite3_open",
    "sqlite3_open16",
    "sqlite3_open_v2",
    "sqlite3_os_end",
    "sqlite3_os_init",
    "sqlite3_overload_function",
    "sqlite3_prepare",
    "sqlite3_prepare16",
    "sqlite3_prepare16_v2",
    "sqlite3_prepare_v2",
    "sqlite3_randomness",
    "sqlite3_realloc",
    "sqlite3_release_memory",
    "sqlite3_reset",
    "sqlite3_reset_auto_extension",
    "sqlite3_result_blob",
    "sqlite3_result_double",
    "sqlite3_result_error",
    "sqlite3_result_error16",
    "sqlite3_result_error_code",
    "sqlite3_result_error_nomem",
    "sqlite3_result_error_toobig",
    "sqlite3_result_int",
    "sqlite3_result_int64",
    "sqlite3_result_null",
    "sqlite3_result_text",
    "sqlite3_result_text16",
    "sqlite3_result_text16be",
    "sqlite3_result_text16le",
    "sqlite3_result_value",
    "sqlite3_result_zeroblob",
    "sqlite3_rollback_hook",
    "sqlite3_set_auxdata",
    "sqlite3_shutdown",
    "sqlite3_sleep",
    "sqlite3_snprintf",
    "sqlite3_soft_heap_limit",
    "sqlite3_soft_heap_limit64",
    "sqlite3_sourceid",
    "sqlite3_sql",
    "sqlite3_status",
    "sqlite3_step",
    "sqlite3_stmt_busy",
    "sqlite3_stmt_readonly",
    "sqlite3_stmt_status",
    "sqlite3_strglob",
    "sqlite3_stricmp",
    "sqlite3_strnicmp",
    "sqlite3_test_control",
    "sqlite3_threadsafe",
    "sqlite3_total_changes",
    "sqlite3_update_hook",
    "sqlite3_uri_boolean",
    "sqlite3_uri_int64",
    "sqlite3_uri_parameter",
    "sqlite3_user_data",
    "sqlite3_value_blob",
    "sqlite3_value_bytes",
    "sqlite3_value_bytes16",
    "sqlite3_value_double",
    "sqlite3_value_int",
    "sqlite3_value_int64",
    "sqlite3_value_numeric_type",
    "sqlite3_value_text",
    "sqlite3_value_text16",
    "sqlite3_value_text16be",
    "sqlite3_value_text16le",
    "sqlite3_value_type",
    "sqlite3_vfs_find",
    "sqlite3_vfs_register",
    "sqlite3_vfs_unregister",
    "sqlite3_vmprintf",
    "sqlite3_vsnprintf",
    "sqlite3_wal_autocheckpoint",
    "sqlite3_wal_checkpoint",
    "sqlite3_wal_checkpoint_v2",
    "sqlite3_wal_hook",
};

static const char * const sqlite3_funcs_opt[] = {
    "sqlite3_compileoption_get",
    "sqlite3_compileoption_used",
    "sqlite3_complete",
    "sqlite3_complete16",
    "sqlite3_create_module",
    "sqlite3_create_module_v2",
    "sqlite3_declare_vtab",
    "sqlite3_enable_shared_cache",
    "sqlite3_free_table",
    "sqlite3_get_table",
    "sqlite3_profile",
    "sqlite3_trace",
    "sqlite3_vtab_config",
    "sqlite3_vtab_on_conflict",
};

static const char * const sdl2_funcs[] = {
    "SDL_AddEventWatch",
    "SDL_AddHintCallback",
    "SDL_AddTimer",
    "SDL_AllocFormat",
    "SDL_AllocPalette",
    "SDL_AllocRW",
    "SDL_AtomicAdd",
    "SDL_AtomicCAS",
    "SDL_AtomicCASPtr",
    "SDL_AtomicGet",
    "SDL_AtomicGetPtr",
    "SDL_AtomicLock",
    "SDL_AtomicSet",
    "SDL_AtomicSetPtr",
    "SDL_AtomicTryLock",
    "SDL_AtomicUnlock",
    "SDL_AudioInit",
    "SDL_AudioQuit",
    "SDL_BuildAudioCVT",
    "SDL_CalculateGammaRamp",
    "SDL_ClearError",
    "SDL_ClearHints",
    "SDL_CloseAudio",
    "SDL_CloseAudioDevice",
    "SDL_ConvertAudio",
    "SDL_ConvertPixels",
    "SDL_ConvertSurface",
    "SDL_ConvertSurfaceFormat",
    "SDL_CreateColorCursor",
    "SDL_CreateCursor",
    "SDL_CreateMutex",
    "SDL_CreateRGBSurface",
    "SDL_CreateRGBSurfaceFrom",
    "SDL_CreateRenderer",
    "SDL_CreateSemaphore",
    "SDL_CreateShapedWindow",
    "SDL_CreateSoftwareRenderer",
    "SDL_CreateSystemCursor",
    "SDL_CreateTexture",
    "SDL_CreateTextureFromSurface",
    "SDL_CreateThread",
    "SDL_CreateWindow",
    "SDL_CreateWindowAndRenderer",
    "SDL_CreateWindowFrom",
    "SDL_DelEventWatch",
    "SDL_DelHintCallback",
    "SDL_Delay",
    "SDL_DestroyMutex",
    "SDL_DestroyRenderer",
    "SDL_DestroySemaphore",
    "SDL_DestroyTexture",
    "SDL_DestroyWindow",
    "SDL_DetachThread",
    "SDL_DisableScreenSaver",
    "SDL_EnableScreenSaver",
    "SDL_EnclosePoints",
    "SDL_Error",
    "SDL_EventState",
    "SDL_FillRect",
    "SDL_FillRects",
    "SDL_FilterEvents",
    "SDL_FlushEvent",
    "SDL_FlushEvents",
    "SDL_FreeCursor",
    "SDL_FreeFormat",
    "SDL_FreePalette",
    "SDL_FreeRW",
    "SDL_FreeSurface",
    "SDL_GL_BindTexture",
    "SDL_GL_CreateContext",
    "SDL_GL_DeleteContext",
    "SDL_GL_ExtensionSupported",
    "SDL_GL_GetAttribute",
    "SDL_GL_GetCurrentContext",
    "SDL_GL_GetCurrentWindow",
    "SDL_GL_GetDrawableSize",
    "SDL_GL_GetProcAddress",
    "SDL_GL_GetSwapInterval",
    "SDL_GL_LoadLibrary",
    "SDL_GL_MakeCurrent",
    "SDL_GL_ResetAttributes",
    "SDL_GL_SetAttribute",
    "SDL_GL_SetSwapInterval",
    "SDL_GL_SwapWindow",
    "SDL_GL_UnbindTexture",
    "SDL_GL_UnloadLibrary",
    "SDL_GameControllerAddMapping",
    "SDL_GameControllerAddMappingsFromRW",
    "SDL_GameControllerClose",
    "SDL_GameControllerEventState",
    "SDL_GameControllerGetAttached",
    "SDL_GameControllerGetAxis",
    "SDL_GameControllerGetAxisFromString",
    "SDL_GameControllerGetBindForAxis",
    "SDL_GameControllerGetBindForButton",
    "SDL_GameControllerGetButton",
    "SDL_GameControllerGetButtonFromString",
    "SDL_GameControllerGetJoystick",
    "SDL_GameControllerGetStringForAxis",
    "SDL_GameControllerGetStringForButton",
    "SDL_GameControllerMapping",
    "SDL_GameControllerMappingForGUID",
    "SDL_GameControllerName",
    "SDL_GameControllerNameForIndex",
    "SDL_GameControllerOpen",
    "SDL_GameControllerUpdate",
    "SDL_GetAssertionHandler",
    "SDL_GetAssertionReport",
    "SDL_GetAudioDeviceName",
    "SDL_GetAudioDeviceStatus",
    "SDL_GetAudioDriver",
    "SDL_GetAudioStatus",
    "SDL_GetCPUCacheLineSize",
    "SDL_GetCPUCount",
    "SDL_GetClipRect",
    "SDL_GetClosestDisplayMode",
    "SDL_GetColorKey",
    "SDL_GetCurrentAudioDriver",
    "SDL_GetCurrentDisplayMode",
    "SDL_GetCurrentVideoDriver",
    "SDL_GetCursor",
    "SDL_GetDefaultAssertionHandler",
    "SDL_GetDefaultCursor",
    "SDL_GetDesktopDisplayMode",
    "SDL_GetDisplayBounds",
    "SDL_GetDisplayMode",
    "SDL_GetDisplayName",
    "SDL_GetError",
    "SDL_GetEventFilter",
    "SDL_GetHint",
    "SDL_GetKeyFromName",
    "SDL_GetKeyFromScancode",
    "SDL_GetKeyName",
    "SDL_GetKeyboardFocus",
    "SDL_GetKeyboardState",
    "SDL_GetModState",
    "SDL_GetMouseFocus",
    "SDL_GetMouseState",
    "SDL_GetNumAudioDevices",
    "SDL_GetNumAudioDrivers",
    "SDL_GetNumDisplayModes",
    "SDL_GetNumRenderDrivers",
    "SDL_GetNumTouchDevices",
    "SDL_GetNumTouchFingers",
    "SDL_GetNumVideoDisplays",
    "SDL_GetNumVideoDrivers",
    "SDL_GetPerformanceCounter",
    "SDL_GetPerformanceFrequency",
    "SDL_GetPixelFormatName",
    "SDL_GetPlatform",
    "SDL_GetRGB",
    "SDL_GetRGBA",
    "SDL_GetRelativeMouseMode",
    "SDL_GetRelativeMouseState",
    "SDL_GetRenderDrawBlendMode",
    "SDL_GetRenderDrawColor",
    "SDL_GetRenderDriverInfo",
    "SDL_GetRenderTarget",
    "SDL_GetRenderer",
    "SDL_GetRendererInfo",
    "SDL_GetRendererOutputSize",
    "SDL_GetRevision",
    "SDL_GetRevisionNumber",
    "SDL_GetScancodeFromKey",
    "SDL_GetScancodeFromName",
    "SDL_GetScancodeName",
    "SDL_GetShapedWindowMode",
    "SDL_GetSurfaceAlphaMod",
    "SDL_GetSurfaceBlendMode",
    "SDL_GetSurfaceColorMod",
    "SDL_GetSystemRAM",
    "SDL_GetTextureAlphaMod",
    "SDL_GetTextureBlendMode",
    "SDL_GetTextureColorMod",
    "SDL_GetThreadID",
    "SDL_GetThreadName",
    "SDL_GetTicks",
    "SDL_GetTouchDevice",
    "SDL_GetTouchFinger",
    "SDL_GetVersion",
    "SDL_GetVideoDriver",
    "SDL_GetWindowBrightness",
    "SDL_GetWindowData",
    "SDL_GetWindowDisplayIndex",
    "SDL_GetWindowDisplayMode",
    "SDL_GetWindowFlags",
    "SDL_GetWindowFromID",
    "SDL_GetWindowGammaRamp",
    "SDL_GetWindowGrab",
    "SDL_GetWindowID",
    "SDL_GetWindowMaximumSize",
    "SDL_GetWindowMinimumSize",
    "SDL_GetWindowPixelFormat",
    "SDL_GetWindowPosition",
    "SDL_GetWindowSize",
    "SDL_GetWindowSurface",
    "SDL_GetWindowTitle",
    "SDL_GetWindowWMInfo",
    "SDL_HapticClose",
    "SDL_HapticDestroyEffect",
    "SDL_HapticEffectSupported",
    "SDL_HapticGetEffectStatus",
    "SDL_HapticIndex",
    "SDL_HapticName",
    "SDL_HapticNewEffect",
    "SDL_HapticNumAxes",
    "SDL_HapticNumEffects",
    "SDL_HapticNumEffectsPlaying",
    "SDL_HapticOpen",
    "SDL_HapticOpenFromJoystick",
    "SDL_HapticOpenFromMouse",
    "SDL_HapticOpened",
    "SDL_HapticPause",
    "SDL_HapticQuery",
    "SDL_HapticRumbleInit",
    "SDL_HapticRumblePlay",
    "SDL_HapticRumbleStop",
    "SDL_HapticRumbleSupported",
    "SDL_HapticRunEffect",
    "SDL_HapticSetAutocenter",
    "SDL_HapticSetGain",
    "SDL_HapticStopAll",
    "SDL_HapticStopEffect",
    "SDL_HapticUnpause",
    "SDL_HapticUpdateEffect",
    "SDL_Has3DNow",
    "SDL_HasAVX",
    "SDL_HasAltiVec",
    "SDL_HasEvent",
    "SDL_HasEvents",
    "SDL_HasIntersection",
    "SDL_HasMMX",
    "SDL_HasRDTSC",
    "SDL_HasSSE",
    "SDL_HasSSE2",
    "SDL_HasSSE3",
    "SDL_HasSSE41",
    "SDL_HasSSE42",
    "SDL_HasScreenKeyboardSupport",
    "SDL_HideWindow",
    "SDL_Init",
    "SDL_InitSubSystem",
    "SDL_IntersectRect",
    "SDL_IntersectRectAndLine",
    "SDL_IsGameController",
    "SDL_IsScreenKeyboardShown",
    "SDL_IsScreenSaverEnabled",
    "SDL_IsShapedWindow",
    "SDL_IsTextInputActive",
    "SDL_JoystickClose",
    "SDL_JoystickEventState",
    "SDL_JoystickGetAttached",
    "SDL_JoystickGetAxis",
    "SDL_JoystickGetBall",
    "SDL_JoystickGetButton",
    "SDL_JoystickGetDeviceGUID",
    "SDL_JoystickGetGUID",
    "SDL_JoystickGetGUIDFromString",
    "SDL_JoystickGetGUIDString",
    "SDL_JoystickGetHat",
    "SDL_JoystickInstanceID",
    "SDL_JoystickIsHaptic",
    "SDL_JoystickName",
    "SDL_JoystickNameForIndex",
    "SDL_JoystickNumAxes",
    "SDL_JoystickNumBalls",
    "SDL_JoystickNumButtons",
    "SDL_JoystickNumHats",
    "SDL_JoystickOpen",
    "SDL_JoystickUpdate",
    "SDL_LoadDollarTemplates",
    "SDL_LoadFunction",
    "SDL_LoadObject",
    "SDL_LockAudio",
    "SDL_LockAudioDevice",
    "SDL_LockMutex",
    "SDL_LockSurface",
    "SDL_LockTexture",
    "SDL_Log",
    "SDL_LogCritical",
    "SDL_LogDebug",
    "SDL_LogError",
    "SDL_LogGetOutputFunction",
    "SDL_LogGetPriority",
    "SDL_LogInfo",
    "SDL_LogMessage",
    "SDL_LogMessageV",
    "SDL_LogResetPriorities",
    "SDL_LogSetAllPriority",
    "SDL_LogSetOutputFunction",
    "SDL_LogSetPriority",
    "SDL_LogVerbose",
    "SDL_LogWarn",
    "SDL_LowerBlit",
    "SDL_LowerBlitScaled",
    "SDL_MapRGB",
    "SDL_MapRGBA",
    "SDL_MasksToPixelFormatEnum",
    "SDL_MaximizeWindow",
    "SDL_MinimizeWindow",
    "SDL_MixAudio",
    "SDL_MixAudioFormat",
    "SDL_MouseIsHaptic",
    "SDL_NumHaptics",
    "SDL_NumJoysticks",
    "SDL_OpenAudio",
    "SDL_OpenAudioDevice",
    "SDL_PauseAudio",
    "SDL_PauseAudioDevice",
    "SDL_PeepEvents",
    "SDL_PixelFormatEnumToMasks",
    "SDL_PollEvent",
    "SDL_PumpEvents",
    "SDL_PushEvent",
    "SDL_QueryTexture",
    "SDL_Quit",
    "SDL_QuitSubSystem",
    "SDL_RWFromConstMem",
    "SDL_RWFromFP",
    "SDL_RWFromFile",
    "SDL_RWFromMem",
    "SDL_RaiseWindow",
    "SDL_ReadBE16",
    "SDL_ReadBE32",
    "SDL_ReadBE64",
    "SDL_ReadLE16",
    "SDL_ReadLE32",
    "SDL_ReadLE64",
    "SDL_ReadU8",
    "SDL_RecordGesture",
    "SDL_RegisterEvents",
    "SDL_RemoveTimer",
    "SDL_RenderClear",
    "SDL_RenderCopy",
    "SDL_RenderCopyEx",
    "SDL_RenderDrawLine",
    "SDL_RenderDrawLines",
    "SDL_RenderDrawPoint",
    "SDL_RenderDrawPoints",
    "SDL_RenderDrawRect",
    "SDL_RenderDrawRects",
    "SDL_RenderFillRect",
    "SDL_RenderFillRects",
    "SDL_RenderGetClipRect",
    "SDL_RenderGetLogicalSize",
    "SDL_RenderGetScale",
    "SDL_RenderGetViewport",
    "SDL_RenderPresent",
    "SDL_RenderReadPixels",
    "SDL_RenderSetClipRect",
    "SDL_RenderSetLogicalSize",
    "SDL_RenderSetScale",
    "SDL_RenderSetViewport",
    "SDL_RenderTargetSupported",
    "SDL_ReportAssertion",
    "SDL_ResetAssertionReport",
    "SDL_RestoreWindow",
    "SDL_SaveAllDollarTemplates",
    "SDL_SaveDollarTemplate",
    "SDL_SemPost",
    "SDL_SemTryWait",
    "SDL_SemValue",
    "SDL_SemWait",
    "SDL_SemWaitTimeout",
    "SDL_SetAssertionHandler",
    "SDL_SetClipRect",
    "SDL_SetColorKey",
    "SDL_SetCursor",
    "SDL_SetError",
    "SDL_SetEventFilter",
    "SDL_SetHint",
    "SDL_SetHintWithPriority",
    "SDL_SetMainReady",
    "SDL_SetModState",
    "SDL_SetPaletteColors",
    "SDL_SetPixelFormatPalette",
    "SDL_SetRelativeMouseMode",
    "SDL_SetRenderDrawBlendMode",
    "SDL_SetRenderDrawColor",
    "SDL_SetRenderTarget",
    "SDL_SetSurfaceAlphaMod",
    "SDL_SetSurfaceBlendMode",
    "SDL_SetSurfaceColorMod",
    "SDL_SetSurfacePalette",
    "SDL_SetSurfaceRLE",
    "SDL_SetTextInputRect",
    "SDL_SetTextureAlphaMod",
    "SDL_SetTextureBlendMode",
    "SDL_SetTextureColorMod",
    "SDL_SetThreadPriority",
    "SDL_SetWindowBordered",
    "SDL_SetWindowBrightness",
    "SDL_SetWindowData",
    "SDL_SetWindowDisplayMode",
    "SDL_SetWindowFullscreen",
    "SDL_SetWindowGammaRamp",
    "SDL_SetWindowGrab",
    "SDL_SetWindowIcon",
    "SDL_SetWindowMaximumSize",
    "SDL_SetWindowMinimumSize",
    "SDL_SetWindowPosition",
    "SDL_SetWindowShape",
    "SDL_SetWindowSize",
    "SDL_SetWindowTitle",
    "SDL_ShowCursor",
    "SDL_ShowMessageBox",
    "SDL_ShowSimpleMessageBox",
    "SDL_ShowWindow",
    "SDL_SoftStretch",
    "SDL_StartTextInput",
    "SDL_StopTextInput",
    "SDL_TLSCreate",
    "SDL_TLSGet",
    "SDL_TLSSet",
    "SDL_ThreadID",
    "SDL_TryLockMutex",
    "SDL_UnionRect",
    "SDL_UnloadObject",
    "SDL_UnlockAudio",
    "SDL_UnlockAudioDevice",
    "SDL_UnlockMutex",
    "SDL_UnlockSurface",
    "SDL_UnlockTexture",
    "SDL_UpdateTexture",
    "SDL_UpdateWindowSurface",
    "SDL_UpdateWindowSurfaceRects",
    "SDL_UpdateYUVTexture",
    "SDL_UpperBlit",
    "SDL_UpperBlitScaled",
    "SDL_VideoInit",
    "SDL_VideoQuit",
    "SDL_WaitEvent",
    "SDL_WaitEventTimeout",
    "SDL_WaitThread",
    "SDL_WarpMouseInWindow",
    "SDL_WasInit",
    "SDL_WriteBE16",
    "SDL_WriteBE32",
    "SDL_WriteBE64",
    "SDL_WriteLE16",
    "SDL_WriteLE32",
    "SDL_WriteLE64",
    "SDL_WriteU8",
    "SDL_abs",
    "SDL_acos",
    "SDL_asin",
    "SDL_atan",
    "SDL_atan2",
    "SDL_atof",
    "SDL_atoi",
    "SDL_calloc",
    "SDL_ceil",
    "SDL_copysign",
    "SDL_cos",
    "SDL_cosf",
    "SDL_fabs",
    "SDL_floor",
    "SDL_free",
    "SDL_getenv",
    "SDL_iconv",
    "SDL_iconv_close",
    "SDL_iconv_open",
    "SDL_iconv_string",
    "SDL_isdigit",
    "SDL_isspace",
    "SDL_itoa",
    "SDL_lltoa",
    "SDL_log",
    "SDL_ltoa",
    "SDL_malloc",
    "SDL_memcmp",
    "SDL_memcpy",
    "SDL_memmove",
    "SDL_memset",
    "SDL_pow",
    "SDL_qsort",
    "SDL_realloc",
    "SDL_scalbn",
    "SDL_setenv",
    "SDL_sin",
    "SDL_sinf",
    "SDL_snprintf",
    "SDL_sqrt",
    "SDL_sscanf",
    "SDL_strcasecmp",
    "SDL_strchr",
    "SDL_strcmp",
    "SDL_strdup",
    "SDL_strlcat",
    "SDL_strlcpy",
    "SDL_strlen",
    "SDL_strlwr",
    "SDL_strncasecmp",
    "SDL_strncmp",
    "SDL_strrchr",
    "SDL_strrev",
    "SDL_strstr",
    "SDL_strtod",
    "SDL_strtol",
    "SDL_strtoll",
    "SDL_strtoul",
    "SDL_strtoull",
    "SDL_strupr",
    "SDL_tolower",
    "SDL_toupper",
    "SDL_uitoa",
    "SDL_ulltoa",
    "SDL_ultoa",
    "SDL_utf8strlcpy",
    "SDL_vsnprintf",
    "SDL_vsscanf",
    "SDL_wcslcat",
    "SDL_wcslcpy",
    "SDL_wcslen",
};

asm(
".text\n"
".globl open64\n"
".type open64, @function\n"
"open64:\n"
     "orl $0100000,8(%esp)\n"
     "call 1f\n"
     "1: pop %eax\n"
     "addl $_GLOBAL_OFFSET_TABLE_+(.-1b), %eax\n"
     "jmp *open@GOT(%eax)\n"
".size open64,.-open64\n"
);

static int (*unixFullPathname)(sqlite3_vfs*, const char *zName, int nOut, char *zOut);
static int my_xFullPathname(sqlite3_vfs* pVfs, const char *zName, int nOut, char *zOut) {
    char buf[1024] = {0};
    DOS2MacPath(zName, buf);
    return unixFullPathname(pVfs, buf, nOut, zOut);
}

static int auto_extension_cb(sqlite3 *db, [[maybe_unused]] const char **pzErrMsg, [[maybe_unused]] const struct sqlite3_api_routines *pThunk) {
    char *errmsg;
    if (sqlite3_exec(db,
            "PRAGMA synchronous=OFF;"
            , nullptr, nullptr, &errmsg)) {
        fprintf(stderr, "[CBP] error setting sqlite optimization pragmas: %s\n", errmsg);
        sqlite3_free(errmsg);
    }
    return 0;
}

static int my_LinuxConvertRelativeWinDLLPathToAbsoluteLinuxSoPath(const char *path, std::string &out) {
    out.clear();
    if (path[0] == '\\') {
        size_t len = strlen(path);
        size_t bn = 0;
        out.resize(len);
        for (size_t i = 0; i < len; i++) {
            if (path[i] == '\\') {
                out[i] = '/';
                bn = i + 1;
            } else {
                out[i] = path[i];
            }
        }
        const char cvgc[] = "CvGameCore";
        if (!strncasecmp(path+bn, cvgc, sizeof(cvgc)-1) && out.substr(out.size()-4) == ".dll") {
            out.replace(out.size()-3, 3, "so");
            out.replace(bn, sizeof(cvgc)-1, "libcvgamecoredll");
        }
    } else {
        std::array lib_map{
            std::make_pair("Assets\\DLC\\Expansion2\\CvGameCore_Expansion2.dll", "../libCvGameCoreDLL_Expansion2.so"),
            std::make_pair("Assets\\DLC\\Expansion\\CvGameCore_Expansion1.dll", "../libCvGameCoreDLL_Expansion1.so"),
            std::make_pair("CvGameCoreDLL.dll", "../libCvGameCoreDLL.so"),
        };
        for (auto [orig, new_] : lib_map) {
            if (!strcasecmp(path, orig)) {
                out.assign(new_);
                break;
            }
        }
    }
    fprintf(stderr, "[CBP] mapped dll `%s' to so `%s'\n", path, out.c_str());
    return !out.empty();
}

static int (*new_SDL_Init)(int flags);

static int my_SDL_Init(int flags) {
#define SDL_INIT_JOYSTICK       0x00000200u
#define SDL_INIT_HAPTIC         0x00001000u
#define SDL_INIT_GAMECONTROLLER 0x00002000u
    int new_flags = flags & ~(SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC | SDL_INIT_GAMECONTROLLER);
    if (new_flags != flags)
        fputs("[CBP] Disabling SDL joystick/haptic/controller support\n", stderr);
    return new_SDL_Init(new_flags);
}

static void replace_func(void *orig, void *new_, CF_insn c) {
    auto orig_ = static_cast<char *>(orig);
    size_t offset = static_cast<char *>(new_) - orig_ - 5;
    orig_[0] = c;
    memcpy(orig_+1, &offset, 4);
}

static void *find_sym(void *lib, const char *type, const char *sym) {
    void *out = dlsym(lib, sym);
    if (!out) errx(1, "finding %s %s: %s", type, sym, dlerror());
    return out;
}

static std::pair<void*,void*> find_syms(void *lib, const char *sym) {
    return {find_sym(exe, "orig", sym), find_sym(lib, "new", sym)};
}

extern "C" {
static __attribute__((used)) void hook() {
    std::vector<std::pair<void *, void *>> funcs_addrs;
    std::vector<void *> funcs_del_addrs;
    std::pair<void*,void*> sqlite_version_addrs;
    size_t new_sqlite_version_size = 0;
    void *sqlite3 = nullptr;

    exe = dlopen(NULL, RTLD_LAZY);

    funcs_addrs.push_back({
        find_sym(exe, "orig", "_ZN8GameCore51LinuxConvertRelativeWinDLLPathToAbsoluteLinuxSoPathEPKcRNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE"),
        reinterpret_cast<void *>(my_LinuxConvertRelativeWinDLLPathToAbsoluteLinuxSoPath)
    });

    char *no_system = getenv("CBP_NO_SYSTEM");
    if (!(no_system && no_system[0])) {
        fputs("[CBP] Updating internal SQLite and SDL2, export CBP_NO_SYSTEM=1 to disable\n", stderr);

        sqlite3 = dlopen("libsqlite3.so.0", RTLD_LAZY);
        if (sqlite3) {
            for (auto sym : sqlite3_funcs)
                funcs_addrs.push_back(find_syms(sqlite3, sym));
            for (auto sym : sqlite3_funcs_opt) {
                void *orig = find_sym(exe, "orig", sym);
                void *new_ = dlsym(sqlite3, sym);
                if (new_)
                    funcs_addrs.push_back({orig, new_});
                else
                    funcs_del_addrs.push_back(orig);
            }

            sqlite_version_addrs = find_syms(sqlite3, "sqlite3_version");
            new_sqlite_version_size = strlen(static_cast<const char *>(sqlite_version_addrs.second));
            if (new_sqlite_version_size > 6)
                fprintf(stderr, "[CBP] truncating sqlite3_version\n");
        } else {
            warnx("loading sqlite3: %s", dlerror());
        }

        void *sdl2 = dlopen("libSDL2-2.0.so.0", RTLD_LAZY);
        if (sdl2) {
            for (auto sym : sdl2_funcs) {
                if (!strcmp(sym, "SDL_Init")) {
                    funcs_addrs.push_back({find_sym(exe, "orig", sym), (void *)my_SDL_Init});
                    new_SDL_Init = (int (*)(int))find_sym(sdl2, "new", sym);
                } else {
                    funcs_addrs.push_back(find_syms(sdl2, sym));
                }
            }
        } else {
            warnx("loading sdl2: %s", dlerror());
        }

        funcs_addrs.push_back({find_sym(exe, "orig", "_stricmp"), reinterpret_cast<void *>(strcasecmp)});
        funcs_addrs.push_back({find_sym(exe, "orig", "_strnicmp"), reinterpret_cast<void *>(strncasecmp)});
    }

    if (mprotect(CIV5_BASE_ADDR, CIV5_TEXT_SIZE + CIV5_RODATA_SIZE, PROT_READ|PROT_WRITE))
        err(1, "mprotect rw");

    for (auto [orig, new_] : funcs_addrs) replace_func(orig, new_, JMP_REL);
    for (auto orig : funcs_del_addrs) *static_cast<short *>(orig) = 0x0b0f; // ud2
    if (sqlite3) {
        memcpy(sqlite_version_addrs.first, sqlite_version_addrs.second, 6);
        if (new_sqlite_version_size > 6)
            strcpy(strrchr(static_cast<char *>(sqlite_version_addrs.first), '.'), "+");
    }

    memcpy(reinterpret_cast<void *>(main), old_main, 5);

    if (mprotect(CIV5_BASE_ADDR, CIV5_TEXT_SIZE, PROT_READ|PROT_EXEC))
        err(1, "mprotect rx");

    if (mprotect(reinterpret_cast<void *>(reinterpret_cast<uintptr_t>(CIV5_BASE_ADDR) + CIV5_TEXT_SIZE), CIV5_RODATA_SIZE, PROT_READ))
        err(1, "mprotect r");

    fprintf(stderr, "[CBP] Redirected %zu and deleted %zu functions\n", funcs_addrs.size(), funcs_del_addrs.size());

    if (sqlite3) {
        // initialize sqlite3 before calling sqlite3_vfs_find
        if (sqlite3_initialize())
            errx(1, "failed to initialize sqlite3");

        sqlite3_vfs *vfs = sqlite3_vfs_find(nullptr);

        // shutdown sqlite3 before calling sqlite3_config
        if (sqlite3_shutdown())
            errx(1, "failed to shutdown sqlite3");

        unixFullPathname = vfs->xFullPathname;
        do {
            vfs->xFullPathname = my_xFullPathname;
        } while ((vfs = vfs->pNext));

        fprintf(stderr, "[CBP] Optimizing sqlite\n");

        if (sqlite3_config(SQLITE_CONFIG_MMAP_SIZE, (int64_t)0x10000000, (int64_t)-1))
            errx(1, "failed to set mmap size");

        if (sqlite3_auto_extension(reinterpret_cast<void (*)()>(auto_extension_cb)))
            errx(1, "failed to register auto extension");
    }

    fprintf(stderr, "[CBP] Finished pre-initialization.\n");
}
}

__attribute__((naked))
static void main_hook(void) {
    asm(
        "subl $5,(%esp)\n"
        "jmp hook\n"
    );
}

__attribute__((constructor))
static void init() {
    static char msg[] = "[CBP] Start pre-initialization\n";
    (void)!write(2, msg, sizeof(msg));
    if (mprotect(CIV5_BASE_ADDR, CIV5_TEXT_SIZE, PROT_READ|PROT_WRITE))
        err(1, "mprotect rw");
    memcpy(old_main, reinterpret_cast<void *>(main), 5);
    replace_func(reinterpret_cast<void *>(main), reinterpret_cast<void *>(main_hook), CALL_REL);
    if (mprotect(CIV5_BASE_ADDR, CIV5_TEXT_SIZE, PROT_READ|PROT_EXEC))
        err(1, "mprotect rx");
}
