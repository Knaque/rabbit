import ../src/rabbit
import fidget

var theme = readTheme("june.svg")

when defined(dd):
  # Compiling with -d:dd allows you to drag and drop .svg files into the window
  # to set a new theme. However, this won't work unless you do the following:
  #
  # nimble install staticglfw@#head
  # nimble uninstall fidget
  # nimble install https://github.com/knaque/fidget

  import fidget/opengl/base, staticglfw

  proc dropCallback(window: Window, count: cint, paths: cstringArray) {.cdecl.} =
    theme = readTheme($paths[0])

proc loadProc() =
  when defined(dd):
    window.setDropCallback(dropCallback)
  else: discard

proc drawProc() = 
  rectangle "f_high":
    box 32, 32, 32, 32
    cornerRadius 16
    fill theme.f_high.toHtmlHex()
  rectangle "f_med":
    box 64, 32, 32, 32
    cornerRadius 16
    fill theme.f_med.toHtmlHex()
  rectangle "f_low":
    box 96, 32, 32, 32
    cornerRadius 16
    fill theme.f_low.toHtmlHex()
  rectangle "f_inv":
    box 128, 32, 32, 32
    cornerRadius 16
    fill theme.f_inv.toHtmlHex()

  rectangle "b_high":
    box 32, 64, 32, 32
    cornerRadius 16
    fill theme.b_high.toHtmlHex()
  rectangle "b_med":
    box 64, 64, 32, 32
    cornerRadius 16
    fill theme.b_med.toHtmlHex()
  rectangle "b_low":
    box 96, 64, 32, 32
    cornerRadius 16
    fill theme.b_low.toHtmlHex()
  rectangle "b_inv":
    box 128, 64, 32, 32
    cornerRadius 16
    fill theme.b_inv.toHtmlHex()

  rectangle "background":
    box 0, 0, 192, 128
    fill theme.background.toHtmlHex()

startFidget(draw=drawProc, load=loadProc, w=192, h=128)