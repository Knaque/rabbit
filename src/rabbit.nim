## Rabbit brings the
## [Hundred Rabbits theme ecosystem](https://github.com/hundredrabbits/Themes)
## to Nim.
## 
## Usage is really simple.
## ```nim
## import rabbit
## 
## # Load a theme!
## var theme = readTheme("june.svg")
## 
## # Get the colors!
## echo theme.background
## echo theme.f_high.toHex()
## echo theme.f_med.toHexAlpha()
## echo theme.f_low.toHtmlHex()
## echo theme.f_inv.toHtmlHexTiny()
## echo theme.b_high.toHtmlRgb()
## echo theme.b_med.toHtmlRgba()
## echo theme.b_low
## echo theme.b_inv.toHex()
## ```
## 
## Rabbit doesn't support the JS target, mainly because doing so would be
## [pointless](https://github.com/hundredrabbits/Themes/blob/master/scripts/lib/theme.js).

import chroma, os, streams, parsexml, strutils, tables
export chroma

type
  ThemeError* = object of IOError
  Theme* = object
    ## The object containing your theme.
    ## 
    ## This uses Color objects provided by the Chroma library for convenience. You
    ## can convert these objects into any color format you might need. Chroma is
    ## already exported by Rabbit, so there's no need to import it manually.
    ## Refer to [Chroma's README](https://github.com/treeform/chroma) for usage.
    background*: Color ## Application background
    f_high*: Color ## Foreground, high contrast
    f_med*: Color ## Foreground, medium contrast
    f_low*: Color ## Foreground, low contrast
    f_inv*: Color ## Foreground, for modals and overlays
    b_high*: Color ## Background, high contrast
    b_med*: Color ## Background, medium contrast
    b_low*: Color ## Background, low contrast
    b_inv*: Color ## Background, for modals and overlays

proc `$`*(t: Theme): string =
  ## Converts a Theme to a string, in the same format as a Table. I don't know
  ## why you'd ever need to convert an entire Theme object to a string, but you
  ## can do it anyway.
  $({
    "background": t.background,
    "f_high": t.f_high,
    "f_med": t.f_med,
    "f_low": t.f_low,
    "f_inv": t.f_inv,
    "b_high": t.b_high,
    "b_med": t.b_med,
    "b_low": t.b_low,
    "b_inv": t.b_inv
  }.toOrderedTable())

proc `?=`(a, b: string): bool =
  ## Case-insensitive compare.
  return cmpIgnoreCase(a, b) == 0

proc tryGet[A, B](t: Table[A, B]; key: A): B {.raises: [ThemeError].} =
  try:
    return t[key]
  except KeyError:
    raise newException(ThemeError, "Color '" & $key & "' was not found.")

proc parseTheme(s: Stream, f: string):
  Theme {.raises: [Exception].} = 
  ## Internal proc that parses the XML and returns the Theme object.
  var l: Table[string, string]

  var x: XmlParser
  x.open(s, f)
  while true:
    x.next()
    case x.kind
    of xmlElementOpen:
      if x.elementName.toLowerAscii() in ["rect", "circle"]:
        var
          id: string
          fill: string
        while x.kind != xmlElementClose and x.kind != xmlEof:
          x.next()
          if x.kind == xmlAttribute:
            if x.attrKey ?= "id": id = x.attrValue
            if x.attrKey ?= "fill": fill = x.attrValue
        l[id] = fill
    of xmlEof: break # end of file reached
    of xmlError: raise newException(IOError, errorMsg(x))
    else: discard # ignore other events
  x.close()

  result.background = l.tryGet("background").parseHtmlHex()
  result.f_high = l.tryGet("f_high").parseHtmlHex()
  result.f_med = l.tryGet("f_med").parseHtmlHex()
  result.f_low = l.tryGet("f_low").parseHtmlHex()
  result.f_inv = l.tryGet("f_inv").parseHtmlHex()
  result.b_high = l.tryGet("b_high").parseHtmlHex()
  result.b_med = l.tryGet("b_med").parseHtmlHex()
  result.b_low = l.tryGet("b_low").parseHtmlHex()
  result.b_inv = l.tryGet("b_inv").parseHtmlHex()

proc readTheme*(file: string): Theme {.raises: [Exception].} =
  ## Opens and parses a `file` and returns a Theme object.
  let filename = addFileExt(file, "svg")
  var s = newFileStream(filename, fmRead)
  if s == nil: raise newException(IOError, "Cannot open file '$1'" % filename)
  return parseTheme(s, file)

proc readTheme*(stream: Stream, filename = "_Stream"):
  Theme {.raises: [Exception].} =
  ## Takes and parses a `stream` and returns a Theme object.
  ## 
  ## ParseXML requires a filename. This defaults to "_Stream" but can be
  ## manually set if you prefer.
  parseTheme(stream, filename)