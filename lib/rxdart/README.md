# RxDart
package:
- [rxdart](https://pub.dev/packages/rxdart) v0.27.2
## 概要
- `rxdart`自体は状態管理パッケージではなく、`Stream`の拡張版のようなパッケージ
- `Stream`の拡張版なので、streamを使った状態管理手法である`BLoC`パターンに活用する事が出来る
- 様々な言語でライブラリが提供されている`ReactiveX`のdart版
- 初版リリースは2015年10月

## 全体像
- 状態変数の変更を通知する`Stream`を定義し、それを`StreamBuilder`で受け取る
- `RxDart`はあくまでも`Stream`の拡張版であり、依存関係の注入をする為のクラスなどは存在しないので、`Provider`や`Riverpod`などを使って適宜注入する
- 状態の変更を発火するメソッドは状態管理クラスに直接アクセスして実行する
- 構成としては`bloc`パッケージの`cubit`を使った`BLoC`パターンの構成に近い

## キーとなるクラスやメソッド
### `Stream`クラス
- flutterで用意されている `Stream`クラスと同じですが、`RxDart`では様々なコンストラクタが用意されており、多種多様な`stream`インスタンスを生成する事が出来ます。

### `Subject`クラス
- `RxDart`では複数の`Subject`クラスという`StreamController`に様々な機能を拡張したクラスが用意されています。
- これらは全てブロードキャスト状態の`StreamController`+αの様なイメージです
- その中でも代表的なのが`PublishSubject`、`BeghaviorSubject`、`ReplaySubject`クラスです。
#### `PublishSubject`クラス：
- ブロードキャスト状態のStreamControllerとほぼ同じです。違いは`stream`と`sink`、両方を兼ね備えている事。`PublishSubject`クラスは最もシンプルな形の`Subject`クラスです。
```dart
final streamSubject = PublishSubject<String>();

streamSubject.listen((addData){
print(addData);
});

streamSubject.sink.add('1st State');
```
#### `BehaviorSubject`クラス：
- `PublishSubject`の機能に加え、「初期値の設定」と「最後にsink.addしたオブジェクトをキャッシュする」機能が付いた`Subject`クラスです。
- `BehaviorSubject<T>.seeded`コンストラクタを使う事でstreamの初期値を設定できます。
- これにより下記の①で定義したメソッドは初期値の`"1st state"`をまず実行します。
```dart
final streamSubject = BehaviorSubject<String>.seeded("1st state");

void main()async{
    streamSubject.listen((addData){ 
        print(addData); // ①
    })

    streamSubject.sink.add("2nd state");
    streamSubject.sink.add("3rd state");
    
    streamSubject.listen((addData){
        print(addData); // ②
    })
}
```
- また`BehaviorSubject`では最後に`sink.add`されたデータをキャッシュしている為、②で定義したメソッドで最後に`sink.add`された`"3rd state"`が実行されます。
- 上記プログラムを実行すると下記の様に結果が表示されます。
```bash
# 実行結果
$ 1st state # ①の実行結果。初期値がまず実行されます。
$ 2nd state # ①の実行結果
$ 3rd state # ①の実行結果
$ 3rd state # ②の実行結果
```

#### `ReplaySubject` クラス：
- `BehaviorSubject`が最後に`sink.add`されたデータをキャッシュしているのに対して、`ReplaySubject`は「`sink.add`した全てのデータのキャッシュを保持」します。
- その為、どのタイミングで`Subject`に対して`listen`し始めても、`sink.add`された全てのデータを受け取る事になります。
```dart
final streamSubject = ReplaySubject<String>();

void main()async{
    streamSubject.listen((addData){
        print(addData); // ①
    })

    streamSubject.sink.add("1st state");
    streamSubject.sink.add("2nd state");
    streamSubject.sink.add("3rd state");
    
    streamSubject.listen((addData){
        print(addData); // ②
    })
}
```
- 上記では①でも②でも`sink.add`した３つのイベントを全て取得する事になります
```bash
# 実行結果
$ 1st state # ①
$ 1st state # ②
$ 2nd state # ①
$ 2nd state # ②
$ 3rd state # ①
$ 3rd state # ②
```

- また`maxSize`フィールドで最後からいくつまでのイベントを受け取るか制限する事も出来ます。 
```dart
final streamSubject = ReplaySubject<String>(maxSize:2);

void main()async{

    streamSubject.sink.add("1st state");
    streamSubject.sink.add("2nd state");
    streamSubject.sink.add("3rd state");
    
    streamSubject.listen((addData){
        print(addData);
    })
}
```
- 上記では`maxSize:2`としているので最後から２個まで遡ったイベントを受け取る事が出来ます。
```bash
# 実行結果
$ 2nd state
$ 3rd state
```

## 準備
具体的にカウンターアプリを例に使い方を見ていきましょう。
### 1. Stateクラス
- 今回は`count`フィールドを持つ`CounterState`クラスを定義します。
```dart
class CounterState {
  CounterState(this.count);
  int count;
}
```

### 2. 状態管理(BLoC)クラス
- `RxDart`を用いて`BLoC`パターンを実現するので、状態管理クラスは`RxCounterBloc`クラスと命名しました。
- `state`と`counterSubject`(stream)のフィールドを持たせます。
- 今回は`BehaviorSubject`を使用し、初期値が設定出来る様にしています。
- コンストラクタの引数に渡したオブジェクトを`counterSubject`の`seeded`に渡し、初期値を設定しています。
```dart
class RxCounterBloc {
  CounterState state;
  BehaviorSubject<CounterState> _counterSubject;
  RxCounterBloc({this.state}) {
    _counterSubject = BehaviorSubject<CounterState>.seeded(this.state);
  }

  Stream get counterStream => _counterSubject.stream;
}
```
- コンストラクタ以下には状態変更を発火するメソッド`increment`,`decrement`,`clear`を用意しました。
- これらのメソッドでは新しい状態値を`sink.add`する事でUI側に状態の変更を通知します。
- またStreamが用済みになった際に破棄する為の`dispose`メソッドも定義しておきます。
```dart
  void increment() {
    state = CounterState(state.count + 1);
    _counterSubject.sink.add(state);
  }

  void decrement() {
    state = CounterState(state.count - 1);
    _counterSubject.sink.add(state);
  }

  void clear() {
    state = CounterState(0);
    _counterSubject.sink.add(state);
  }

  void dispose() {
    _counterSubject.close();
  }
```

### UIへ注入
- 前述の通り、`rxdart`パッケージには依存性注入のクラスは用意されていないので、好みの方法でUIへ注入します。
- 本サンプルでは`provider`パッケージの`Provider`クラスを使って注入していきます。

```dart
  @override
  Widget build(BuildContext context) {
    return Provider<RxCounterBloc>(
      create: (_) => RxCounterBloc(state: CounterState(0)),
      child: _RxdartCounterPage(),
    );
  }
```

## 状態へのアクセス

## 参考
- https://qiita.com/temoki/items/b859b55a06bd86fdfe25
- http://reactivex.io/
- https://medium.com/flutter-community/why-use-rxdart-and-how-we-can-use-with-bloc-pattern-in-flutter-a64ca2c7c52d
- https://pub.dev/documentation/rxdart/latest/rx/rx-library.html