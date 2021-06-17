import ./glib

const libName = "libarrow-glib.so"

type 
  GArrowBuffer = object 
  GArrowBufferPtr* = ptr GArrowBuffer

{.push dynlib: libName.}  

proc bufferNew*(data: pointer, size: int64): GArrowBufferPtr 
  {.importc: "garrow_buffer_new".}

proc bufferNewBytes*(data: GBytesPtr): GArrowBufferPtr
  {.importc: "garrow_buffer_new_bytes".}

proc bufferEqual*(buffer: GArrowBufferPtr, 
                  otherBuffer: GArrowBufferPtr): bool
                  {.importc: "garrow_buffer_equal".}

proc bufferEqualNBytes*(buffer: GArrowBufferPtr, 
                        otherBuffer: GArrowBufferPtr, nBytes: int64): bool      
                        {.importc: "garrow_buffer_equal_n_bytes".}                                    
                 
proc bufferIsMutable*(buffer: GArrowBufferPtr): bool
  {.importc: "garrow_buffer_is_mutable".}

proc bufferGetCapacity*(buffer: GArrowBufferPtr): int64
  {.importc: "garrow_buffer_get_capacity".}

proc bufferGetData*(buffer: GArrowBufferPtr): GBytesPtr
  {.importc: "garrow_buffer_get_data".}

proc bufferGetMutableData*(buffer: GArrowBufferPtr): GBytesPtr
  {.importc: "garrow_buffer_get_mutable_data".}

proc bufferGetSize*(buffer: GArrowBufferPtr): int64
  {.importc: "garrow_buffer_get_size".}

proc bufferGetParent*(buffer: GArrowBufferPtr): GArrowBufferPtr
  {.importc: "garrow_buffer_get_parent".}

proc bufferCopy*(buffer: GArrowBufferPtr, start: int64, size: int64,
                 error: var GErrorPtr): GArrowBufferPtr
                 {.importc: "garrow_buffer_copy".}

proc bufferSlice*(buffer: GArrowBufferPtr, offset: int64, 
                 size: int64): GArrowBufferPtr
                 {.importc: "garrow_buffer_slice".}

proc mutableBufferNew*(data: ptr uint8, size: int64): GArrowBufferPtr
  {.importc: "garrow_mutable_buffer_new".}

proc mutableBufferNewBytes*(data: GBytesPtr): GArrowBufferPtr
  {.importc: "garrow_mutable_buffer_new_bytes".}

proc mutableBufferSlice*(buffer: GArrowBufferPtr, offset: int64,
                         size: int64): GArrowBufferPtr
                         {.importc: "garrow_mutable_buffer_slice".}

proc mutableBufferSetData*(buffer: GArrowBufferPtr, offset: int64,
                           data: ptr uint8, size: int64, 
                           error: var GErrorPtr): bool
                           {.importc: "garrow_mutable_buffer_set_data".}

proc resizableBufferNew*(initialSize: int64, error: var GErrorPtr): GArrowBufferPtr
  {.importc: "garrow_resizable_buffer_new".}

proc resizableBufferResize*(buffer: GArrowBufferPtr, newSize: int64,
                            error: var GErrorPtr): bool     
                            {.importc: "garrow_resizable_buffer_resize".}                                                                              

proc resizableBufferReserve*(buffer: GArrowBufferPtr, newCapacity: int64,
                             error: var GErrorPtr): bool    
                             {.importc: "garrow_resizable_buffer_reserve".}
                                                  
{.pop.}