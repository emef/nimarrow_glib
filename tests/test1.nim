import nimarrow_glib, unittest

test "can add":

  var err: GErrorPtr

  let int32Dtype = int32DataTypeNew()
  let fieldA = fieldNew("a", int32Dtype)
  let fieldB = fieldNew("b", int32Dtype)
  var fields: GListPtr = nil
  fields = fields.glistAppend(fieldA)
  fields = fields.glistAppend(fieldB)
  let schema = schemaNew(fields)

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

  var length: int64
  var colBValues = int32ArrayGetValues(colBArray, length)
  echo "col_b values, length = " & $length
  echo colBValues[0]
  echo colBValues[1]

  echo $colA
  echo colAArray.arrayToString(err)
  echo colAArray.arrayToString(err)

  var values: GListPtr = nil
  values = values.glistAppend(colAArray)
  values = values.glistAppend(colBArray)

  let table = tableNewValues(schema, values, err)

  echo repr(err)
  echo repr(table)

  let writerProps = writerPropertiesNew()

  let writer = parquetFileWriterNewPath(schema, "/tmp/test.parq", writerProps, err)
  let chunkSize = 100'u64

  let ok = writer.parquetFileWriterWriteTable(table, chunkSize, err)
  echo "ok ", ok
  echo repr(err)

  discard writer.parquetFileWriterWriteTable(table, chunkSize, err)
  echo "ok ", ok
  echo repr(err)

  let closed = writer.parquetFileWriterClose(err)
  echo "closed? ", closed
  echo repr(err)
