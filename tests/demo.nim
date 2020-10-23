import ../src/rabbit
# You'll need to have Fidget installed for this demo.
import fidget

# Try loading a new theme!
var theme = readTheme("june.svg")

proc drawMain() = 
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

startFidget(draw=drawMain, w=192, h=128)