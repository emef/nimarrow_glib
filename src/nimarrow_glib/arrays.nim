import macros

import ./buffers
import ./decimals
import ./glib
import ./helpers

const libName = "libarrow-glib.so"

type
  GArrowType* = enum
    GARROW_TYPE_NA, GARROW_TYPE_BOOLEAN, GARROW_TYPE_UINT8, GARROW_TYPE_INT8,
    GARROW_TYPE_UINT16, GARROW_TYPE_INT16, GARROW_TYPE_UINT32, GARROW_TYPE_INT32,
    GARROW_TYPE_UINT64, GARROW_TYPE_INT64, GARROW_TYPE_HALF_FLOAT,
    GARROW_TYPE_FLOAT, GARROW_TYPE_DOUBLE, GARROW_TYPE_STRING, GARROW_TYPE_BINARY,
    GARROW_TYPE_FIXED_SIZE_BINARY, GARROW_TYPE_DATE32, GARROW_TYPE_DATE64,
    GARROW_TYPE_TIMESTAMP, GARROW_TYPE_TIME32, GARROW_TYPE_TIME64,
    GARROW_TYPE_INTERVAL_MONTHS, GARROW_TYPE_INTERVAL_DAY_TIME,
    GARROW_TYPE_DECIMAL128, GARROW_TYPE_DECIMAL256, GARROW_TYPE_LIST,
    GARROW_TYPE_STRUCT, GARROW_TYPE_SPARSE_UNION, GARROW_TYPE_DENSE_UNION,
    GARROW_TYPE_DICTIONARY, GARROW_TYPE_MAP, GARROW_TYPE_EXTENSION,
    GARROW_TYPE_FIXED_SIZE_LIST, GARROW_TYPE_DURATION, GARROW_TYPE_LARGE_STRING,
    GARROW_TYPE_LARGE_BINARY, GARROW_TYPE_LARGE_LIST
  GArrowTimeUnit* = enum
    GARROW_TIME_UNIT_SECOND, GARROW_TIME_UNIT_MILLI, GARROW_TIME_UNIT_MICRO,
    GARROW_TIME_UNIT_NANO

type 
  GArrowArray = object 
  GArrowArrayPtr* = ptr GArrowArray
  
  GArrowDataType = object 
  GArrowDataTypePtr* = ptr GArrowDataType

  GArrowExtensionDataTypeRegistry = object
  GArrowExtensionDataTypeRegistryPtr* = ptr GArrowExtensionDataTypeRegistry

{.push dynlib: libName.}

proc arrayEqual*(arr: GArrowArrayPtr, arr_other: GArrowArrayPtr): bool
  {.importc: "garrow_array_equal".}

proc arrayEqualApprox*(arr: GArrowArrayPtr, arr_other: GArrowArrayPtr): bool
                       {.importc: "garrow_array_equal_approx".}
                
proc arrayEqualRange*(arr: GArrowArrayPtr, start_index: int64, 
                      arr_other: GArrowArrayPtr, other_start_index: int64,
                      end_index: int64): bool 
                      {.importc: "garrow_array_equal_range".}
                    
proc arrayIsNull*(arr: GArrowArrayPtr, i: int64): bool
  {.importc: "garrow_array_is_null".}

proc arrayIsValid*(arr: GArrowArrayPtr, i: int64): bool
  {.importc: "garrow_array_is_valid".}                

proc arrayGetLength*(arr: GArrowArrayPtr): int64  
  {.importc: "garrow_array_get_length".}                 

proc arrayGetOffset*(arr: GArrowArrayPtr): int64  
  {.importc: "garrow_array_get_offset".}  
                      
proc arrayGetNNulls*(arr: GArrowArrayPtr): int64  
  {.importc: "garrow_array_get_n_nulls".}

proc arrayGetNullBitmap*(arr: GArrowArrayPtr): GArrowBufferPtr  
  {.importc: "garrow_array_get_null_bitmap".}

