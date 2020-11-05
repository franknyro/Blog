| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# 精進メモ：AtCoder Beginner Contest 177 D - Friends
Nov 05, 2020, 17:38 [#Procon](https://franknyro.github.io/blog/tags/procon)

問題：[AtCoder Beginner Contest 177 D - Friends](https://atcoder.jp/contests/abc177/tasks/abc177_d)

Difficulty: 676

Union-Find の問題。

Union-Find を知らなかったので自力でそれっぽいものを書いて WA して解説を見た（BFS でも解けるらしいけどそっちもよく知らなかった）。

## WA
```c
// C
#include <stdio.h>

int root(int x, int par[]) {
    if (par[x] == x) return x;
    par[x] = root(par[x], par);
    return par[x];
}

void unite(int x, int y, int par[]) {
    int rx = root(x, par);
    int ry = root(y, par);

    if (rx < ry) par[ry] = rx;
    else par[rx] = ry;
}

int main(void) {
    int n, m;
    scanf("%d %d", &n, &m);
    int par[n];
    for (int i = 0; i < n; i++) par[i] = i;
    for (int i = 0; i < m; i++) {
        int a, b;
        scanf("%d %d", &a, &b);
        unite(a-1, b-1, par);
    }

    int cnt[n];
    for (int i = 0; i < n; i++) cnt[i] = 0;
    // グループの大きさを調べる
    for (int i = 0; i < n; i++) cnt[par[i]]++;

    int ans = 1;
    for (int i = 0; i < n; i++) {
        if (ans < cnt[i]) ans = cnt[i];
    }
    printf("%d\n", ans);

    return 0;
}
```

Union-Find を調べて書いてみたがランダムケースで落ちたので、自分でランダムケースを生成して食わせてみる。

適当に AC コードを拾ってきて結果を見比べると、同じグループなのに Union-Find 木の根が違うことになっていた。

もう一回ループで root 関数に全要素を突っ込まなきゃいけないことになってるぞ、とコードをよくよく見返すとグループの大きさを調べるところで root 関数を呼んでなかった。

## AC
```c
    // グループの大きさを調べる
    // cnt[par[i]]++ -> cnt[root(i, par)]++
    for (int i = 0; i < n; i++) cnt[root(i, par)]++;
```

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="精進メモ：AtCoder Beginner Contest 177 D - Friends |" data-url="https://franknyro.github.io/blog/archives/202011051738/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
