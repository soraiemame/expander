import expander,unittest

test "check users library import":
    let expanded = expandFile("tests/codes/test1.nim",false,true,true)
    let expected = """proc lib1() =
    echo "Hello, this is lib1.nim :)"
proc lib2() =
    echo "Hi! This is lib2.nim :)"

proc test1() =
    echo "And this is test1.nim"
"""
    check expanded == expected
