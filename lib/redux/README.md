# Redux
package: 
- [flutter_redux](https://pub.dev/packages/flutter_redux) v0.8.2
- [redux](https://pub.dev/packages/redux) v5.0.0

## 概要
- Reduxは状態管理手法であり、アーキテクチャでもある
- FacebookによってReactを使った状態管理アーキテクチャとして考案された
- Reactを使ってきた人には馴染みが深いはず
- アプリ全体でたった1つのクラスに全ての状態値を集約させる管理手法
- [Brian Egan](https://github.com/brianegan)氏が開発
- 初版リリースは2017年08月

## 全体像
### Reduxとは？
前述した通り、Facebookが考案した状態管理手法で以下の3つの基本理念を元に考案されました。
1. Single source of truth：単一の状態管理クラス
2. State is read only：状態値は読み取りのみ
3. Changes are made with pure function：変更は関数を通してのみ行われる

コレらの理念に基づき考案されたReduxは「アプリ全体の状態値をたった1つの状態管理クラスに集約」し、「関数によって読み取り専用のimmutableな状態値を生成する」事で状態管理を行います。

そしてもう1つ重要な特徴は「単一方向に流れるデータの流れ」です。

### Reduxの構成要素
上記の特徴を持つReduxアーキテクチャは以下の5つのプレーヤーで構成される。
1. `Store`：状態管理クラス
2. `View`：状態値を活用するUI
3. `Action`：UIからStoreへ状態値の変更を指示するオブジェクト
4. `Reducer`：状態値を変更し、UI側に返す関数
5. `Middleware`：ActionがReducerに渡される前に外部APIと連携し処理を行う
   
 `View`は状態値の変更を`Action`オブジェクトを状態管理クラスである`Store`に送る(dispatch)事で要請する。
 
 Storeは受け取ったActionオブジェクトに対応した`Reducer`を実行し、再びViewに状態値を渡します。
 
 Reducerで処理を行う前に外部APIと連携する必要がある時は `Middleware`が橋渡し役を担います。

 <img width="453" alt="スクリーンショット 2021-10-04 22 02 32" src="https://user-images.githubusercontent.com/44666053/137484916-004b6969-4344-4b37-8970-48ea1165abba.png">

## キーとなるクラスやメソッド
- `Store`クラス：状態管理クラス
- `StoreProvider`クラス：Widgetツリーに沿って状態管理クラスの依存関係を注入するクラス
- `StoreConnector`クラス：ラップしたWidgetにStoreへのアクセスを可能にするクラス
- `dispatch`メソッド：StoreへActionオブジェクトを送るメソッド

## 準備
具体的にカウンターアプリを例に使い方を見ていきましょう。

### 1. Stateクラス
- 今回はCountフィールドを持つ`CounterState`クラスを定義。
- 前述の通り、Stateは読み取りのみ = `immutable`なオブジェクトになります
  
```dart
@immutable
class CounterState {
  final int count;
  const CounterState({this.count = 0});
}
```
- 今回管理するStateクラスは上記の`CounterState`だけですが、アプリ全体で管理する状態値を全て保持する事になるので、複数の状態値の塊となる`RootState`クラスを定義します。

```dart
@immutable
class RootState {
  final CounterState reduxCounterState;

  RootState({this.reduxCounterState = const CounterState()});
}
```
### 2. Actionクラス
- `View`側から`Store`にdispatchされる`Action`クラスを用意します。
- 今回はincrement、decrement、resetの3つのアクションを用意します。

```dart
class IncrementAction {
  IncrementAction();
}

class DecrementAction {
  DecrementAction();
}

class ResetAction {
  ResetAction();
}
```
### 3. Reducer
- `Action`オブジェクトを受け取り、それに応じて処理を行い、状態値を返すメソッド`Reducer`に集約させます。
- 所謂ビジネスロジックそのものですね。
- `Store`のコンストラクタに渡す為、第二引数`Action`の型は`dynamic`である必要がある様です

```dart
CounterState counterReducer(CounterState state, action) {
  // type of second argument needs to be `dynamic`, to be able to pass into Store constructor.
  if (action is IncrementAction) {
    return CounterState(count: state.count + 1);
  } else if (action is DecrementAction) {
    return CounterState(count: state.count - 1);
  } else if (action is ResetAction) {
    return CounterState();
  } else {
    return state;
  }
}
```
- `Store`が取り扱うのはあくまでも状態値の集合体となる`RootState`なので、先ほどの`counterReducer`をラップする親Reducerである`rootCounterReducer`を定義します。

```dart
RootState rootCounterReducer(RootState state, action) {
  return RootState(
      reduxCounterState: counterReducer(state.reduxCounterState, action));
}
```

### 4. 状態管理クラス(`Store`)
- 状態管理クラスである`Store`をインスタンス化
- 引数にビジネスロジックである`Reducer`と状態の初期値を渡す
- Storeはwidgetツリーの最上層で生成する

```dart
  final store = Store<RootState>(rootCounterReducer, initialState: RootState());
```

### 5. `View`へ注入
- `redux`パッケージでも依存関係の注入には`Provider`を使用します。
- `provider`パッケージの時とほぼ同じです。違いは`flutter_redux`パッケージの`StoreProvider`を使う事くらい。
- `store`フィールドにインスタンス化した`Store`を渡す
- `child`フィールドに定義した`_ReduxCounterPage` widgetにインスタンスを注入
```dart
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: _ReduxCounterPage(),
    );
  }
```

さあ、これで`_ReduxCounterPage` widgetより下に位置する全てのWidgetで`Store`クラスにアクセスできる様になりました。

## 状態へのアクセス
`Store`へのアクセスは全て`StoreConnector`クラスを使います。

### 状態値の取得
- `converter`フィールドにて取得する状態値を指定します
- `builder`フィールドでラップしたWidgetにconverterで定義した値を渡す事が出来ます
- `distinct:true`とする事で値が変わった時だけ再描画が走るようにする事ができます
```dart
  StoreConnector<RootState, int>(
    converter: (store) => store.state.reduxCounterState.count,
    distinct: true,
    builder: (context, count) => Text(
      '$count',
      style: Theme.of(context).textTheme.headline4,
    ),
  ),
```

### 状態値の変更
- 変更の場合は、`Action`オブジェクトをstoreの`dispatch`メソッドを使って`Store`に送る事で実行します
- `builder`フィールドでラップしたWidgetにconverterで定義したメソッドを渡す事が出来ます
```dart
  StoreConnector<RootState, VoidCallback>(
    converter: (store) => () => store.dispatch(IncrementAction()),
    builder: (context, dispatchIncrement) => FloatingActionButton(
      onPressed: dispatchIncrement,
      tooltip: 'Increment',
      heroTag: 'Increment',
      child: Icon(Icons.add),
    ),
  ),
```

## 参考