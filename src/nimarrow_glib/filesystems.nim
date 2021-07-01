import ./glib
import ./io

const libName = "libarrow-glib.so"

type
  GArrowFileInfo = object
  GArrowFileInfoPtr* = ptr GArrowFileInfo

  GArrowFileSystem = object
  GArrowFileSystemPtr* = ptr GArrowFileSystem

  GArrowFileSelector = object
  GArrowFileSelectorPtr* = ptr GArrowFileSelector

  GArrowLocalFileSystemOptions = object
  GArrowLocalFileSystemOptionsPtr = ptr GArrowLocalFileSystemOptions

  GArrowTimePoint* = int64

  GArrowFileType* = enum
    GARROW_FILE_TYPE_NOT_FOUND, GARROW_FILE_TYPE_UNKNOWN, GARROW_FILE_TYPE_FILE,
    GARROW_FILE_TYPE_DIR

{.push dynlib: libName.}

proc fileInfoNew*(): GArrowFileInfoPtr {.importc: "garrow_file_info_new".}

proc fileInfoEqual*(
    fileInfo: GArrowFileInfoPtr;
    otherFileInfo: GArrowFileInfoPtr): bool {.
    importc: "garrow_file_info_equal".}

proc fileInfoIsFile*(fileInfo: GArrowFileInfoPtr): bool {.
    importc: "garrow_file_info_is_file".}

proc fileInfoIsDir*(fileInfo: GArrowFileInfoPtr): bool {.
    importc: "garrow_file_info_is_dir".}

proc fileInfoToString*(fileInfo: GArrowFileInfoPtr): cstring {.
    importc: "garrow_file_info_to_string".}

proc fileSystemCreate*(uri: cstring; error: var GErrorPtr): GArrowFileSystemPtr {.
    importc: "garrow_file_system_create".}

proc fileSystemGetTypeName*(fileSystem: GArrowFileSystemPtr): cstring {.
    importc: "garrow_file_system_get_type_name".}

proc fileSystemGetFileInfo*(
    fileSystem: GArrowFileSystemPtr; path: cstring;
    error: var GErrorPtr): GArrowFileInfoPtr {.
    importc: "garrow_file_system_get_file_info".}

proc fileSystemGetFileInfosPaths*(
    fileSystem: GArrowFileSystemPtr;
    paths: cstring; nPaths: uint64;
    error: var GErrorPtr): GListPtr {.
    importc: "garrow_file_system_get_file_infos_paths".}

proc fileSystemGetFileInfosSelector*(
    fileSystem: GArrowFileSystemPtr;
    fileSelector: GArrowFileSelectorPtr;
    error: var GErrorPtr): GListPtr {.
    importc: "garrow_file_system_get_file_infos_selector".}

proc fileSystemCreateDir*(
    fileSystem: GArrowFileSystemPtr; path: cstring;
    recursive: bool; error: var GErrorPtr): bool {.
    importc: "garrow_file_system_create_dir".}

proc fileSystemDeleteDir*(
    fileSystem: GArrowFileSystemPtr; path: cstring;
    error: var GErrorPtr): bool {.
    importc: "garrow_file_system_delete_dir".}

proc fileSystemDeleteDirContents*(
    fileSystem: GArrowFileSystemPtr;
    path: cstring;
    error: var GErrorPtr): bool {.
    importc: "garrow_file_system_delete_dir_contents".}

proc fileSystemDeleteFile*(
    fileSystem: GArrowFileSystemPtr;
    path: cstring;
    error: var GErrorPtr): bool {.
    importc: "garrow_file_system_delete_file".}

proc fileSystemDeleteFiles*(
    fileSystem: GArrowFileSystemPtr;
    paths: cstring; nPaths: uint64;
    error: var GErrorPtr): bool {.
    importc: "garrow_file_system_delete_files".}

proc fileSystemMove*(
    fileSystem: GArrowFileSystemPtr;
    src: cstring;
    dest: cstring; error: var GErrorPtr): bool {.
    importc: "garrow_file_system_move".}

proc fileSystemCopyFile*(
    fileSystem: GArrowFileSystemPtr;
    src: cstring;
    dest: cstring;
    error: var GErrorPtr): bool {.
    importc: "garrow_file_system_copy_file".}

proc fileSystemOpenInputStream*(
    fileSystem: GArrowFileSystemPtr;
    path: cstring;
    error: var GErrorPtr): GArrowInputStreamPtr {.
    importc: "garrow_file_system_open_input_stream".}

proc fileSystemOpenInputFile*(
    fileSystem: GArrowFileSystemPtr;
    path: cstring;
    error: var GErrorPtr): GArrowInputStreamPtr {.
    importc: "garrow_file_system_open_input_file".}

proc fileSystemOpenOutputStream*(
    fileSystem: GArrowFileSystemPtr;
    path: cstring;
    error: var GErrorPtr): GArrowOutputStreamPtr {.
    importc: "garrow_file_system_open_output_stream".}

proc fileSystemOpenAppendStream*(
    fileSystem: GArrowFileSystemPtr;
    path: cstring;
    error: var GErrorPtr): GArrowOutputStreamPtr {.
    importc: "garrow_file_system_open_append_stream".}

proc subTreeFileSystemNew*(
    basePath: cstring;
    baseFileSystem: GArrowFileSystemPtr): GArrowFileSystemPtr {.
    importc: "garrow_sub_tree_file_system_new".}

proc slowFileSystemNewAverageLatency*(
    baseFileSystem: GArrowFileSystemPtr;
    averageLatency: float64): GArrowFileSystemPtr {.
    importc: "garrow_slow_file_system_new_average_latency".}

proc slowFileSystemNewAverageLatencyAndSeed*(
    baseFileSystem: GArrowFileSystemPtr; averageLatency: float64;
    seed: int32): GArrowFileSystemPtr {.
    importc: "garrow_slow_file_system_new_average_latency_and_seed".}

proc localFileSystemOptionsNew*(): GArrowLocalFileSystemOptionsPtr {.
    importc: "garrow_local_file_system_options_new".}

proc localFileSystemNew*(
    options: GArrowLocalFileSystemOptionsPtr): GArrowFileSystemPtr {.
    importc: "garrow_local_file_system_new".}

{.pop.}