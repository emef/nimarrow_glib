import macros
import strutils

proc camelCase*(s: string, pascal: bool = false): string =
  result = ""
  let words = s.split('_')
  for i, word in words:
    if pascal or i > 0:
      result.add word.capitalizeAscii()
    else:
      result.add word

proc pascalCase*(s: string): string = camelCase(s, true)      

proc toNimProc*(suffix: string, name: NimNode): NimNode =  
  ident(repr(name).camelCase() & suffix.pascalCase())
  
proc toImportc*(suffix: string, name: NimNode): string =
  "garrow_" & repr(name) & "_" & suffix

proc toNamePair*(suffix: string, name: NimNode): (NimNode, string) =
  (suffix.toNimProc(name), suffix.toImportc(name))  