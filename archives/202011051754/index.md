| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# 精進メモ：AtCoder Beginner Contest 173 C - H and V
Nov 05, 2020, 17:54 [#Procon](https://franknyro.github.io/blog/tags/procon)

問題：[AtCoder Beginner Contest 173 C - H and V](https://atcoder.jp/contests/abc173/tasks/abc173_c)

Difficulty: 600

二重 bit 全探索の問題。

計算量は O((2^n)^2) だけど制約から最大でも 2^12 = 4096 なのでセーフ。おもしろかった。

## AC
```c
// C
#include <stdio.h>

int main(void) {
    int h, w, k;
    scanf("%d %d %d", &h, &w, &k);
    char c[h][w+1];
    char buf;
    for (int y = 0; y < h; y++) {
        for (int x = -1; x < w; x++) {
            if (x == -1) scanf("%c", &buf);
            else scanf("%c", &c[y][x]);
        }
    }

    int ans = 0;
    // ===== 二重 bit 全探索 ========================================= //
    // ----- bit ループ ---------------------------------------------- //
    for (int /* y_bit */ y_b = 0; y_b < (1<<h); y_b++) {
        for (int /* x_bit */ x_b = 0; x_b < (1<<w); x_b++) {
            int cnt = 0;
            // ----- bit の表す集合を求める ---------------------------------- //
            for (int y = 0; y < h; y++) {
                for (int x = 0; x < w; x++) {
                    if (y_b & (1<<y) && x_b & (1<<x)) {
                        if (c[y][x] == '#') cnt++;
                    }
                }
            }
            if (cnt == k) ans++;
        }
    }
    printf("%d\n", ans);

    return 0;
}
```

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="精進メモ：AtCoder Beginner Contest 173 C - H and V |" data-url="https://franknyro.github.io/blog/archives/202011051754/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
