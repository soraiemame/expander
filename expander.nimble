# Package

version       = "0.1.1"
author        = "soraie"
description   = "expand codes for competitive programing"
srcDir        = "src"
bin           = @["expander"]
binDir        = "bin"
license       = "MIT"

# Dependencies

requires "nim >= 1.4.6"
requires "cligen >= 1.5.3"

task tests, "expander":
    exec "nimble test -Y"