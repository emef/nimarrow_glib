# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import nimarrow_glib/arrays
import nimarrow_glib/arrow
import nimarrow_glib/buffers
import nimarrow_glib/glib
import nimarrow_glib/parquet

test "can add":
  var err: GErrorPtr

  let int32Dtype = int32DataTypeNew()  
  let fieldA = newArrowField("a", int32Dtype)
  let fieldB = newArrowField("b", int32Dtype)
  var fields: GListPtr = nil
  fields = fields.append(fieldA)
  fields = fields.append(fieldB)
  let schema = newArrowSchema(fields)

  var colA: array[16, int32]
  var colB: array[16, int32]
  colA[0..1] = [1'i32, 3'i32]
  colB[0..1] = [3'i32, 4'i32]

  echo colA[0]
  echo colA[1]

  let colAUnchecked = cast[ptr UncheckedArray[int32]](addr colA)
  echo colAUnchecked[0]
  echo colAUnchecked[1]
  let colAAddr = cast[ptr int](unsafeAddr colA)
  echo cast[ptr int](cast[uint](colAAddr) + 1 * sizeof(int))[]

  var colA2 = cast[ptr UncheckedArray[int32]](alloc0(64))
  colA2[0] = 1'i32
  colA2[1] = 2'i32
  
  var a1: pointer = unsafeAddr colA[0]
  var a2: pointer = colA2



  let colASeq = @[1'i32, 2'i32]


  let colABuffer = bufferNew(a1, 16)
  let colBBuffer = bufferNew(unsafeAddr colB, 64)

  let colAArray = int32ArrayNew(2, colABuffer, nil, 0)
  let colBArray = int32ArrayNew(2, colBBuffer, nil, 0)

  let colABuilder = newArrowInt32ArrayBuilder()
  let colBBuilder = newArrowInt32ArrayBuilder()

  discard colABuilder.append(1'i32, err)
  discard colABuilder.append(2'i32, err)
  discard colBBuilder.append(3'i32, err)
  discard colBBuilder.append(4'i32, err)

  let colAArray2 = colABuilder.finish(err)
  let colBArray2 = colBBuilder.finish(err)

  var length: int64
  var colBValues = int32ArrayGetValues(colBArray2, length)
  echo "col_b values, length = " & $length
  echo colBValues[0]
  echo colBValues[1]


  echo $colA
  echo colAArray.arrayToString(err)
  echo colAArray2.arrayToString(err)

  var values: GListPtr = nil
  values = values.append(colAArray2)
  values = values.append(colBArray2)
  
  let table = newArrowTableValues(schema, values, err)
  
  echo repr(err)
  echo repr(table)

  let writerProps = newParquetWriterProperties();
  
  let writer = newParquetFileWriterPath(schema, "/tmp/test.parq", writerProps, err)  
  let chunkSize = 100'u64

  let ok = writer.writeTable(table, chunkSize, err)
  echo "ok ", ok
  echo repr(err)

  let closed = writer.close(err)
  echo "closed? ", closed 
  echo repr(err)
  
