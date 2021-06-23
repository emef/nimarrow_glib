import ./glib
import ./schemas
import ./tables

const libName = "libparquet-glib.so"

type
  GParquetArrowFileWriter = object
  GParquetArrowFileWriterPtr* = ptr GParquetArrowFileWriter
  GParquetWriterProperties = object
  GParquetWriterPropertiesPtr* = ptr GParquetWriterProperties

#[
  GParquetArrowFileWriter *
gparquet_arrow_file_writer_new_path (GArrowSchema *schema,
                                     const gchar *path,
                                     GParquetWriterProperties *writer_properties,
                                     GError **error);
]#

{.push dynlib: libName.}

proc newParquetWriterProperties*(): GParquetWriterPropertiesPtr {.importc: "gparquet_writer_properties_new".}


proc newParquetFileWriterPath*(schema: GArrowSchemaPtr, path: cstring,
                               writer_properties: GParquetWriterPropertiesPtr,
                               error: var GErrorPtr): GParquetArrowFileWriterPtr
                               {.importc: "gparquet_arrow_file_writer_new_path".}


proc writeTable*(w: GParquetArrowFileWriterPtr, table: GArrowTablePtr,
                 chunkSize: uint64, error: var GErrorPtr): bool
                 {.importc: "gparquet_arrow_file_writer_write_table".}

proc close*(w: GParquetArrowFileWriterPtr, error: var GErrorPtr): bool
            {.importc: "gparquet_arrow_file_writer_close".}

{.pop.}
