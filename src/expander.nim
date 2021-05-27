## This package is a code expander for competitive programing.

import strutils,os,strformat,sets,osproc,terminal

const version* = "Nim competitive code expander version 1.0.0"

proc eraseWhitespace(s: string): string =
    ## returns a string which all whitespaces of `s` are erased
    return s.multiReplace((" ",""),("\t",""),("\v",""),("\r",""),("\l",""),("\f",""))

proc isNimble(fileName: string): bool =
    ## returns whether `fileName` is a Nimble file
    let got = execProcess(fmt"nimble path {fileName}")
    if "Error:" in got:
        return false
    else:
        return true

proc getNimblePath(fileName: string): string =
    return execProcess(fmt"nimble path {fileName}").eraseWhitespace() & "/" & fileName & ".nim"
proc getUsersLibraryPath(fileName: string,currentDir: string): string =
    return currentDir & "/" & fileName & ".nim"

proc getImportedFilePaths(files: string,currentDir: string): (seq[string],seq[string]) =
    ## (import|include) (file names) => (users or nimble file path,else)
    let trimed = files.replace("import","").replace("include","").eraseWhitespace()
    var res = (newSeq[string](),newSeq[string]())
    for file in trimed.split(","):
        if isNimble(file):
            res[0].add getNimblePath(file)
        else:
            let path = getUsersLibraryPath(file,currentDir)
            if fileExists(path):
                res[0].add(path)
            else:
                res[1].add(file)
    return res

## imported modules
var importedModulePaths = initHashSet[string]()

proc writeInfo(message: string,title: string,color: ForegroundColor) =
    ## print outs `message` in `color`
    setForegroundColor(stderr,color)
    stderr.write(fmt"[{title}] ")
    resetAttributes(stderr)
    stderr.writeLine(message)

proc expandFile*(filePath: string,comment: bool,noerror: bool = false,isTopFile: bool = false): string =
    ## expands file using recursing
    let exists = fileExists(filePath)
    if importedModulePaths.contains(filePath):
        if not noerror: writeInfo(fmt"Canceled importing {filePath} because it was already imported.","warning",fgYellow)
        return ""
    if not exists:
        if isTopFile:
            writeInfo(fmt"{filePath} wasn't found.","Error",fgRed)
            quit 1
        return ""
    if not noerror: writeInfo("bundling: " & filePath,"info",fgGreen)
    importedModulePaths.incl filePath
    var base = ""
    for line in lines(filePath):
        let trimed = if "#" in line: line[0..line.find('#')] else: line
        if "import" in trimed.split() or "include" in trimed.split():
            let files = getImportedFilePaths(trimed,filePath.parentDir)
            for file in files[0]:
                base &= expandFile(file,comment,noerror)
            if files[0].len > 0:
                base &= "\n"
            if files[1].len > 0:
                let idx = if "import" in trimed: trimed.find("import") else: trimed.find("include")
                base &= trimed[0..<idx] & "import " & files[1].join(",")
                base &= "\n"
        else:
            base &= line
            base &= "\n"
    if comment and not isTopFile:
        base = fmt"# start {filePath} #" & "\n" & base & fmt"# end {filePath} #" & "\n"
    return base

proc expand*(comment: bool = false,quiet: bool = false,noerror: bool = false,overwrite: bool = false,args: seq[string]) =
    let expandPath = getCurrentDir() & "/" & args[0]
    let res = expandFile(expandPath,comment,noerror,true)
    if not quiet:
        echo res
    if overWrite:
        var file = open(expandPath,fmWrite)
        defer:
            close(file)
        for line in res.split("\n"):
            file.writeLine(line)

when isMainModule:
    import cligen
    clCfg.version = version
    dispatch(expand,help = {"comment" : "print start end comment of the file","quiet" : "doesn't print any messages on stdout","overwrite" : "overwrites the file with the bundled code","noerror" : "doesn't print any messages on stderr(no guides)"})
