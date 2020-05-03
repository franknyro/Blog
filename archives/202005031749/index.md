| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# DFS（深さ優先探索）の全列挙いろいろ
May 03, 2020, 17:49 [#Procon](https://franknyro.github.io/blog/tags/procon)

## はじめに
順列や組合せを全列挙したいときに DFS が役立つので、メモしてみました。

[DFS の説明は良いものがたくさんあるので省略します。](https://www.slideshare.net/chokudai/wap-atcoder2)

## 重複順列
M 個の要素から N 個えらぶ。ただし、おなじ要素を何度えらんでもよい、ということです。

これは M 個の要素からひとつえらぶのを N 回くりかえせばよいので、N 重ループで実現できますが、たいへんなので実装したくありません…。

ループが深くなっても対応できるように再帰をつかって実装します。

M^N パターンの順列が得られます。

N 回のくりかえしを M^N パターンについておこなうので、計算量は O(N*M^N) です。

### コード
```c++
// DFS で重複順列を全列挙する
#include <iostream>
#include <vector>
using namespace std;

vector<int> permutation;
void dfs(int depth, int size, int min, int max) {
    if (depth == size) {
        for (int i = 0; i < depth; i++) {
            cout << permutation[i] << " ";
        }
        cout << endl;
    }
    else {
        for (int i = min; i <= max; i++) {
            permutation[depth] = i;
            dfs(depth+1, size, min, max);
        }
    }
}

int main(void) {
    // max-min+1 個の整数から size 個えらぶ
    int size, min, max;
    cin >> size >> min >> max;
    cout << endl;

    permutation.resize(size);
    dfs(0, size, min, max);
}
```

### 実行
```
$ ./permutation_with_repetition
3 1 3

1 1 1
1 1 2
1 1 3
1 2 1
1 2 2
1 2 3
1 3 1
1 3 2
1 3 3
2 1 1
2 1 2
2 1 3
2 2 1
2 2 2
2 2 3
2 3 1
2 3 2
2 3 3
3 1 1
3 1 2
3 1 3
3 2 1
3 2 2
3 2 3
3 3 1
3 3 2
3 3 3
```

## 重複組合せ
M 個の要素から重複をゆるして N 個えらんだ組合せをしらべます。

重複順列を 1 箇所だけ改変します。

再帰するとき min に渡す値を変えて、すでに使った値以上でないとえらべないようにします。

結果として単調増加する数列が出力されます。

C(M+N-1, N) パターンの組合せが得られます。

N 回のくりかえしを C(M+N-1, N) パターンについておこなうので、計算量は O(N*C(M+N-1, N)) です。

### コード
```c++
// DFS で重複組合せを全列挙する
#include <iostream>
#include <vector>
using namespace std;

vector<int> combination;
void dfs(int depth, int size, int min, int max) {
    if (depth == size) {
        for (int i = 0; i < depth; i++) {
            cout << combination[i] << " ";
        }
        cout << endl;
    }
    else {
        for (int i = min; i <= max; i++) {
            combination[depth] = i;
            // min を i に変更した
            dfs(depth+1, size, i, max);
        }
    }
}

int main(void) {
    int size, min, max;
    cin >> size >> min >> max;
    cout << endl;

    combination.resize(size);
    dfs(0, size, min, max);
}
```

### 実行
```
$ ./combination_with_repetiton 
3 1 3

1 1 1 
1 1 2 
1 1 3 
1 2 2 
1 2 3 
1 3 3 
2 2 2 
2 2 3 
2 3 3 
3 3 3
```

## 組合せ（重複なし）
重複組合せを 1 箇所だけ改変します。

すでに使った値より大きい値でないとえらべないようにします（同じ値はえらべないということです）。

C(M, N) パターンの組合せが得られます。

計算量は O(N*C(M, N)) です。

### コード
```c++
// DFS で組合せを全列挙する
#include <iostream>
#include <vector>
using namespace std;

vector<int> combination;
void dfs(int depth, int size, int min, int max) {
    if (depth == size) {
        for (int i = 0; i < depth; i++) {
            cout << combination[i] << " ";
        }
        cout << endl;
    }
    else {
        for (int i = min; i <= max; i++) {
            combination[depth] = i;
            // i を i+1 に変更した
            dfs(depth+1, size, i+1, max);
        }
    }
}

int main(void) {
    int size, min, max;
    cin >> size >> min >> max;
    cout << endl;

    combination.resize(size);
    dfs(0, size, min, max);
}
```

### 実行
```
$ ./combination_without_repetition 
3 1 3

1 2 3 
```

```
$ ./combination_without_repetition 
3 1 5

1 2 3 
1 2 4 
1 2 5 
1 3 4 
1 3 5 
1 4 5 
2 3 4 
2 3 5 
2 4 5 
3 4 5
```

## 順列（重複なし）
最初の重複順列を改変します。

すでにえらんだ値かどうかを判定するため、bool 型の vector である used を定義しています。

えらんだら true を代入し、浅い階層に帰るときに false を代入しています（`resize` したときに 0 が代入されているので最初は false あつかいです）。

計算量は O(N*P(M, N)) です。

### コード
```c++
// DFS で順列を全列挙する
#include <iostream>
#include <vector>
using namespace std;

vector<int> permutation;
vector<bool> used; // 追加した
void dfs(int depth, int size, int min, int max) {
    if (depth == size) {
        for (int i = 0; i < depth; i++) {
            cout << permutation[i] << " ";
        }
        cout << endl;
    }
    else {
        for (int i = min; i <= max; i++) {
            // i が使用済みの値かどうかを判定
            if (!used[i]) {
                permutation[depth] = i;
                used[i] = true;
                dfs(depth+1, size, min, max);
                used[i] = false;
            }
        }
    }
}

int main(void) {
    int size, min, max;
    cin >> size >> min >> max;
    cout << endl;

    permutation.resize(size);
    used.resize(size); // 確保した部分は 0 で初期化される
    dfs(0, size, min, max);
}
```

### コード
```
$ ./permutation_without_repetition 
3 1 3

1 2 3 
1 3 2 
2 1 3 
2 3 1 
3 1 2 
3 2 1
```

## おわりに
重複順列と重複組合せを全列挙する問題はといたことがある。AtCoder 的には労力のわりにレートにうまみがあるので、優先的に勉強したほうがいい分野かもしれない（そもそも全探索だし）。

計算量まちがってたらごめんなさい。というかこういう書き方していいんだろうか？ 順列は O(MM!) と書いたほうがいいかもしれない。

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="DFS（深さ優先探索）の全列挙いろいろ |" data-url="https://franknyro.github.io/blog/archives/202005031749/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