proc arrayGetValueDataType*(arr: GArrowArrayPtr): GArrowDataTypePtr 
  {.importc: "garrow_array_get_value_data_type".}

proc arrayGetValueType*(arr: GArrowArrayPtr): cint 
  {.importc: "garrow_array_get_value_type".}

proc arraySlice*(arr: GArrowArrayPtr, offset: int64, 
                 length: int64): GArrowArrayPtr 
                 {.importc: "garrow_array_slice".}

proc arrayToString*(arr: GArrowArrayPtr, error: var GErrorPtr): cstring
  {.importc: "garrow_array_to_string".}

proc arrayView*(arr: GArrowArrayPtr, returnType: GArrowDataTypePtr, 
                error: var GErrorPtr): GArrowArrayPtr               
                {.importc: "garrow_array_view".}                

proc arrayDiffUnified*(arr: GArrowArrayPtr, other: GArrowArrayPtr): cstring
                       {.importc: "garrow_array_diff_unified".}                 

proc arrayConcatenate*(arr: GArrowArrayPtr, otherArrays: GListPtr, 
                       error: var GErrorPtr): GArrowArrayPtr   
                       {.importc: "garrow_array_concatenate".}               

proc nullArrayNew*(length: int64): GArrowArrayPtr
  {.importc: "garrow_null_array_new".}                   
                        
proc primitiveArrayGetDataBuffer*(arr: GArrowArrayPtr): GArrowBufferPtr
  {.importc: "garrow_primitive_array_get_data_buffer".} 

proc fixedSizeBinaryArrayNew*(dataType: GArrowDataTypePtr, length: int64,
                              data: GArrowBufferPtr, nullBitmap: GArrowBufferPtr,
                              nNulls: int64): GArrowArrayPtr
                              {.importc: "garrow_fixed_size_binary_array_new".}

proc fixedSizeBinaryArrayGetByteWidth*(arr: GArrowArrayPtr): int32
  {.importc: "garrow_fixed_size_binary_array_get_byte_width"}                                      
                         
proc fixedSizeBinaryArrayGetValue*(arr: GArrowArrayPtr, i: int64): GBytesPtr
  {.importc: "garrow_fixed_size_binary_array_get_value"} 

proc fixedSizeBinaryArrayGetValuesBytes*(arr: GArrowArrayPtr): GBytesPtr
  {.importc: "garrow_fixed_size_binary_array_get_values_bytes"} 

proc extensionArrayGetStorage*(arr: GArrowArrayPtr): GArrowArrayPtr
  {.importc: "garrow_extension_array_get_storage".}

proc dataTypeEqual*(dataType: GArrowDataTypePtr, 
                    otherDataType: GArrowDataTypePtr): bool
  {.importc: "garrow_data_type_equal".}                   

proc dataTypeToString*(dataType: GArrowDataTypePtr): cstring
  {.importc: "garrow_data_type_to_string".}

proc dataTypeGetId*(dataType: GArrowDataTypePtr): GArrowType
  {.importc: "garrow_data_type_get_id".}

proc dataTypeGetName*(dataType: GArrowDataTypePtr): cstring
  {.importc: "garrow_data_type_get_name".}

proc fixedWidthDataTypeGetBitWidth*(dataType: GArrowDataTypePtr): cint 
  {.importc: "garrow_fixed_width_data_type_get_bit_width".}

proc nullDataTypeNew*(): GArrowDataTypePtr 
  {.importc: "garrow_null_data_type_new"}

proc fixedSizeBinaryDataTypeNew*(byteWidth: int32): GArrowDataTypePtr 
  {.importc: "garrow_fixed_size_binary_data_type_new"}

proc fixedSizeBinaryDataTypeGetByteWidth*(dataType: GArrowDataTypePtr): int32
  {.importc: "garrow_fixed_size_binary_data_type_get_byte_width".}

proc integerDataTypeIsSigned*(dataType: GArrowDataTypePtr): bool
  {.importc: "garrow_integer_data_type_is_signed".}

