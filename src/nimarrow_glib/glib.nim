const libglib = "libglib-2.0.so"
const libgobject = "libgobject-2.0.so"

type
  GList = object
    data: pointer
    next: GListPtr
    prev: GListPtr
  GListPtr* = ptr GList

  GError* = object
    domain: uint32
    code: cint
    message*: cstring
  GErrorPtr* = ptr GError

  GBytes = object 
  GBytesPtr* = ptr GBytes


{.push dynlib: libglib.}
proc append*(list: GListPtr, data: pointer): GListPtr {.importc: "g_list_append".}

proc gfree*(data: pointer) {.importc: "g_free".}

proc gErrorFree*(error: GErrorPtr) {.importc: "g_error_free".}

{.pop.}

{.push dynlib: libgobject.}
proc gObjectUnref*(data: pointer) {.importc: "g_object_unref".}


{.pop.}