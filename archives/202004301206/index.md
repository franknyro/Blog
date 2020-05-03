| [About me](https://franknyro.github.io/blog/) | [Archives](https://franknyro.github.io/blog/archives) | [Tags](https://franknyro.github.io/blog/tags) |

# Diary 4/20-29 進捗・散歩・興味
Apr 30, 2020, 12:06 [#Diary](https://franknyro.github.io/blog/tags/diary)

## 4/20
さいきんバグをとったりわからないところでずっと詰まってたりして、みえる進捗があまりない。

ここんとこよくねむれないのはそれが原因なんじゃないかとおもっている。なんとなく「なにも進んでいないのにこのまま寝ていいのか」というか、もっとかんたんにいうと「ものたりない」というきもちが眠りをさまたげているのではないか。

とはいえ、かんがえてみると、バグを出したりわからないところを発見するのはそれだけで進捗なのではないか。「無知の無知」を「無知の知」にまでひきあげるのはけっこうたいへん、というか、そこまでくれば解決の糸口はつかめているといえる。

なので、進捗がないと考えるのはやめて「きょうはこんなバグを出して、これこれこんなことが**わかっていないことがわかった**」という進捗としてカウントしていこうとおもう。

あと、進捗の粒度を下げる（こまかくする）のも大事だなとおもう。抽象的なままにせず具体的にしていくというか、自分の気づきに気づくというか、成長に気づくとも言いかえることが出来るかもしれない。前段に書いたこととおなじだった。これも気づき。ひとまずねる。

## 4/22
ねむれなかったので 5 時ごろ散歩にでかけた。天気がよく格別のきもちよさだった。

いろんなひとたちがコンピュータとネットワークをつかって肉体の限界をひろげようとしている。たとえばリモートワークができるようになるとかは最たるもので、医療の現場だと僻地の病院でもロボットさえあれば名執刀医がそれを遠隔操作して手術できるようになったり、AR ゴーグルみたいなもので音を視覚的に表現すれば聴覚を拡張したことになるし、いろいろある。

さいごにはみんな自動運転する家（というかキャンピングカーみたいなもの）に住むようになるんじゃないかとおもっている。ドラえもんにも、夜行列車になった家にのって家族旅行するとかそんな話があった気がする。

わりとひきこもるのが得意なので、そういう世界はすばらしいものだと信じていたけれど、最近のコロナ騒ぎで実はそうじゃないかもしれないと思いはじめた。

人間が家に引きこもるのはやはり限度がある。運動しなければ身体の機能は低下するし、おひさまにあたらなければ精神だってダメになる。フラストレーションがたまるので、現にフランスなんかでは警察に花火を打ったりしてるらしい。

<blockquote class="twitter-tweet"><p lang="fr" dir="ltr">En direct depuis le quartier du Luth à <a href="https://twitter.com/hashtag/Gennevilliers?src=hash&amp;ref_src=twsrc%5Etfw">#Gennevilliers</a> une voiture de la bac prise pour cible par des tirs de feux d’artifices.<a href="https://twitter.com/hashtag/VilleuneuveLaGarenne?src=hash&amp;ref_src=twsrc%5Etfw">#VilleuneuveLaGarenne</a> <a href="https://twitter.com/hashtag/VilleneuveLaGarenne?src=hash&amp;ref_src=twsrc%5Etfw">#VilleneuveLaGarenne</a> <a href="https://t.co/cqdAwSvYi1">pic.twitter.com/cqdAwSvYi1</a></p>&mdash; Taha Bouhafs (@T_Bouhafs) <a href="https://twitter.com/T_Bouhafs/status/1252368226610114571?ref_src=twsrc%5Etfw">April 20, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

みんながひきこもっていても大丈夫な社会が来るとき、人間の肉体は弱くなっているはずで、それが肉体の限界をひろげようとがんばった結果ならば、それ以上皮肉なことはないし、しあわせではないなとおもった。結局しあわせとかそういうのは、朝の空気がきもちいいみたいな、すごく原始的なものにかえっていくのかもしれないし、そもそも、そういうものなんだけどみんなわすれてるのかもしれない。さっきおもいだした。

## 4/23
早朝に 6km 散歩したら午前中は快調だったけど午後は眠くてずっと寝てしまった。夕飯のあとも寝てしまったのでこのあと眠れるだろうか…。なんとなく眠れる気もする。ちゃんと身体をうごかすと体感では頭の回転がはやい気がする。ちょっと体力が落ちすぎてて寝てばっかりだけど習慣になればけっこうよさそう。

## 4/24
きょうは 4.5km あるいた。やっぱり頭の回転がはやくなるとおもう。

タコガール BOT にちょっと機能を追加していくつかバグをなおした。JavaScript の Date は仕様がクソでバグの温床なので、ライブラリなしの生のままでつかうのはよくないということを学んだ。とりあえず動けばいいやでコードをコピペしたり設計とか考えず適当に書いてるのでクソ。どっかできれいにしたい。

JS Primer をよんでいる。[`this` のところ](https://jsprimer.net/basic/function-this/#method-this)を読んでいたら、メソッドの中から同じオブジェクトに所属するプロパティを参照する方法がでてきた。これめっちゃ知りたかったのでよかった…。これでタコガール BOT のモジュールまとめることができる。

## 4/25
Async つかえるようになればスプレッドシート書き込みモジュールが実現できるのはわかっているんだけど、やんなったので放りっぱなしになっていた。もういっかい勉強しはじめたんだけどやっぱりややこしいので 5 日ぐらいかけてちょっとずつやっていきたい…。

## 4/26
きょうは 6km あるいた。

## 4/27
3km あるいた。

留年した（というか卒研を提出する資格がない）とはいえ研究はすすめられるので、そろそろテーマを決めなきゃいけない。せっかくネットワーク関係の研究室にはいったのでそっち方面の研究をしたいなとはおもっている。先行研究はネットワークトポロジとかアドホックネットワークのものがおおいけど、そういうのをもうすこし具体的に「エッジコンピューティングに適用する」という切り口でやってみたいな〜となんとなくおもっている。じぶんのなかでもなんとなくなので、なぜなのかをちょっと掘りさげていきたい。

まずはなんでネットワーク関係の研究室を希望したかというところから。

情報通信技術をすごくおおざっぱにかんがえるとコンピュータとネットワークの二大要素からできている。じゃあどちらにより興味があるかというと、そもそも情報工学科に入ったのはインターネットたのしい！ という気持ちからなので、どちらかというと興味はネットワークにあったんだとおもう。

## 4/28
- インターネットがたのしいとおもったのはなぜ？
  - たくさんのひととコミュニケーションがとれる
    - たくさんのコミュニティがある
    - 共有する楽しさ
  - 高いリアルタイム性
  - コンテンツをじぶんたちでつくりあげているという感覚（錯覚？）
    - あそびば・プラットフォームとして
    - 生産者と消費者の同一性
    - 現実と似ているけど現実より制約がすくないので代替としてつかいやすい？

「あれおもしろいよ」「これおもしろいよ」というやりとり（共有・共感）を世界中の人とリアルタイムにできる。だれかと共有・共感するというのは人間の欲求、本能そのものだとおもう。

マズロー心理学（よくしらない）では人間の欲求を 5 段階（マズローは晩年 6 つめとして自己超越を追加したらしい）に定義している。人間の欲求は段階的にみたされるもので、低次の欲求がみたされると、より高次な欲求がうまれるということを提唱した。

1. 生理的欲求
2. 安全欲求
3. **社会的欲求**
4. 尊厳欲求
5. 自己実現欲求

3 つめの社会的欲求は集団への帰属をもとめる欲求。おそらく他人とのつながりをもとめるのはこの欲求からくるはず。人間やはり孤独はつらいもの。独房にとじこめる罰があるのもそういうことだろう。これがみたされないと鬱になることがあるという。

インターネットがたのしいのは社会的欲求がみたせるからというのはありそうだということにしておく。

共有するというのはやっぱりたのしい。ゲームはひとりでやるよりだれかとやったほうがたのしい。いまは廃れたけれど、旅行の写真を焼き増しして一緒に行った人にあげる、というのはむかしからある。いまは一緒に行った人以外にもかんたんに写真を共有することができる。

とはいえ、いいことばかりでもない。ポジティブな共有もあればネガティブな共有もある。SNS で他人の負の感情に共感してストレスをかかえたりするのはよくあることだとおもう。

脱線した。書いていておもったのは、他人と共感するとかそういうのが現実じゃなくてインターネットでできるのがおもしろいとおもったのかもしれない。現実のオルタナティブ（代替現実）としてのネットのおもしろいところは拡張性とだれでも発信者になれるところかもしれない。

ネットで出来ることはどんどんふえている。文章での発信にはじまり、画像や音声や動画といったメディアでも発信できるようになった。技術の進歩でいろんな方法でコミュニケーションできるようになった。動画配信にコメントしたりオンライン飲み会したり VR Chat したり。ゲームをいっしょにやるひとがふえたのは個人的にとてもうれしい。

だれでも発信者になれるという視点でいうと、たとえばおいしい料理のレシピとかレビューをノートに書いても、そのノートを他の人にみせて回るか出版社に持ち込むかしないと発信したことにはならない（伝えられる人数がすくない）が、ネットがあればより多くのひとにみてもらうチャンスがあるとおもう（他の人にみせて回るのにはネットのやりかたでそれ相応の工夫をしなければいけないが、プラットフォームはたくさんあるのでハードルはとてもひくいはず）。

ざっくりいうとなんというか現実がひろがるようなところにもおもしろいとおもったのかもしれない。現実をスケールさせるかんじ？

実際にはネットがすきなひともオフ会たのしいねというひとは多いので、だれかと実際に会ってコミュニケーションするのは替えの効かない価値だとおもう。現実よりすぐれていることはないので、あくまで補完として（だれかと会うのが苦手というひとにとっては替えの効かない価値かも）。

## 4/29
[テレビは人間のつながりたいという欲求に負けたという話](http://blog.livedoor.jp/lionfan/archives/52682048.html)

とりあえずインターネットがなぜすきかというのはおわりにして、じゃあネットワークでなにがしたいのかということをかんがえる。

ネットワークの研究ってどんなのがあるのか。

- リソース制御（トラフィックや故障時の復旧など）
- セキュリティ
- 新しいアーキテクチャ
- P2P
- アドホックネットワーク
- データ収集（センサネットワーク）
- ネットワーク解析

自分の研究室は

- リソース制御
- 新しいアーキテクチャ
- アドホックネットワーク

あたりをやっている。

現状どんな問題がネットワークで起きている（起きうる）のか。

- インフラとしての課題
  - みんながいつもつかえないといけない
    - 障害に強くする
      - フェールソフト（つかえないよりはマシの精神）
      - 復旧をはやくする
      - そもそも起きないようにする
        - 動的なリソース割り当てで輻輳対策とか
    - 災害時でもつかえるようにする
      - アドホックネットワーク
        - モバイル端末の電力消費量の問題がある
- 質的な課題
  - セキュリティ
  - データを収集・解析
  - 速度

やっぱりネットワークはインフラなので、みんながいつもつかえるほうがいいとおもう。やはりそういう方針にしたい。みんながいつも、というのは災害などの特殊なシチュエーションではなくて、ふだんの生活のなかでという意味。災害時のインフラとしてネットワークの優先度はどうしても低いとおもう（そもそも電力というインフラに依存しているし）。障害は絶対におきるけど、できればおきないでほしいので、そういう方針にしたいかな。

IoT とか MaaS があたりまえになるとトラフィックがたいへんなことになるので、どうにかしてトラフィックを減らしたり、パンクしないようにやりくりする、というのが差し迫った問題だとおもっている。それを解決するためにエッジコンピューティング（フォグコンピューティング）というかんがえかたが 10 年ぐらいまえからあるらしい。クラウドを多層化して、末端のクラウドでデータをほしいカタチに処理してから中央のクラウドに送信することで、トラフィックをへらすことができる。個人的にはコンピュータの性能が格段にあがらないかぎりは処理をどんどん分散させる方向にすすむとおもっているので、おそらく主流になってくるとおもっている。

ということで掘りさげてみた。

<a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-text="Diary 4/20-29 進捗・散歩・興味 |" data-url="https://franknyro.github.io/blog/archives/202004301206/">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>