proc timestampDataTypeNew*(unit: GArrowTimeUnit): GArrowDataTypePtr
  {.importc: "garrow_timestamp_data_type_new".}

proc timestampDataTypeGetUnit*(dataType: GArrowDataTypePtr): GArrowTimeUnit
  {.importc: "garrow_timestamp_data_type_get_unit".}

proc timeDataTypeGetUnit*(dataType: GArrowDataTypePtr): GArrowTimeUnit
  {.importc: "garrow_timestamp_data_type_get_unit".}

proc time32DataTypeNew*(unit: GArrowTimeUnit, error: var GErrorPtr): GArrowDataTypePtr
  {.importc: "garrow_time32_data_type_new".}

proc time64DataTypeNew*(unit: GArrowTimeUnit, error: var GErrorPtr): GArrowDataTypePtr
  {.importc: "garrow_time64_data_type_new".}

proc decimal128DataTypeNew*(precision: int32, scale: int32): GArrowDataTypePtr
  {.importc: "garrow_decimal128_data_type_new".}

proc decimal128DataTypeMaxPrecision*(): int32
  {.importc: "garrow_decimal128_data_type_max_precision".}

proc decimal256DataTypeNew*(precision: int32, scale: int32): GArrowDataTypePtr
  {.importc: "garrow_decimal256_data_type_new".}

proc decimal256DataTypeMaxPrecision*(): int32
  {.importc: "garrow_decimal256_data_type_max_precision".}  

proc extensionDataTypeGetExtensionName*(dataType: GArrowDataTypePtr): cstring
  {.importc: "garrow_extension_data_type_get_extension_name".}  

proc extensionDataTypeWrapArray*(dataType: GArrowDataTypePtr,
                                 storage: GArrowArrayPtr): GArrowArrayPtr
                                 {.importc: "garrow_extension_data_type_wrap_array".}

proc extensionDataTypeWrapChunkedArray*(dataType: GArrowDataTypePtr,
                                        storage: GArrowArrayPtr)
                                        {.importc: "garrow_extension_data_type_wrap_chunked_array".}

                                                           
proc extensionDataTypeRegistryDefault*(): GArrowExtensionDataTypeRegistryPtr
  {.importc: "garrow_extension_data_type_registry_default".}

proc extensionDataTypeRegistryRegister*(registry: GArrowExtensionDataTypeRegistryPtr,
                                        dataType: GArrowDataTypePtr,
                                        error: var GErrorPtr): bool
                                       {.importc: "garrow_extension_data_type_registry_register".}                                       

proc extensionDataTypeRegistryUnregister*(registry: GArrowExtensionDataTypeRegistryPtr,
                                          name: cstring,
                                          error: var GErrorPtr): bool
                                          {.importc: "garrow_extension_data_type_registry_unregister".} 

proc extensionDataTypeRegistryLookup*(registry: GArrowExtensionDataTypeRegistryPtr,
                                      name: cstring): GArrowDataTypePtr
                                      {.importc: "garrow_extension_data_type_registry_lookup".}

proc defaultDataTypeProc(name: NimNode): NimNode =
  let (procNew, importNew) = "data_type_new".toNamePair(name)
  quote do:
    proc `procNew`*(): GArrowDataTypePtr {.importc: `importNew`.}

