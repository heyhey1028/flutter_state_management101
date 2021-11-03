# BLoC
package: 
- [bloc](https://pub.dev/packages/bloc) v7.2.1
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) v7.3.1
## 概要
- `Provider`の次に人気な状態管理手法(pub.devのLIKE数は2番目に多い)
- `Stream`を活用した状態管理手法
- リアクティブプログラミングの考え方をベースに考案された`BLoCパターン`を実現するパッケージ
- `Equatable`パッケージなどをリリースしている[Felix Angelov](https://github.com/felangel)氏が開発
- 初版リリースは2018年08月

## 全体像
### BLoCパターンとは
BLoCとは「Business Logic Component」の略語。その名を冠した`BLoCパターン`はビジネスロジックを集約したコンポーネントを活用し状態管理を行う手法です。

最大の特徴は`Stream`を活用している事。Streamを活用する事で常に流し込まれる状態値を監視し、反応的(リアクティブ)にUI側を更新していきます。

BLoCパターンは以下によって構成されます
1. ビジネスロジックを集約した状態管理クラス
2. 状態管理クラスにEventオブジェクトを流し込むStream
3. 受け取ったEventオブジェクトに応じて状態オブジェクトをUIに流し込むStream

<絵>
### BlocクラスとCubitクラス
`BLoCパターン`に沿った状態管理を単体で実現する為に作られたのが`bloc`パッケージです。

状態管理クラスは`bloc`パッケージが用意してくれている`Bloc`クラスを継承するのですが、より簡易的な`Cubit`クラスと言うものも用意されています。

`Bloc`クラスを使う場合、状態値をStreamに流し込むメソッドを発火するのにEventオブジェクトをStream経由で渡す必要があります。

`Cubit`クラスを使う場合は状態管理クラスに定義したメソッドに直接アクセスする事が出来、状態値をStreamに流し込む為の`emit`メソッドと言うのが用意されています。

図で表すと下記のようなイメージ

<絵>

## キーとなるクラスやメソッド
Blocを使う場合、
- `Bloc`クラス：
- `Event`クラス：
- `mapEventToState`メソッド：

Cubitを使う場合、
- `Cubit`クラス：
- `emit`メソッド：

Bloc、Cubit共通、
- `State`クラス：
- `BlocProvider`クラス：
- `BlocBuilder`クラス：
## Steps

## References