# Package

version       = "0.1.0"
author        = "soraie"
description   = "expands code for competitive programing"
srcDir        = "src"
bin           = @["expander"]
binDir        = "bin"
license       = "MIT"

# Dependencies

requires "nim >= 1.4.6"
# requires "cligen >= 1.5.3"

task tests, "expander":
    exec "nim c -r tests/tester1.nim"
    exec "nim c -r tests/tester2.nim"
    exec "nim c -r tests/tester3.nim"