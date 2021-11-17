# MobX
package: 
- [flutter_mobx](https://pub.dev/packages/flutter_mobx) v2.0.2
- [build_runner](https://pub.dev/packages/build_runner) v2.1.2
- [mobx_codegen](https://pub.dev/packages/mobx_codegen) v2.0.2

## 概要
- 状態管理クラスを自動生成して使うユニークな状態管理手法
- `MobX`自体は元々Javascript(主にReact)で使う為に開発された設計思想
- [Pavan Podira](https://github.com/pavanpodila)氏が開発
- 初版リリースは2019年1月
## 全体像
### MobXとは？
前述の通り、Reactと共に使う為に開発された設計思想で以下3つの構成要素から成ります。
1. Observables：監視される状態値
2. Actions：状態値の変更を発火する指示
3. Reactions：状態値の変更に反応して走る再描画や処理
![mobx](https://user-images.githubusercontent.com/44666053/135720242-0a8ea753-2db6-4b88-9ba8-c7c2865bef0f.png)

### アノテーション
`MobX`では状態管理クラスの事を`MobX Store`と呼び、`flutter_mobx`パッケージでは`Store`内の変数や処理に以下アノテーションを付記する事でそれぞれの役割を指定します。

- `@observable`：指定された変数を監視対象にし変更を検知する事が出来る様になります。
- `@action`：状態値の変更を行うメソッドに付記します。状態値の変更は全てこのActionメソッド内で行わなければなりません。
- `@computed`：observable値自体に変更を加えないが、値を使って別の値を算出するような場合に使われます。主にobservable値を使ったgetterメソッドに対して付記します。


その後、`build_runner`、`mobx_codegen`によってアノテーションの指定に沿って状態管理に使うクラスやメソッドを自動生成してくれます。

## キーとなるクラスやメソッド

- `Observer`クラス：ラップしたWidgetをstoreのobservable変数の変更に反応して再描画させるクラス

今回のサンプルでは使用していませんが、observableの変更に応じて再描画するだけでなく、以下メソッドで処理を走らせる事が出来ます。
- `reaction`メソッド：observable変数が違う値になった場合の実行される処理を定義できます
```dart
reaction((_) => store.count, (count) => print(count));
```
- `autorun`メソッド：メソッド内で使われてるobservable変数に変更があった場合、実行される処理を定義できます
```dart
autorun((_) => print(store.count));
```
- `when`メソッド：observable変数が指定した条件に合致する場合のみ実行される処理を定義できます
```dart
when((_) => store.count == 5, () => print('Count reach to 5'));
```

## 準備
カウンターアプリを例に実際描いてみましょう。
### 1. パッケージのインポート
コード生成は開発環境で行う為、`build_runner`と`mobx_codegen`は`pubspec.yaml`の`dev_dependencies`に追記します。
```yaml
dependencies:
  flutter_mobx: ^2.0.2

dev_dependencies:
  build_runner: ^2.1.2
  mobx_codegen: ^2.0.2
```
### 2. Stateクラス
- 今回はCountフィールドを持つ`CounterObj`クラスを定義。

```dart
class CounterObj {
  CounterObj(this.count);
  int count;
}
```

### 3. 状態管理クラス(MobX Store)
- 前述の通り、flutterのMobXでは状態管理用のコードを自動生成する為、MobXの書き方に従って、状態管理クラスの素を作ります。
- 以下の３つを記述していきます
  1.  生成されるコードのファイル名
  2.  自動生成されたクラスをミックスインする状態管理クラス 
  3.  `Store`クラスをミックスインした抽象クラス

```dart
// ①生成されるコードのファイル名
part 'counter_store.g.dart'; 

// ②状態管理クラス
class CounterStore = CounterStoreBase with　_$CounterStore; 

// ③Storeをミックスインした抽象クラス
abstract class CounterStoreBase with Store { 
  @observable
  CounterObj countObj = CounterObj(0);

  @action
  void increment() {
    countObj = CounterObj(countObj.count + 1);
  }

  @action
  void decrement() {
    countObj = CounterObj(countObj.count - 1);
  }

  @action
  void reset() {
    countObj = CounterObj(0);
  }
}

```
`observables`や`actions`は③の抽象クラスに記述していきます。

上記クラスを定義した状態だとエラーが出ますが、無視して大丈夫です。
記述後、以下コマンドをコマンドラインから実行します。
```zsh
$ flutter pub run build_runner build
```
するとコードが自動生成され、エラーも解消します。

### 4.UIへ注入
- `flutter_mobx`パッケージでは依存関係の注入の為のクラスは用意されていないので、`provider`パッケージを使用します。
- `create`フィールドで状態管理クラス`CounterStore`をインスタンス化
- `child`フィールドに定義した`_MobxCounterPage` widgetにインスタンスを注入

```dart
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CounterStore(),
      child: _MobxCounterPage(),
    );
  }
```
さあ、これで`_MobxCounterPage` widgetより下に位置する全てのWidgetで`CounterStore`クラスにアクセスできる様になりました。

## 状態へのアクセス
### `MobX Store`へのアクセス
状態管理クラスへのアクセス自体は`Provider`で依存関係を注入しているので、`Provider`を通してアクセスします。

```dart
  final CounterStore store = Provider.of(context);
```
### `observable`の変更に伴った再描画
- `observable`となった状態変数の変更に応じてWidgetを再描画させる場合は`Observer`クラスを使います。

 ```dart
    Observer(
    builder: (context) => Text(
      '${store.countObj.count}',
      style: Theme.of(context).textTheme.headline4,
    ),
  ),
 ```

### `actions`へのアクセス
こちらもProvider経由でアクセスする事が出来ます。
```dart
  FloatingActionButton(
    onPressed: () => store.increment(),
    tooltip: 'Increment',
    heroTag: 'Increment',
    child: Icon(Icons.add),
  ),
```

今回は例がシンプル過ぎて使いませんでしたが`reaction`、`autorun`、`when`を使う様な状況が発生した場合、本領を発揮する状態管理手法だと思います。

## 参考
- https://itome.team/blog/2019/12/flutter-advent-calendar-day23/
- https://itnext.io/flutter-state-management-with-mobx-and-providers-change-app-theme-dynamically-ba3b60619050