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

また常に新しい`State`オブジェクトをStreamに流す為、状態値を変更していくわけではなく`Immutable`な状態値を扱う状態管理手法となります。
### BlocクラスとCubitクラス
`BLoCパターン`に沿った状態管理を単体で実現する為に作られたのが`bloc`パッケージです。

状態管理クラスは`bloc`パッケージが用意してくれている`Bloc`クラスを継承するのですが、より簡易的な`Cubit`クラスと言うものも用意されています。

`Bloc`クラスを使う場合、状態値をStreamに流し込むメソッドを発火するのに`Event`オブジェクトをStream経由で渡す必要があります。

`Cubit`クラスを使う場合は状態管理クラスに定義したメソッドに直接アクセスする事が出来、状態値をStreamに流し込む為の`emit`メソッドと言うのが用意されています。

図で表すと下記のようなイメージ

<絵>

## キーとなるクラスやメソッド
Blocを使う場合、
- `Bloc`クラス：状態管理クラスにBloc機能を継承するクラス
- `Event`オブジェクト：状態管理クラス内のメソッドを発火させる指示を与えるオブジェクト
- `mapEventToState`メソッド：UIから流されてくるEventオブジェクトを一手に引き受け、対応する処理を実行するメソッド。EventとStateの繋ぎ役。

Cubitを使う場合、
- `Cubit`クラス：状態管理クラスにCubit機能を継承するクラス
- `emit`メソッド：`State`オブジェクトをUIに繋がるStreamに流すメソッド

Bloc、Cubit共通、
- `State`オブジェクト：UIに繋がるStreamに流される状態値のオブジェクト
- `BlocProvider`クラス：Widgetツリーに沿って状態管理クラスの依存関係を注入するクラス
- `BlocBuilder`クラス：`State`オブジェクトが流れてくるStreamを監視し、`State`オブジェクトに応じてラップした子widgetを再描画するクラス
## 準備
具体的にカウンターアプリを例に使い方を見ていきましょう。まずは`Bloc`クラスを使った場合から。

### 1. Stateクラス
- 今回はCountフィールドを持つ`CounterState`クラスを定義。
- この`CounterState`オブジェクトがEventに応じて、UI側にStreamを通じて流し込まれていきます。

`Equatable`は「同じ状態値を持つインスタンスを同一として扱うクラス」です。 `bloc`パッケージと同じ開発者が開発している為、相性が良く一緒に使われている例が多いです。

```dart
class CounterState extends Equatable {
  final int count;
  const CounterState({@required this.count});

  @override
  List<Object> get props => [count];
}
```
### 2. Eventクラス
次にUI側から状態管理クラスにStreamを通じて流し込まれる`Event`クラスです。
今回はincrement、decrement、resetの3つのイベントを用意します。

```dart
abstract class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object> get props => [];
}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ResetEvent extends CounterEvent {}
```
### 3. 状態管理クラス
- `Bloc`クラスを継承する事で`mapEventToState`メソッドを使える様になります。
- UI側から流れてきた`Event`オブジェクトを検知し、それに応じた処理の分岐を記述します。
- また最新の`State`オブジェクトを格納した`state`変数にアクセスすることもできます。

```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield CounterState(count: state.count + 1);
    } else if (event is DecrementEvent) {
      yield CounterState(count: state.count - 1);
    } else if (event is ResetEvent) {
      yield CounterState(count: 0);
    } else {
      yield CounterState(count: state.count);
    }
  }
}
```

### 4.UIへ注入
- `bloc`パッケージでも依存関係の注入には`Provider`を使用します。
- `provider`パッケージの時とほぼ同じです。違いは`flutter_bloc`パッケージの`BlocProvider`を使う事くらい。
- `create`フィールドで状態管理クラス`CounterBloc`をインスタンス化
- `child`フィールドに定義した`_BlocCounterPage` widgetにインスタンスを注入
```dart
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: const _BlocCounterPage(),
    );
  }
```

さあ、これで`_BlocCounterPage` widgetより下に位置する全てのWidget`CounterBloc`クラスにアクセスできる様になりました。

## 状態へのアクセス
### UI➡︎状態管理クラスのStream
状態管理クラスへ続くStream、言うなれば上りのStreamにアクセスするには、`BlocProvider.of<T>(context)`もしくは`context.read<T>()`を使います。

`add`メソッドを使って、実行したい処理の`Event`オブジェクトを流し込みます。
```dart
final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

...
    FloatingActionButton(
        onPressed: () => counterBloc.add(IncrementEvent()),
        tooltip: 'Increment',
        heroTag: 'Increment',
        child: Icon(Icons.add),
    ),
...
```
### 状態管理クラス➡︎UIのStream
状態管理クラスからUIへの下りのStreamへのアクセスには`BlocBuilder`クラスを使います。

ラップしたWidgetにStreamで流れてきた`State`オブジェクトを通知し、UIを再描画します。
```dart
    BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) => Text(
        '${state.count}',
        style: Theme.of(context).textTheme.headline4,
        ),
    ),
```
## Cubitの場合
`Cubit`クラスを使った場合は以下のような違いがあります
1. 処理の発火には状態管理クラスのメソッドに直接アクセスする
     - 状態管理クラスへの上りのStreamがなくなる
     - `Event`クラスが不要
     - `mapEventToState`メソッドが不要
2.  状態値の流し込みには`emit`メソッドを使う

### 状態管理クラス
`emit`メソッドの引数に渡された`state`オブジェクトがUI側に向かうStreamに流し込まれていきます。

```dart
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(0));

  void increment() => emit(CounterState(state.count + 1));
  void decrement() => emit(CounterState(state.count - 1));
  void reset() => emit(CounterState(0));
}
```

### メソッドへのアクセス
`provider`パッケージを使う場合と全く同じです
```dart
    FloatingActionButton(
        onPressed: () => context.read<CounterCubit>().increment(),
        tooltip: 'Increment',
        heroTag: 'Increment',
        child: Icon(Icons.add),
    ),
```

## 参考