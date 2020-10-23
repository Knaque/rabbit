# rabbit

[![nimble](https://raw.githubusercontent.com/knaque/nimble-tag-2/master/nimble-tag-2.png)](https://github.com/knaque/nimble-tag-2)

`nimble install rabbit`

---

Rabbit brings the Hundred Rabbits theme ecosystem to Nim.

Usage is really simple.
```nim
import rabbit

# Load a theme!
var theme = readTheme("nord.svg")

# Get the colors!
echo theme.background
echo theme.f_high.toHtmlHex()
echo theme.b_low.toHtmlRgba()
```

Rabbit doesn't support the JS target, mainly because doing so would be
[pointless](https://github.com/hundredrabbits/Themes/blob/master/scripts/lib/theme.js).