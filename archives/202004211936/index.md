| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# シェルスクリプトでテストケースの実行を自動化した
Apr 21, 2020, 19:36 [#Tech](https://franknyro.github.io/blog/tags/tech)

独断と偏見ですが、学校で作らされるようなプログラムは、キーボードからの入力に対して出力する対話型のものが多いとおもいます。

オンラインジャッジに提出するプログラムもわりとそういう形式のものが多いですね。

オンラインジャッジは自動でテストケースを実行して結果をおしえてくれます。ローカルでもおなじことができると、典型問題用のテンプレートなんかをつくるときに便利かもな〜とおもってつくってみました。

シェルスクリプトの勉強になりました。

***

サンプルプログラムとして

- 入力は整数
- 出力は文字列
- 入力された値に対しての出力は
  - 奇数のとき odd
  - 偶数のとき even
  - 例外は
    - 0 未満のとき small
    - 1000 より大きいとき big

というものをつくりました。雰囲気でシェルスクリプトを書いてみます。

サンプルプログラムの実行ファイルは `a.out`、テストケースは `test01.txt` という形式の連番のファイルです。

***

```shell
#!/bin/bash
list=($(echo `ls test*.txt`))

i=0
while [ -n $list[$i] ]
do
    cat $list[$i] | ./a.out
    i=`expr $i + 1`
done
```

シェルスクリプトの配列は

`array=(foo bar ...)`

で初期化できるので、テストケースを `ls` した文字列をつかうだけで配列を準備できます。

ちなみに `ls -m -Q` というふうにオプションを指定すると、カンマで区切ってダブルクオーテーションで囲んでくれるので

`"foo", "bar", ..., "baz"`

と表示してくれます。他の言語でファイルパスを配列にしたいときにつかえるかもしれません。

`cat テストケース | ./a.out` で入力を指定して実行します。


実行してみます。

```
$ ./test.sh
cat: 'test01.txt[0]': そのようなファイルやディレクトリはありません
big
cat: 'test01.txt[1]': そのようなファイルやディレクトリはありません
big
cat: 'test01.txt[2]': そのようなファイルやディレクトリはありません
big
...
```

`while` でバグっています。配列のインデックスを指定してるつもりが、うまくいってません。

たぶん単純に左から評価しているせいで、変数が左から順番に文字列になおされているんでしょう。高級言語じゃないのでしょうがないです。

***

ということで修正。`array[@]` `array[*]` で配列の全要素を参照できます。

```shell
#!/bin/bash
list=($(echo `ls test*.txt`))

for file in ${list[@]}
do
    cat $file | ./a.out
done
```

実行。

```
$ ./test.sh
small
even
even
big
odd
even
odd
even
```

うまくいきました。全部のテストケースの実行結果が表示されています。

しかし、ちょっとこれではエラーが出たときパッとわかりません。

出力が正しいかどうかの情報も表示しましょう。

***

```shell
#!/bin/bash
list=($(echo `ls input*.txt`))

for file in ${list[@]}
do
    cat $file | ./a.out |
    {
        result=$(cat)

        buf=${file//input/output}
        expectation=$(cat $buf)

        if [ $result = $expectation ]
        then
            echo "<OK> : $result"
        else
            echo "<NG> : $result"
        fi
    }
done
```

パイプで実行結果を `result` に格納しています。

この変数は、どうやらブロック `{}` で囲まないとスコープ外になって参照できないようです。ちょっとハマりました。

期待される出力を `output01.txt` という形式の連番のファイルに入れてあります。番号は入力ファイルとひもづいています。なので、名前を置換して対応する出力ファイルの名前にして `expectation` に格納しています。

実行してみましょう。

```
$ ./test.sh
<OK> : small
<OK> : even
<OK> : even
<OK> : big
<OK> : odd
<OK> : even
<OK> : odd
<OK> : even
```

うまくいきました。でもなんか味気ないです。もっと瞬間的に把握したい。

五感に訴えかけるため、カラーにしてみましょう。

***

```shell
#!/bin/bash
list=($(echo `ls input*.txt`))

for file in ${list[@]}
do
    cat $file | ./a.out |
    {
        result=$(cat)

        buf=${file//input/output}
        expectation=$(cat $buf)

        id=${file#input}
        id=${id%.txt}

        if [ $result = $expectation ]
        then
            echo -e "$id \e[42m OK \e[m \e[32m$result\e[m"
        else
            echo -e "$id \e[41m NG \e[m \e[31m$result\e[m"
        fi
    }
done
```

色を指定して、テストケースの番号も行頭に表示されるようにしました。

実行！

[result](https://franknyro.github.io/blog/images/shellscript)

いいですね。

***

シェルスクリプトは手軽に書けて便利ですね〜。

ただ、高級言語じゃないのでちょっと慣れが必要なのと、動作が OS にけっこう左右されます。

今回は Ubuntu でうごかしているので、BSD ですね。なのでシェルは bash です。

それでは。

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="シェルスクリプトでテストケースの実行を自動化した |" data-url="https://franknyro.github.io/blog/archives/202004211936/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
