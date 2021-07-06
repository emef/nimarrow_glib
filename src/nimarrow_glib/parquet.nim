import ./arrays
import ./codecs
import ./glib
import ./io
import ./schemas
import ./tables

const libName = "libparquet-glib.so"

type
  GParquetArrowFileReader = object
  GParquetArrowFileReaderPtr* = ptr GParquetArrowFileReader

  GParquetArrowFileWriter = object
  GParquetArrowFileWriterPtr* = ptr GParquetArrowFileWriter

  GParquetWriterProperties = object
  GParquetWriterPropertiesPtr* = ptr GParquetWriterProperties

{.push dynlib: libName.}

proc writerPropertiesNew*(): GParquetWriterPropertiesPtr
    {.importc: "gparquet_writer_properties_new".}

proc writerPropertiesSetCompression*(
    properties: GParquetWriterPropertiesPtr;
    compressionType: GArrowCompressionType; path: cstring)
    {.importc: "gparquet_writer_properties_set_compression".}

proc writerPropertiesGetCompressionPath*(
    properties: GParquetWriterPropertiesPtr; path: cstring): GArrowCompressionType
    {.importc: "gparquet_writer_properties_get_compression_path".}

proc writerPropertiesEnableDictionary*(
    properties: GParquetWriterPropertiesPtr; path: cstring)
    {.importc: "gparquet_writer_properties_enable_dictionary".}

proc writerPropertiesDisableDictionary*(
    properties: GParquetWriterPropertiesPtr; path: cstring)
    {.importc: "gparquet_writer_properties_disable_dictionary".}

proc writerPropertiesIsDictionaryEnabled*(
    properties: GParquetWriterPropertiesPtr; path: cstring): bool
    {.importc: "gparquet_writer_properties_is_dictionary_enabled".}

proc writerPropertiesSetDictionaryPageSizeLimit*(
    properties: GParquetWriterPropertiesPtr; limit: int64)
    {.importc: "gparquet_writer_properties_set_dictionary_page_size_limit".}

proc writerPropertiesGetDictionaryPageSizeLimit*(
    properties: GParquetWriterPropertiesPtr): int64
    {.importc: "gparquet_writer_properties_get_dictionary_page_size_limit".}

proc writerPropertiesSetBatchSize*(
    properties: GParquetWriterPropertiesPtr; batchSize: int64)
    {.importc: "gparquet_writer_properties_set_batch_size".}

proc writerPropertiesGetBatchSize*(
    properties: GParquetWriterPropertiesPtr): int64
    {.importc: "gparquet_writer_properties_get_batch_size".}

proc writerPropertiesSetMaxRowGroupLength*(
    properties: GParquetWriterPropertiesPtr; length: int64)
    {.importc: "gparquet_writer_properties_set_max_row_group_length".}

proc writerPropertiesGetMaxRowGroupLength*(
    properties: GParquetWriterPropertiesPtr): int64
    {.importc: "gparquet_writer_properties_get_max_row_group_length".}

proc writerPropertiesSetDataPageSize*(
    properties: GParquetWriterPropertiesPtr; dataPageSize: int64)
    {.importc: "gparquet_writer_properties_set_data_page_size".}

proc writerPropertiesGetDataPageSize*(
    properties: GParquetWriterPropertiesPtr): int64
    {.importc: "gparquet_writer_properties_get_data_page_size".}

proc parquetFileWriterNewArrow*(
    schema: GArrowSchemaPtr;
    sink: GArrowOutputStreamPtr;
    writerProperties: GParquetWriterPropertiesPtr;
    error: var GErrorPtr): GParquetArrowFileWriterPtr
    {.importc: "gparquet_arrow_file_writer_new_arrow".}

proc parquetFileWriterNewPath*(
    schema: GArrowSchemaPtr; path: cstring;
    writerProperties: GParquetWriterPropertiesPtr;
    error: var GErrorPtr): GParquetArrowFileWriterPtr
    {.importc: "gparquet_arrow_file_writer_new_path".}

proc parquetFileWriterWriteTable*(
    writer: GParquetArrowFileWriterPtr;
    table: GArrowTablePtr; chunkSize: uint64;
    error: var GErrorPtr): bool
    {.importc: "gparquet_arrow_file_writer_write_table".}

proc parquetFileWriterClose*(
    writer: GParquetArrowFileWriterPtr;
    error: var GErrorPtr): bool
    {.importc: "gparquet_arrow_file_writer_close".}

proc parquetFileReaderNewArrow*(
    source: GArrowInputStreamPtr;
    error: var GErrorPtr): GParquetArrowFileReaderPtr
    {.importc: "gparquet_arrow_file_reader_new_arrow".}

proc parquetFileReaderNewPath*(
    path: cstring; error: var GErrorPtr): GParquetArrowFileReaderPtr
    {.importc: "gparquet_arrow_file_reader_new_path".}

proc parquetFileReaderReadTable*(
    reader: GParquetArrowFileReaderPtr;
    error: var GErrorPtr): GArrowTablePtr
    {.importc: "gparquet_arrow_file_reader_read_table".}

proc parquetFileReaderReadRowGroup*(
    reader: GParquetArrowFileReaderPtr;
    rowGroupIndex: int;
    columnIndices: ptr UncheckedArray[int];
    nColumnIndices: uint64;
    error: var GErrorPtr): GArrowTablePtr
    {.importc: "gparquet_arrow_file_reader_read_row_group".}

proc parquetFileReaderGetSchema*(
    reader: GParquetArrowFileReaderPtr;
    error: var GErrorPtr): GArrowSchemaPtr
    {.importc: "gparquet_arrow_file_reader_get_schema".}

proc parquetFileReaderReadColumnData*(
    reader: GParquetArrowFileReaderPtr;
    i: int;
    error: var GErrorPtr): GArrowChunkedArrayPtr
    {.importc: "gparquet_arrow_file_reader_read_column_data".}

proc parquetFileReaderGetNRowGroups*(reader: GParquetArrowFileReaderPtr): int
    {.importc: "gparquet_arrow_file_reader_get_n_row_groups".}

proc parquetFileReaderSetUseThreads*(
    reader: GParquetArrowFileReaderPtr; useThreads: bool)
    {.importc: "gparquet_arrow_file_reader_set_use_threads".}

{.pop.}
