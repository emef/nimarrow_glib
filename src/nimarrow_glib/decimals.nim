import ./helpers, macros

proc toDecimalIdent*(glibName: string, isPtr: bool): NimNode =
  var name = "GArrow" & glibName.pascalCase()
  if isPtr:
    name &= "Ptr"

  ident(name)

macro RegisterDecimalType(name: untyped): untyped =
  let typName = repr(name).toDecimalIdent(false)
  let ptrName = repr(name).toDecimalIdent(true)

  quote do:
    type
      `typName` = object
      `ptrName`* = ref `typName`

RegisterDecimalType(decimal128)
RegisterDecimalType(decimal256)
