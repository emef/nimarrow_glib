import ./glib

const libName = "libarrow-glib.so"

type
  GArrowCompressionType* = enum
    GARROW_COMPRESSION_TYPE_UNCOMPRESSED, GARROW_COMPRESSION_TYPE_SNAPPY,
    GARROW_COMPRESSION_TYPE_GZIP, GARROW_COMPRESSION_TYPE_BROTLI,
    GARROW_COMPRESSION_TYPE_ZSTD, GARROW_COMPRESSION_TYPE_LZ4,
    GARROW_COMPRESSION_TYPE_LZO, GARROW_COMPRESSION_TYPE_BZ2

  GArrowCodec = object
  GArrowCodecPtr* = ptr GArrowCodec

{.push dynlib: libName.}

proc garrowCodecNew*(compressionType: GArrowCompressionType;
                     error: var GErrorPtr): GArrowCodecPtr
                     {.importc: "garrow_codec_new".}

proc garrowCodecGetName*(codec: GArrowCodecPtr): cstring {.
  importc: "garrow_codec_get_name".}

proc garrowCodecGetCompressionType*(codec: GArrowCodecPtr): GArrowCompressionType
  {.importc: "garrow_codec_get_compression_type".}

proc garrowCodecGetCompressionLevel*(codec: GArrowCodecPtr): int
  {.importc: "garrow_codec_get_compression_level".}

{.pop.}
