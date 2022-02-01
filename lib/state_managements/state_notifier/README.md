# StateNotifier
package: 
- [flutter_state_notifier](https://pub.dev/packages/flutter_state_notifier) v0.7.1

## 概要
- Provider、Freezed、Riverpodなどの作者でもある[Remi Rousselet](https://github.com/rrousselGit)氏が開発
- 単一の値を保持し、その値の変更を通知する`ValueNotiifer`の拡張版のようなクラス
- `Riverpod`と`Freezed`と併せて使う例がよく見られる
- 初版リリースは2020年3月
## 全体像
### 特徴：
1. 単一の状態変数を保持し、その変数の変更を自動で通知する

`ChageNotifier`が複数の変数を管理し、`notifyListeners`メソッドで明示的に変更を通知し、再描画などを促すのに対し、`StateNotifier`は単一の状態変数だけをスコープに持ち、その変数に変化があった場合、自動的に通知を飛ばす。

その為、複数の状態変数を管理したい場合は、状態クラスに複数のフィールドを持たせ管理する事になります。

実際には状態クラスが持つフィールドを直接変更する事も出来ますが、状態クラスはデータを保持するだけのクラスなのでなるべくimmutableな管理をする事でより堅牢な管理が可能になります。

immutableな管理を行う事が多い為、`freezed`などimmutableなクラスを生成するツールと組み合わせる事が多いようです。
 
### 依存関係の注入：

依存関係の注入は同じ開発者が作成した`Provider`、`Riverpod`どちらかのパッケージと組み合わせて行います。


今回は`StateNotifier`パッケージに用意されている`StateNotifierProvider`を使いますが、`provider`パッケージの`Provider`と同じです。Widgetツリーに沿って依存関係を下に流していきます。
## キーとなるクラスやメソッド
- `StateNotifier`クラス：状態管理クラスが継承するクラス
- `StateNotifierProvider`クラス：状態管理クラスを注入するクラス
## 準備
具体的にカウンターアプリを例に見ていきましょう。
### 1. Stateクラス
前述の通り、immutableな状態クラスを定義します。
```dart
@immutable
class CounterState {
  CounterState({this.count});
  final int count;
}
```
`freezed`などと組み合わせる事が多い様ですが、今回はシンプルにする為、そういったパッケージは用いません。

### 2. 状態管理クラス
- `StateNotifier`クラスを継承する状態管理クラスを定義します。
- `StateNotifier`が管理する状態クラスの型を明示します。(今回は`CounterState`クラス)

- `state`で管理している状態変数にアクセスする事ができます。
- コンストラクタで渡す初期値も、状態値を変更するメソッドでも`state`に新しい`CounterState`インスタンスを代入しています。

```dart
class CounterStateNotifier extends StateNotifier<CounterState> {
  CounterStateNotifier() : super(CounterState(count: 0));

  void increment() => state = CounterState(count: state.count + 1);
  void decrement() => state = CounterState(count: state.count - 1);
  void reset() => state = CounterState(count: 0);
}
```

### 3. 依存関係の注入
- `StateNotifier`パッケージに用意されている`StateNotifierProvider`クラスを使って、依存関係を注入します。
- とはいえ裏で`provider`パッケージを使っているので実際には同じ`provider`です。
- - `create`フィールドで状態管理クラス`CounterStateNotifier`をインスタンス化
- `child`フィールドに定義した`_StateNotifierCounterPage` widgetにインスタンスを注入

```dart
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<CounterStateNotifier, CounterState>(
      create: (context) => CounterStateNotifier(),
      child: const _StateNotifierCounterPage(),
    );
  }
```

これで準備は整いました。
## 状態へのアクセス
前述の通り、裏で`provider`を使ってるので状態へのアクセスも`provider`と同じ`context.watch`と`context.read`を使いたいと思います。

### 状態値の監視
- `context.watch()`で状態値の変更を監視し、変更に応じてwidgetを再描画します。
- ただ`build`メソッド内で`context.watch()`を定義してしまうと状態が変化する度にwidgetが丸ごと再描画されてしまいます。
```dart
  Widget build(BuildContext context) { 
    // ProviderCounterStateの値が変わる度にbuildメソッドが走る
    final ProviderCounterState state =
        context.watch<CounterStateNotifier>(); 
    return Scaffold(
      appBar: MainAppBar(
        title: 'StateNotifier x Provider',
        ...
```
- これでは再描画する単位が大きくパフォーマンスが悪いので、変更に応じてラップしているwidgetだけを再描画する`Consumer`クラスを使用する事で再描画される範囲を限定する事が出来ます。

```dart
  Consumer<CounterState>(
    builder: (context, state, _) => Text(
      state.count.toString(),
      style: Theme.of(context).textTheme.headline4,
    ),
  ),
```
- 実際に状態値を参照して描画しているText widgetだけを`Consumer`クラスでラップする事で状態値が変更しても再描画されるのはラップされたText Widgetだけになりました。

### メソッドへのアクセス
状態変数を変更するメソッドへのアクセスは単発的に状態管理クラスにアクセスする`context.read()`を使います。

```dart
  FloatingActionButton(
    onPressed: () => context.read<CounterStateNotifier>().increment(),
    tooltip: 'Increment',
    heroTag: 'Increment',
    child: Icon(Icons.add),
  ),
```
以上です。





## 参考
- https://itome.team/blog/2020/05/flutter-state-notifier-provider/ (JP)
- https://dev.to/marcossevilla/statenotifier-an-improved-changenotifier-3f84 (EN)
- https://qiita.com/_masaokb/items/fe77495db0aeba226d2a (JP)