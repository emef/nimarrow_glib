import ./arrays
import ./glib

const libName = "libarrow-glib.so"

type
  GArrowField = object
  GArrowFieldPtr* = ptr GArrowField

  GArrowSchema = object
  GArrowSchemaPtr* = ptr GArrowSchema

{.push dynlib: libName.}

proc fieldNew*(name: cstring, dataType: GArrowDataTypePtr): GArrowFieldPtr
  {.importc: "garrow_field_new".}

proc fieldNewFull*(name: cstring, dataType: GArrowDataTypePtr,
                   nullable: bool): GArrowFieldPtr
                   {.importc: "garrow_field_new_full".}

proc fieldGetName*(field: GArrowFieldPtr): cstring
  {.importc: "garrow_field_get_name".}

proc fieldGetDataType*(field: GArrowFieldPtr): GArrowDataTypePtr
  {.importc: "garrow_field_get_data_type".}

proc fieldIsNullable*(field: GArrowFieldPtr): bool
  {.importc: "garrow_field_is_nullable".}

proc fieldEqual*(field: GArrowFieldPtr, otherField: GArrowFieldPtr): bool
  {.importc: "garrow_field_equal".}

proc fieldToString*(field: GArrowFieldPtr): cstring
  {.importc: "garrow_field_to_string".}

proc fieldToStringMetadata*(field: GArrowFieldPtr, showMetadata: bool): cstring
  {.importc: "garrow_field_to_string_metadata".}

proc fieldHasMetadata*(field: GArrowFieldPtr): bool
  {.importc: "garrow_field_has_metadata".}

proc fieldRemoveMetadata*(field: GArrowFieldPtr): GArrowFieldPtr
  {.importc: "garrow_field_remove_metadata".}

proc schemaNew*(fields: GListPtr): GArrowSchemaPtr
  {.importc: "garrow_schema_new".}

proc schemaEqual*(schema: GArrowSchemaPtr,
                  otherSchema: GArrowSchemaPtr): bool
                  {.importc: "garrow_schema_equal".}

proc schemaGetField*(schema: GArrowSchemaPtr, i: uint): GArrowFieldPtr
  {.importc: "garrow_schema_get_field".}

proc schemaGetFieldByName*(schema: GArrowSchemaPtr,
                           name: cstring): GArrowFieldPtr
                           {.importc: "garrow_schema_get_field_by_name".}

proc schemaGetFieldIndex*(schema: GArrowSchemaPtr,
                          name: cstring): int
                           {.importc: "garrow_schema_get_field_index".}

proc schemaNFields*(schema: GArrowSchemaPtr): uint
  {.importc: "garrow_schema_n_fields".}

proc schemaGetFields*(schema: GArrowSchemaPtr): GListPtr
  {.importc: "garrow_schema_get_fields".}

proc schemaToString*(schema: GArrowSchemaPtr): cstring
  {.importc: "garrow_schema_to_string".}

proc schemaToStringMetadata*(schema: GArrowSchemaPtr,
                             showMetadata: bool): cstring
                             {.importc: "garrow_schema_to_string_metadata".}

proc schemaAddField*(schema: GArrowSchemaPtr, i: uint, field: GArrowFieldPtr,
                     error: var GErrorPtr): GArrowSchemaPtr
                     {.importc: "garrow_schema_add_field".}

proc schemaRemoveField*(schema: GArrowSchemaPtr, i: uint,
                        error: var GErrorPtr): GArrowSchemaPtr
                        {.importc: "garrow_schema_remove_field".}

proc schemaReplaceField*(schema: GArrowSchemaPtr, i: uint,
                         field: GArrowFieldPtr,
                         error: var GErrorPtr): GArrowSchemaPtr
                         {.importc: "garrow_schema_replace_field".}

proc schemaHasMetadata*(schema: GArrowSchemaPtr): bool
  {.importc: "garrow_schema_has_metadata".}

#[

skipped:

GHashTable *
garrow_field_get_metadata (GArrowField *field);

GArrowField *
garrow_field_with_metadata (GArrowField *field,
                            GHashTable *metadata);

GArrowField *
garrow_field_with_merged_metadata (GArrowField *field,
                                   GHashTable *metadata);

GHashTable *
garrow_schema_get_metadata (GArrowSchema *schema);

GArrowSchema *
garrow_schema_with_metadata (GArrowSchema *schema,
                             GHashTable *metadata);
]#

{.pop.}