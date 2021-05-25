import expander,unittest

test "imported multiple times":
    let expanded = expandFile("tests/codes/test2.nim",false,true,true)
    let expected = """proc lib1() =
    echo "Hello, this is lib1.nim :)"
proc lib2() =
    echo "Hi! This is lib2.nim :)"

proc lib3() =
    echo "I've imported two files!! Yay!"

import strutils
proc test2() =
    echo "This is test2.nim!!!"
"""
    check expanded == expected
