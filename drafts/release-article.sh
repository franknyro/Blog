#!/bin/bash

curdate="`date +'%Y%m%d%H%M'`"
dirname="/home/franknyro/Documents/blog/archives/${curdate}"
mkdir $dirname
article="${dirname}/index.md"
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
    LC_TIME=en_US.UTF-8
    echo -e "`date +%b` `date +%d`, `date +%Y`, `date +%H`:`date +%M` [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)\n"
    # 記事ファイルに下書きファイルの内容を追加
    cat $draft
    echo -e "\n"
    # 記事ファイルに Tweet ボタンを追加
    echo -e "<a href=\"https://twitter.com/share?ref_src=twsrc%5Etfw\" class=\"twitter-share-button\" data-text=\"$title |\" data-url=\"https://franknyro.github.io/blog/archives/$curdate/\">Tweet</a><script async src=\"https://platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>"
} >> $article

# アーカイブページへ記事を追加
archives="/home/franknyro/Documents/blog/archives/index.md"
{
    echo -e "\n"
    echo -e "## [$title](https://franknyro.github.io/blog/archives/$curdate/)"
    echo -e "`date +%b` `date +%d`, `date +%Y`, `date +%H`:`date +%M` [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)"
} >> $archives

# 個別のタグページへ記事を追加
flg="`mkdir /home/franknyro/Documents/blog/tags/$tag_lower ; echo $?`"
tag_article_list="/home/franknyro/Documents/blog/tags/$tag_lower/index.md"
{
    echo -e "\n"
    echo -e "## [$title](https://franknyro.github.io/blog/archives/$curdate/)"
    echo -e "`date +%b` `date +%d`, `date +%Y`, `date +%H`:`date +%M` [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)"
} >> $tag_article_list

# 新規タグの場合はタグ一覧ページにタグを追加
if [ $flg = 0 ]; then
    echo hello
    tag_list="/home/franknyro/Documents/blog/tags/index.md"
    {
        echo -e "\n"
        echo -e "- [#$tag](https://franknyro.github.io/blog/tags/$tag_lower)"
    } >> $tag_list
fi