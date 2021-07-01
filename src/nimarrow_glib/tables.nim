import ./arrays, ./glib, ./schemas

const libName = "libarrow-glib.so"

type
  GArrowTable = object
  GArrowTablePtr* = ptr GArrowTable

{.push dynlib: libName.}

proc tableNewValues*(schema: GArrowSchemaPtr, values: GListPtr,
                     error: var GErrorPtr): GArrowTablePtr
                     {.importc: "garrow_table_new_values".}

proc tableNewArrays*(schema: GArrowSchemaPtr,
                     arrays: ptr UncheckedArray[GArrowArrayPtr],
                     nArrays: uint64, error: var GErrorPtr): GArrowTablePtr
                     {.importc: "garrow_table_new_arrays".}

proc tableEqual*(table: GArrowTablePtr, otherTable: GArrowTablePtr): bool
  {.importc: "garrow_table_equal".}

proc tableEqualMetadata*(table: GArrowTablePtr, otherTable: GArrowTablePtr,
                         checkMetadata: bool): bool
                         {.importc: "garrow_table_equal_metadata".}

proc tableGetSchema*(table: GArrowTablePtr): GArrowSchemaPtr
  {.importc: "garrow_table_get_schema".}

proc tableGetNColumns*(table: GArrowTablePtr): uint
  {.importc: "garrow_table_get_n_columns".}

proc tableGetNRows*(table: GArrowTablePtr): uint64
  {.importc: "garrow_table_get_n_rows".}

proc tableRemoveColumn*(table: GArrowTablePtr, i: uint,
                        error: var GErrorPtr): GArrowTablePtr
                        {.importc: "garrow_table_remove_column".}

proc tableToString*(table: GArrowTablePtr, error: var GErrorPtr): cstring
  {.importc: "garrow_table_to_string".}

proc tableConcatenate*(table: GArrowTablePtr, otherTables: GListPtr,
                       error: var GErrorPtr): GArrowTablePtr
                       {.importc: "garrow_table_concatenate".}

proc tableSlice*(table: GArrowTablePtr, offset: int64,
                 length: int64): GArrowTablePtr
                 {.importc: "garrow_table_slice".}

proc tableCombineChunks*(table: GArrowTablePtr,
                         error: var GErrorPtr): GArrowTablePtr
                         {.importc: "garrow_table_combine_chunks".}

#[

skipped:

GArrowTable *
garrow_table_new_chunked_arrays (GArrowSchema *schema,
                                 GArrowChunkedArray **chunked_arrays,
                                 gsize n_chunked_arrays,
                                 GError **error)

GArrowTable *
garrow_table_new_record_batches (GArrowSchema *schema,
                                 GArrowRecordBatch **record_batches,
                                 gsize n_record_batches,
                                 GError **error)

GArrowTable *
garrow_table_add_column (GArrowTable *table,
                         guint i,
                         GArrowField *field,
                         GArrowChunkedArray *chunked_array,
                         GError **error)

GArrowTable *
garrow_table_replace_column (GArrowTable *table,
                             guint i,
                             GArrowField *field,
                             GArrowChunkedArray *chunked_array,
                             GError **error)

GArrowChunkedArray *
garrow_table_get_column_data (GArrowTable *table,
                              gint i)

GArrowFeatherWriteProperties *
garrow_feather_write_properties_new (void)

gboolean
garrow_table_write_as_feather (GArrowTable *table,
                               GArrowOutputStream *sink,
                               GArrowFeatherWriteProperties *properties,
                               GError **error)

]#
