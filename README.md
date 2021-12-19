# Flutter State Management 101
この記事の目的は数あるFlutterの状態管理手法の特徴とその違いを明確にし、状態管理手法の全体像を掴む事です

## Flutterの状態管理手法って沢山ありますよね

ネットで「flutter 状態管理」で検索するとやれProviderだのやれBlocだのRiverpodだのと様々なライブラリを使ったパターンが出てきます

しかも人によって同じ状態管理手法と言ってる割には書き方がだいぶ違ったり、1つの状態管理手法を違う名前で言っていたりとなんやねーん！と混乱してしまう記事が多いなと感じました

仕事でFlutterを使い始めて1年半、`Provider`を使ってきましたが、最近`Riverpod`の名前もよく聞く様になったし、ちょっと触ってみようかなと思った矢先、先の検索結果の迷宮に迷い込みました

折角なのでこの機会に`Riverpod`だけでなく主要な手法を一通り触って一網打尽にしてやろうと思ったのがキッカケです

## アプローチ

このプロジェクトではシンプルなカウンターアプリを、「Flutter界隈でよく出てくる状態管理手法」として独断と偏見で選んだ以下のパッケージ・パターンを用いて書き直してみました

同じアプリを違う手法で書く事によって相違点を浮き彫りにしてやろうという訳です

1. Provider
2. Bloc
3. Redux
4. RxDart
5. MobX
6. getX
7. State Notifier

もっとマイナーな手法を探せばまだまだありますが、これらを網羅しておけば大体の全体像は掴めるかなと思います


## あれ？

あれ？さっきあんなに言ってた`Riverpod`入ってないじゃん！と思った方、そうです、それこそ自分がこの試みを通して学んだ事の1つでした。

そんな訳で現在は主流ではない手法も含めて複数の状態管理手法を触ることで見えてきたものがいくつかありました
# このプロジェクトを通して見えた事
## 1. ProviderとRiverpodは状態管理手法ではないのでは？
実は`Provider`パッケージと`Riverpod`パッケージは直接的には状態管理用のライブラリではありません。厳密には依存関係を注入する為のライブラリです。

`Provider`はwidgetツリーに沿って依存関係を下位のクラスに流し込み、`Riverpod`はwidgetツリーに縛られる事なくグローバル変数としてツリーのどこにあるwidgetにも依存関係を注入する事が出来るパッケージです

状態管理の核となる状態管理クラス自体は他のパッケージのモノを使い生成する必要があります。

散々「flutter 状態管理」で調べると`Provider`と`Riverpod`の名前出てくるのに！と自分も思いました

またこれが「Provider」「Riverpod」と銘打った記事でも書き方に違いがある原因でもありました

例えば`Riverpod`を解説した記事では`StateNotifier`を一緒に使う例が殆どで`StateNotifier`でないといけないような印象を受けますが、実はそんな事はなく`Riverpod`は`ChangeNotifier`に対応した`ChangeNotifierProvider`も実装しています

ではなぜ`Provider`を状態管理手法として挙げているのかというと、これは`changeNotifier` x `Provider` = `Provider`パターンとして定着している為です

ただGoogleが紹介している状態管理手法の中にRiverpodが含まれている事もあり、ここの切り分けについては色々と議論がありそうです。

とはいえ、管理手法としての`Provider`とパッケージとしての`Provider`が混同されている事により混乱する人は私だけじゃないのではと思い、切り分けさせてもらいました

## 2. Providerは多くの状態管理手法で取り入れられている
またFlutterの状態管理を調べていく時にこんがらがるのが、`Provider`が様々な状態管理手法で取り入れられている為でした

今回紹介する状態管理手法の中でも、Blocには`BlocProvider`,Reduxには`StoreProvider`、StateNotifierには`StateNotifierProvider`、MobXとRxDartも`Provider`を用いて依存関係の注入を行なっています

`Provider`があくまでも依存関係の注入を行うライブラリである事を理解していれば、不思議なことはありませんが、`Provider`って状態管理手法の１つでしょ？Providerとそれ以外の手法の線引きってどうなってるの？と最初混乱しました

## 3. MutableとImmutable、2つの重要なパラダイム
状態管理手法を選定する際にトピックとして上がるのが、Mutableな状態オブジェクトを扱うかImmutableな状態オブジェクトを扱うかです

状態管理をする際に現在の状態を表す変数(状態変数)を管理する事になりますが、このオブジェクトが更新可能なオブジェクトにするのか(Mutable)、それとも更新の度に新しいインスタンスを生成し差し替えるのか(Immutable)の違いになります

Mutableな状態オブジェクトの管理では変更したいフィールドのみに変更を加える為、直感的で分かりやすいですが、アプリケーションの様々な場所から参照され、また変更をしている場合、変更が意図しないタイミングで行われてしまったり、意図しない変更が加わってしまったり、副作用があります

状態オブジェクトをImmutableにする事で、参照しているオブジェクトの状態を一意にする事でそれらの副作用の発生を防ぐ事ができます。ただその代わり、状態変更の度にインスタンスを生成する必要がある事や、dartの==オペレーターでは値比較が出来ない為、ライブラリを使う必要がある等、準備が大変な一面もあります

今回試した手法では以下のように分かれます

Mutable
- StatefulWidget
- ChangeNotifier x Provider
- GetX

Immutable
- BLoC(Cubit)
- StateNotifier x Provider
- Redux
- RxDart
- MobX x Provider
#### 参考
- https://medium.com/flutter-jp/immutable-d23bae5c29f8
- https://qiita.com/k3ntar0/items/f14b0b03fbc13d0ed925
- https://dart.academy/immutable-data-patterns-in-dart-and-flutter/


## 4. 状態管理手法の変遷
その他、リリース順に並べてみることでどういった方向に状態管理手法のトレンドが動いているのかなんとなく掴む事も出来ました

ライブラリを初回リリース時期の順に並べると以下の通りとなります。
Flutterは元々Reactを参考に作られているだけあって、初期はReactで使われていたReduxやReactiveプログラミングのライブラリであるRxdart、Blocなどの開発から始まり、その後、Flutterのwidgetツリー構造を利用したProviderへ。そしてWidgetツリー構造を利用したProviderが成熟して来たところで、今度はツリー構造から解放されたGetXやStateNotifierが注目を集めてきたという流れになりそうです。

BlocはGoogle自ら開発した状態管理手法でありながら、2019年に正式にGoogleがProviderを推奨している事から、FlutterにおいてはStreamをベースとしたReactiveな状態管理から離れていってる様な印象を受けます。が、手法の良し悪しというよりblocの方がえてしてProviderよりも記述量が多くなりがちだったり、学習コストが高いという理由からProviderが推奨される様になった様です。

1. `Rxdart` 2015/10
2. `Redux` 2017/8
3. `Bloc` 2018/10
4. `Provider` 2018/10
5. `Mobx` 2019/1
6. `GetX` 2019/11
7. `StateNotifier` 2020/3

# 参考
- https://docs.flutter.dev/development/data-and-backend/state-mgmt/options