macro DeclareNumericArray(dtype, name: untyped, 
                          isTime: static[bool] = false): untyped =
  result = newStmtList()
  
  let (procNew, importNew) = "array_new".toNamePair(name)
  let (procGetValue, importGetValue) = "array_get_value".toNamePair(name)
  let (procGetValues, importGetValues) = "array_get_values".toNamePair(name)

  if not isTime:
    result.add defaultDataTypeProc(name)
    result.add quote do:
        proc `procNew`*(length: int64, data: GArrowBufferPtr, 
                        nullBitmap: GArrowBufferPtr, nNulls: int64): GArrowArrayPtr
                        {.importc: `importNew`.}
  else:
    result.add quote do:
      proc `procNew`*(dataType: GArrowDataTypePtr, length: int64, 
                      data: GArrowBufferPtr, nullBitmap: GArrowBufferPtr, 
                      nNulls: int64): GArrowArrayPtr
                      {.importc: `importNew`.}
  
  result.add quote do:
    proc `procGetValue`*(arr: GArrowArrayPtr, i: int64): `dtype`
      {.importc:`importGetValue`.}

    proc `procGetValues`*(arr: GArrowArrayPtr, 
                          length: var int64): ptr UncheckedArray[`dtype`]
                          {.importc: `importGetValues`.}                                          
 
macro DeclareBinaryArray(name: untyped): untyped =
  let (procNew, importNew) = "array_new".toNamePair(name)
  let (procGetValue, importGetValue) = "array_get_value".toNamePair(name)
  let (procGetDataBuffer, importGetDataBuffer) = 
    "array_get_data_buffer".toNamePair(name)
  let (procGetOffsetsBuffer, importGetOffsetsBuffer) =
    "array_get_offsets_buffer".toNamePair(name)

  result = newStmtList()
  result.add defaultDataTypeProc(name)
  result.add quote do:
    proc `procNew`*(length: int64, valueOffsets: GArrowBufferPtr,
                    valueData: GArrowBufferPtr, nullBitmap: GArrowBufferPtr,
                    nNulls: int64): GArrowArrayPtr
                    {.importc: `importNew`.}

    proc `procGetValue`*(arr: GArrowArrayPtr, i: int64): GBytesPtr
      {.importc: `importGetValue`.}

    proc `procGetDataBuffer`*(arr: GArrowArrayPtr): GArrowBufferPtr
      {.importc: `importGetDataBuffer`.}   

    proc `procGetOffsetsBuffer`*(arr: GArrowArrayPtr): GArrowBufferPtr
      {.importc: `importGetOffsetsBuffer`.}                                                

macro AddStringOps(name: untyped): untyped =
  let (procGetString, importGetString) = "array_get_string".toNamePair(name)                                

  result = quote do:
    proc `procGetString`*(arr: GArrowArrayPtr, i: int64): cstring
      {.importc: `importGetString`.}

macro AddFixedSizeOps(name: untyped): untyped =
  let (procFormatValue, importFormatValue) = "array_format_value".toNamePair(name)      
  let (procGetValue, importGetValue) = "array_get_value".toNamePair(name)
  let returnType = repr(name).toDecimalIdent(true)

  result = quote do:
    proc `procFormatValue`*(arr: GArrowArrayPtr, i: int64): cstring
      {.importc: `importFormatValue`.}

    proc `procGetValue`*(arr: GArrowArrayPtr, i: int64): `returnType`
      {.importc: `importGetValue`.}

DeclareNumericArray(bool, boolean)
DeclareNumericArray(int8, int8)
DeclareNumericArray(uint8, uint8)
DeclareNumericArray(int16, int16)
DeclareNumericArray(uint16, uint16)
DeclareNumericArray(int32, int32)
DeclareNumericArray(uint32, uint32)
DeclareNumericArray(int64, int64)
DeclareNumericArray(uint64, uint64)
DeclareNumericArray(float32, float)
DeclareNumericArray(float64, double)
DeclareNumericArray(int32, date32)
DeclareNumericArray(int64, date64)

# These time arrays require an extra first parameter
DeclareNumericArray(int64, timestamp, true)
DeclareNumericArray(int32, time32, true)
DeclareNumericArray(int64, time64, true)

DeclareBinaryArray(binary)
DeclareBinaryArray(large_binary)
DeclareBinaryArray(string)
DeclareBinaryArray(large_string)

AddStringOps(string)
AddStringOps(large_string)

AddFixedSizeOps(decimal128)                          
AddFixedSizeOps(decimal256)

{.pop.}                               