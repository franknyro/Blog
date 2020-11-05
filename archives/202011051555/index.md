| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# 精進メモ：AtCoder Beginner Contest 180 D - Takahashi Unevolved
Nov 05, 2020, 15:55 [#Procon](https://franknyro.github.io/blog/tags/procon)

問題：[AtCoder Beginner Contest 180 D - Takahashi Unevolved](https://atcoder.jp/contests/abc180/tasks/abc180_d)

Difficulty: 721

解説 AC。方針は正しかったがオーバーフローのチェックをしていなかった。

## WA
```c
// C
#include <stdio.h>

int main(void) {
    long long x, y, a, b;
    scanf("%lld %lld %lld %lld", &x, &y, &a, &b);

    long long ans = 0;
    while (a * x <= x + b && a * x < y) {
        x *= a;
        ans++;
    }
    ans += (y - 1 - x) / b;

    printf("%lld\n", ans);
    return 0;
}
```

入力が 1 <= X < Y <= 1e18 と大きいので、while の条件式でオーバーフローが発生してしまっていた。

a * x を double にキャストしてから 2e18 と比べてオーバーフローしていないかチェックすることで解決。

## AC
```c
// C
#include <stdio.h>

int main(void) {
    long long x, y, a, b;
    scanf("%lld %lld %lld %lld", &x, &y, &a, &b);

    long long ans = 0;
    while ((double) a * x <= 2e18 && a * x <= x + b && a * x < y) {
        x *= a;
        ans++;
    }
    ans += (y - 1 - x) / b;

    printf("%lld\n", ans);
    return 0;
}
```

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="精進メモ：AtCoder Beginner Contest 180 D - Takahashi Unevolved |" data-url="https://franknyro.github.io/blog/archives/202011051555/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
