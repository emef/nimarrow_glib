import ./arrays
import ./glib

const libName = "libarrow-glib.so"

type 
  GArrowSchema = object
  GArrowSchemaPtr* = ptr GArrowSchema

  GArrowField = object
  GArrowFieldPtr* = ptr GArrowField

  GArrowTable = object 
  GArrowTablePtr* = ptr GArrowTable

  GArrowInt32ArrayBuilder = object 
  GArrowInt32ArrayBuilderPtr = ptr GArrowInt32ArrayBuilder

{.push dynlib: libName.}

proc newArrowSchema*(fields: GlistPtr): GArrowSchemaPtr 
                     {.importc: "garrow_schema_new".}

proc newArrowField*(name: cstring, dataType: GArrowDataTypePtr): GArrowFieldPtr 
                    {.importc: "garrow_field_new".}                  

proc newArrowTableValues*(schema: GArrowSchemaPtr, values: GListPtr, 
                          err: var GErrorPtr): GArrowTablePtr
                          {.importc: "garrow_table_new_values".}

proc newArrowInt32ArrayBuilder*(): GArrowInt32ArrayBuilderPtr
                                {.importc: "garrow_int32_array_builder_new".}                        
                             
proc append*(b: GArrowInt32ArrayBuilderPtr, value: int32, error: var GErrorPtr): bool 
             {.importc: "garrow_int32_array_builder_append".}
                            

proc finish*(b: GArrowInt32ArrayBuilderPtr, error: var GErrorPtr): GArrowArrayPtr
             {.importc: "garrow_array_builder_finish".}                            


{.pop.}