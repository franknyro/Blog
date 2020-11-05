| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# 精進メモ：AtCoder Beginner Contest 178 C - Ubiquity
Nov 05, 2020, 16:46 [#Procon](https://franknyro.github.io/blog/tags/procon)

問題：[AtCoder Beginner Contest 178 C - Ubiquity](https://atcoder.jp/contests/abc178/tasks/abc178_c)

Difficulty: 587

包除原理 \|A∨B\| = \|A\| + \|B\| - \|A∧B\| と mod 1000000007 の問題。

## AC
```c
// C
#include <stdio.h>

#define MOD 1000000007

int main(void) {
    int n;
    scanf("%d", &n);

    long long a, b, c;
    a = b = c = 1;
    for (int i = 0; i < n; i++) {
        a = a * 10 % MOD;
        b = b *  9 % MOD;
        c = c *  8 % MOD;
    }
    long long ans = (a - 2*b + c) % MOD;
    if (ans < 0) ans += MOD;

    printf("%lld\n", ans);
    return 0;
}
```

引き算の mod はマイナスの値になることがあるので、その場合は 1000000007 を足す。

引き算して 1000000007 を足してから mod を取っても同じ。

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="精進メモ：AtCoder Beginner Contest 178 C - Ubiquity |" data-url="https://franknyro.github.io/blog/archives/202011051646/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
