| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# 精進メモ：AtCoder Beginner Contest 173 D - Chat in a Circle
Nov 07, 2020, 15:16 [#Procon](https://franknyro.github.io/blog/tags/procon)

問題：[AtCoder Beginner Contest 173 D - Chat in a Circle](https://atcoder.jp/contests/abc173/tasks/abc173_d)

Difficulty: 673

貪欲法の問題。

紙の上での実験が不足していた。

## WA
```c
// C
#include <stdio.h>

void merge_sort(int size, long long array[]) {
    if (size <= 1) return;
    int mid = size / 2;

    merge_sort(mid, array);
    merge_sort(size - mid, array + mid);

    long long buf[size];
    for (int i = 0; i < mid; i++) buf[i] = array[i];

    int /* array_i */ a_i = 0;
    int /* left_i  */ l_i = 0;
    int /* right_i */ r_i = mid;
    while (l_i < mid && r_i < size) {
        if (buf[l_i] <= array[r_i]) { // 昇順
            array[a_i++] = buf[l_i++];
        }
        else {
            array[a_i++] = array[r_i++];
        }
    }
    while (l_i < mid) array[a_i++] = buf[l_i++];
}

int main(void) {
    int n;
    scanf("%d", &n);
    long long a[n];
    for (int i = 0; i < n; i++) scanf("%lld", &a[i]);

    merge_sort(n, a);
    long long ans = 0;
    for (int i = 0; i < n; i++) ans += a[i];
    ans -= a[0];
    printf("%lld\n", ans);

    return 0;
}
```

入力例だけで実験したので、入力例にだけ正しく動作する手法で実装してしまった。

一般化できるような実験を心がけたい。

## AC
```c
// C
#include <stdio.h>

void merge_sort(int size, long long array[]) {
    if (size <= 1) return;
    int mid = size / 2;

    merge_sort(mid, array);
    merge_sort(size - mid, array + mid);

    long long buf[size];
    for (int i = 0; i < mid; i++) buf[i] = array[i];

    int /* array_i */ a_i = 0;
    int /* left_i  */ l_i = 0;
    int /* right_i */ r_i = mid;
    while (l_i < mid && r_i < size) {
        if (buf[l_i] >= array[r_i]) { // 降順
            array[a_i++] = buf[l_i++];
        }
        else {
            array[a_i++] = array[r_i++];
        }
    }
    while (l_i < mid) array[a_i++] = buf[l_i++];
}

int main(void) {
    int n;
    scanf("%d", &n);
    long long a[n];
    for (int i = 0; i < n; i++) scanf("%lld", &a[i]);

    merge_sort(n, a);
    long long ans = 0;
    for (int i = 1; i < n; i++) ans += a[i/2];
    printf("%lld\n", ans);

    return 0;
}
```

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="精進メモ：AtCoder Beginner Contest 173 D - Chat in a Circle |" data-url="https://franknyro.github.io/blog/archives/202011071516/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
