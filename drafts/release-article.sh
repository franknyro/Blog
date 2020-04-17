#!/bin/bash

LC_TIME=en_US.UTF-8
year="`date +%Y`"
month="`date +%m`"
month_eng="`date +%b`"
day="`date +%d`"
hour="`date +%H`"
minute="`date +%M`"
dirname="/$HOME/blog/archives/$year$month$day$hour$minute"
mkdir $dirname
article="$dirname/index.md"
touch $article

read -p "下書きファイル名を入力：" draft
read -p "記事タイトルを入力：" title
read -p "記事タグを入力（全て小文字）：" tag_lower
# アーカイブなどの表示用に先頭を大文字化
tag=${tag_lower^}

# 記事ファイルへの追加
{
    # 記事ファイルにヘッダを追加
    echo -e "| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |\n"
    echo -e "# $title"
    echo -e "$month_eng $day, $year, $hour:$minute [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)\n"
    # 記事ファイルに下書きファイルの内容を追加
    cat $draft
    echo -e "\n"
    # 記事ファイルに Tweet ボタンを追加
    echo -e "<a href=\"https://twitter.com/share?ref_src=twsrc%5Etfw\" class=\"twitter-share-button\" data-text=\"$title |\" data-url=\"https://franknyro.github.io/blog/archives/$year$month$day$hour$minute/\">Tweet</a><script async src=\"https://platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>"
} >> $article

# アーカイブページへ記事を追加
archives="/$HOME/blog/archives/index.md"
sed '1,3d' $archives > tmp.md
rm $archives
touch $archives
{
    echo -e "| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |\n"
    echo -e "# Archives"
    echo -e "## [$title](https://franknyro.github.io/blog/archives/$year$month$day$hour$minute)"
    echo -e "$month_eng $day, $year, $hour:$minute [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)\n"
    cat tmp.md
} >> $archives
rm tmp.md

# 個別のタグページへ記事を追加
flg="`mkdir $HOME/blog/tags/$tag_lower ; echo $?`"
tag_article_list="/home/franknyro/blog/tags/$tag_lower/index.md"
if [ $flg = 1 ]; then
    sed '1,3d' $tag_article_list > tmp.md
    rm $tag_article_list
fi
touch $tag_article_list
{
    echo -e "| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |\n"
    echo -e "# #$tag"
    echo -e "## [$title](https://franknyro.github.io/blog/archives/$year$month$day$hour$minute)"
    echo -e "$month_eng $day, $year, $hour:$minute [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)"
    if [ $flg = 1 ]; then
        echo -e "\n"
        cat tmp.md
    fi
} >> $tag_article_list
if [ $flg = 1 ]; then
    rm tmp.md
fi

# 新規タグの場合はタグ一覧ページにタグを追加
if [ $flg = 0 ]; then
    tag_list="/$HOME/blog/tags/index.md"
    {
        echo -e "- [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)"
    } >> $tag_list
fi