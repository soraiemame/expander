# expander

You can expand the `import`,`include` statements in your files.
This is a Nim version of [oj-bundle](https://github.com/online-judge-tools/verification-helper#autoexpansion-of-includes).

This is my first time to make a Nim project. So maybe there are some bugs.
Also, I'm not so good at English. Please tell me if my grammars are wrong.

## Development

nim -v
```
Nim Compiler Version 1.4.6 [Linux: amd64]
Compiled at 2021-04-15
Copyright (c) 2006-2020 by Andreas Rumpf
```
```
git hash: 2b6b08032348939e5d355a6cb4faa0169306c17f
active boot switches: -d:release
```
nimble -v
```
nimble v0.8.8 compiled at 2018-02-05 22:32:55
git hash: /bin/sh: 1: git: not found
```

## Usage

```
expand [optional-params] [args: string...]
```

### Options

|option name|type|default|description|
|:-:|:-:|:-:|:-:|
|-h, --help|-|-|print this cligen-erated help|
|--help-syntax|-|-|advanced: prepend,plurals,..|
|--version|bool|false|print version|
|-c, --comment|bool|false|print start end comment of the file|
|-q, --quiet|bool|false|doesn't print any messages on stdout|
|-n, --noerror|bool|false|doesn't print any messages on stderr(no guides)|
|-o, --overwrite|bool|false|overwrites the file with the bundled code|

Set the path to the file where you want to expand the code in args.

## License

MIT

## References

- [Nimのパッケージリポジトリに自前のライブラリを追加する流れ
](https://qiita.com/jiro4989/items/19df1f6ec0c3a147c4ac)
- [Nimble入門](https://qiita.com/nemui-fujiu/items/2a959bd6cbfe7ff35528#nimble-test)
- [yourutils](https://github.com/jiro4989/yourutils)