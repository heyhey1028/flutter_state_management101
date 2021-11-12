# GetX

package: 
- [get](https://pub.dev/packages/get) v4.3.8

## 概要
- `GetX`自体は状態管理手法というよりFlutterのフレームワーク
- 状態管理、ルーティング、依存関係の注入に対する機能を提供
- [Jonny Borges](https://github.com/jonataslaw)氏が開発
- GithubのLIKE数では既にProviderを超える人気
- しかし作者が以前に自身のライブラリのパフォーマンスを誇張したり、他のライブラリに対して否定的なコメントを繰り返した為、一部のFlutter開発者からは嫌われている等論争の的になっているライブラリの様です
## 全体像
-  前述の通り、`GetX`自体はFlutter用のフレームワーク
-  その中の状態管理と依存関係の注入機能を今回は使います

特徴としては、
   -  contextを使わず、どこからでも状態管理クラスにアクセス可能
   -  状態変数自体をリアクティブなクラスでラップする

実際に例で見た方が早いかもしれません。
## キーとなるクラスやメソッド
- `GetxController`クラス：状態管理クラスが継承するクラス
- `Rx<T>`クラス：状態変数をラップし、監視可能なリアクティブなオブジェクトにする
- `.obs`：オブジェクトをRxオブジェクトでラップし、インスタンス化する
- `Get.put(<GetxController>)`メソッド：依存関係を注入するメソッド
- `Get.find()`メソッド：注入されたGetxControllerへアクセスするメソッド
- `Obx`クラス：状態変数の変化に反応し、ラップしたwidgetを再描画します
## 準備
カウンターアプリを例に実際見ていきましょう。
### 1. Stateクラス
- 今回はCountフィールドを持つ`CounterObj`クラスを定義。
- `RxInt`は`int`型の状態変数を持つ`Rx`オブジェクトです。
- `0.obs`とする事で0を状態変数に持つ`Rx`オブジェクトをインスタンス化しています。
```dart
class CounterObj {
  CounterObj() : count = 0.obs;
  RxInt count;
}
```

### 2. 状態管理クラス(GetXController)
- `GetXController`クラスを継承する状態管理クラスを定義します。
- 状態変数として管理するのは先程定義した`CounterObj`クラスです。
- その為、`CounterObj`も`CouterObj.obs`とする事で監視可能な`Rx`オブジェクトとしてインスタンス化します。

```dart
class GetXCounterController extends GetxController {
  Rx<CounterObj> _counter = CounterObj().obs;
  Rx<CounterObj> get counter => _counter;

  void incrementCounter() => _counter.value.count++;

  void decrementCounter() => _counter.value.count--;

  void resetCounter() => _counter.value.count.value = 0;
}
```
- 状態変数の変更ではRxインスタンスのvalueプロパティに状態変数が格納されているので、それを直接操作します。

### 3. 依存関係の注入
- 依存関係の注入には`Get.put`メソッドを使います。
- 以下のように`Get.put(<GetXController>)`メソッドを実行する事でそのwidgetツリー以下のwidgetで`Get.find`メソッドで引数に渡したGetXControllerにアクセスする事が出来ます。
```dart
  @override
  Widget build(BuildContext context) {
    Get.put(GetXCounterController());
    return const _GetXCounterPage();
  }
```
## 状態へのアクセス
- 状態管理クラスへのアクセスは`Get.find`メソッドを使います

```dart
    final GetXCounterController c = Get.find();

    ...
    FloatingActionButton(
        onPressed: c.incrementCounter,
        tooltip: 'Increment',
        heroTag: 'Increment',
        child: Icon(Icons.add),
    ),
    ...
```

### 状態変数の変更に伴った再描画
- `Obx`クラスでラップする事で、状態変数に変更があった際に再描画させる事ができます。

```dart
    Obx(
        () => Text(
        '${c.counter.value.count}',
        style: Theme.of(context).textTheme.headline4,
        ),
    ),
```

どうでしょうか、GetXには他にも様々な機能があり、だいぶ端折った部分もありますが、非常に直感的で学習コストが低いと感じます。

大規模なプロジェクトで状態管理が複雑になる場合に適正かは分かりませんが、個人開発レベルであまり複雑な状態管理が発生しないプロジェクトであれば、非常に強力なツールになると感じます。

他にも多くの機能があるので別途GetXだけを記事にしたいと思います。
## 参考
- https://zenn.dev/mipo/scraps/1c15b5db71e146
- https://dev.to/gunathilakahashan10/getx-a-superior-state-management-in-flutter-4jcl
- https://zenn.dev/tatsuhiko/books/b938417d5cb04d/viewer/944e11
