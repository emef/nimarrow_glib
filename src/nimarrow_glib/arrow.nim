import ./arrays
import ./glib

const libName = "libarrow-glib.so"

type
  GArrowInt32ArrayBuilder = object
  GArrowInt32ArrayBuilderPtr = ptr GArrowInt32ArrayBuilder

{.push dynlib: libName.}

proc newArrowInt32ArrayBuilder*(): GArrowInt32ArrayBuilderPtr
                                {.importc: "garrow_int32_array_builder_new".}

proc append*(b: GArrowInt32ArrayBuilderPtr, value: int32, error: var GErrorPtr): bool
             {.importc: "garrow_int32_array_builder_append".}


proc finish*(b: GArrowInt32ArrayBuilderPtr, error: var GErrorPtr): GArrowArrayPtr
             {.importc: "garrow_array_builder_finish".}


{.pop.}