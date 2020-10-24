# rabbit

[![nimble](https://raw.githubusercontent.com/knaque/nimble-tag-2/master/nimble-tag-2.png)](https://github.com/knaque/nimble-tag-2)

`nimble install rabbit`

Rabbit brings the
[Hundred Rabbits theme ecosystem](https://github.com/hundredrabbits/Themes)
to Nim.

Usage is really simple.
```nim
import rabbit

# Load a theme!
var theme = readTheme("june.svg")

# Get the colors!
echo theme.background
echo theme.f_high.toHex()
echo theme.f_med.toHexAlpha()
echo theme.f_low.toHtmlHex()
echo theme.f_inv.toHtmlHexTiny()
echo theme.b_high.toHtmlRgb()
echo theme.b_med.toHtmlRgba()
echo theme.b_low
echo theme.b_inv.toHex()
```

Rabbit doesn't support the JS target, mainly because doing so would be
[pointless](https://github.com/hundredrabbits/Themes/blob/master/scripts/lib/theme.js).