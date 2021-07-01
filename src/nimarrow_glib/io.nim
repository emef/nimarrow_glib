import ./buffers
import ./codecs
import ./glib

const libName = "libarrow-glib.so"

type
  GArrowInputStream = object
  GArrowInputStreamPtr* = ptr GArrowInputStream

  GArrowOutputStream = object
  GArrowOutputStreamPtr* = ptr GArrowOutputStream

{.push dynlib: libName.}

proc inputStreamAdvance*(
    inputStream: ptr GArrowInputStream; nBytes: int64;
    error: var GErrorPtr): bool {.
    importc: "garrow_input_stream_advance".}

proc inputStreamAlign*(
    inputStream: GArrowInputStreamPtr; alignment: int32;
    error: var GErrorPtr): bool {.
    importc: "garrow_input_stream_align".}

#[

TODO: tensors

proc inputStreamReadTensor*(
    inputStream: GArrowInputStreamPtr;
    error: var GErrorPtr): GArrowTensorPtr {.
    importc: "garrow_input_stream_read_tensor".}

TODO: record batches

proc inputStreamReadRecordBatch*(
    inputStream: GArrowInputStreamPtr;
    schema: GArrowSchemaPtr;
    options: ptr GArrowReadOptions;
    error: var GErrorPtr): GArrowRecordBatchPtr {.
    importc: "garrow_input_stream_read_record_batch".}

]#

proc seekableInputStreamGetSize*(
    inputStream: GArrowInputStreamPtr;
    error: var GErrorPtr): uint64 {.
    importc: "garrow_seekable_input_stream_get_size".}

proc seekableInputStreamGetSupportZeroCopy*(
    inputStream: GArrowInputStreamPtr): bool {.
    importc: "garrow_seekable_input_stream_get_support_zero_copy".}

proc seekableInputStreamReadAt*(
    inputStream: GArrowInputStreamPtr;
    position: int64; nBytes: int64;
    error: var GErrorPtr): GArrowBufferPtr {.
    importc: "garrow_seekable_input_stream_read_at".}

proc seekableInputStreamReadAtBytes*(
    inputStream: GArrowInputStreamPtr; position: int64; nBytes: int64;
    error: var GErrorPtr): GBytesPtr
    {.importc: "garrow_seekable_input_stream_read_at_bytes".}

proc seekableInputStreamPeek*(
    inputStream: GArrowInputStreamPtr;
    nBytes: int64; error: var GErrorPtr): GBytesPtr {.
    importc: "garrow_seekable_input_stream_peek".}

proc bufferInputStreamNew*(buffer: GArrowBufferPtr): GArrowInputStreamPtr {.
    importc: "garrow_buffer_input_stream_new".}

proc bufferInputStreamGetBuffer*(
    inputStream: GArrowInputStreamPtr): GArrowBufferPtr {.
    importc: "garrow_buffer_input_stream_get_buffer".}

proc memoryMappedInputStreamNew*(
    path: cstring; error: var GErrorPtr): GArrowInputStreamPtr {.
    importc: "garrow_memory_mapped_input_stream_new".}

proc compressedInputStreamNew*(
    codec: GArrowCodecPtr;
    raw: GArrowInputStreamPtr;
    error: var GErrorPtr): GArrowInputStreamPtr {.
    importc: "garrow_compressed_input_stream_new".}

proc outputStreamAlign*(
    stream: GArrowOutputStreamPtr; alignment: int32;
    error: var GErrorPtr): bool {.
    importc: "garrow_output_stream_align".}

#[

TODO: tensor/record batch

proc outputStreamWriteTensor*(
    stream: GArrowOutputStreamPtr;
    tensor: GArrowTensorPtr; error: var GErrorPtr): Gint64 {.
    importc: "garrow_output_stream_write_tensor".}

proc outputStreamWriteRecordBatch*(
    stream: GArrowOutputStreamPtr;
    recordBatch: GArrowRecordBatchPtr;
    options: GArrowWriteOptionsPtr;
    error: var GErrorPtr): Gint64 {.
    importc: "garrow_output_stream_write_record_batch".}
]#

proc fileOutputStreamNew*(
    path: cstring; append: bool;
    error: var GErrorPtr): GArrowOutputStreamPtr {.
    importc: "garrow_file_output_stream_new".}

proc bufferOutputStreamNew*(buffer: GArrowBufferPtr): GArrowOutputStreamPtr {.
    importc: "garrow_buffer_output_stream_new".}

proc compressedOutputStreamNew*(
    codec: GArrowCodecPtr;
    raw: GArrowOutputStreamPtr;
    error: var GErrorPtr): GArrowOutputStreamPtr {.
    importc: "garrow_compressed_output_stream_new".}

{.pop.}
