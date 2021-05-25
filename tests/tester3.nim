import expander,unittest

test "check users library import":
    let expanded = expandFile("tests/codes/test1.nim",true,true,true)
    let expected = """# start tests/codes/lib1.nim #
proc lib1() =
    echo "Hello, this is lib1.nim :)"
# end tests/codes/lib1.nim #
# start tests/codes/lib2.nim #
proc lib2() =
    echo "Hi! This is lib2.nim :)"
# end tests/codes/lib2.nim #

proc test1() =
    echo "And this is test1.nim"
"""
    check expanded == expected
