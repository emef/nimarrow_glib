const libName = "libglib-2.0.so"

type
  GList = object
    data: pointer
    next: GListPtr
    prev: GListPtr
  GListPtr* = ptr GList

  GError = object
    domain: uint32
    code: cint
    message: cstring
  GErrorPtr* = ptr GError

  GBytes = object 
  GBytesPtr* = ptr GBytes


{.push dynlib: libName.}
proc append*(list: GListPtr, data: pointer): GListPtr {.importc: "g_list_append".}

proc gfree*(data: pointer) {.importc: "g_free".}

{.pop.}