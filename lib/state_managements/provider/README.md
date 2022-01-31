# Provider
package: [provider](https://pub.dev/packages/provider) v6.0.1

## 概要
- 現在最もポピュラーな状態管理用パッケージ 
- Googleも状態管理パッケージの中でもオススメしているパッケージ
- providerだけでなく、stateNotifierやRiverpod、freezedなど数多くの人気Flutterパッケージをリリースしている[Remi Rousselet](https://github.com/rrousselGit)氏が開発
- 初版リリースは2018年10月

## 全体像
特徴は2点、
  1. 依存関係がWidgetツリーに沿って下っていく
  2. 状態変更を明示的に通知する

状態を保持したクラスは依存関係を注入されたWidgetとそのWidgetツリー傘下のWidgetからアクセスが可能になります。Widgetツリーに沿って依存関係が下っていくようなイメージ。

<img width="350" src="https://user-images.githubusercontent.com/44666053/151802595-38bd6d0a-29ff-4bbb-95e6-fa869d7c938d.png">


Widgetは状態管理クラスの変数やメソッドをProviderを通してアクセスします。変数を変更した際は用意されている通知メソッドを実行し、変数を利用しているクラスに通知。その通知を受けったクラス達は新しい値で自身を再生成(リビルド)する事になります。

## キーとなるクラスやメソッド
- `ChangeNotifier`クラス：状態管理クラスが継承するクラス
- `ChangeNotifierProvider`クラス：状態管理クラスを注入するクラス
- `notifyListener`メソッド：状態変更を通知するメソッド

## 準備
具体的にカウンターアプリを例に見ていきましょう。


今回はcountフィールドを持つ`CounterObj`クラスの状態管理をしていきます。
```dart
class CounterObj {
  CounterObj() : count = 0;
  int count;
}
```

状態を保持するクラス`ProviderCounterState`を準備。
-  `ChangeNotifier`クラスを継承する事で前述の通知メソッド`notifyListener`を使う事が出来ます。
-  クラスに定義したメソッドで保持している状態の値に変更を加え、`notifiyListener`で変更を外部に通知します。

```dart

class ProviderCounterState extends ChangeNotifier {
  ProviderCounterState() : obj = CounterObj();
  CounterObj obj;

  void incrementCounter() {
    obj.count++;
    notifyListeners();
  }

  void decrementCounter() {
    obj.count--;
    notifyListeners();
  }

  void resetCounter() {
    obj.count = 0;
    notifyListeners();
  }
}

```


`ChangeNotifierProvider`を使って状態管理クラスをUIに注入。
- `create`フィールドで状態管理クラス`ProviderCounterState`をインスタンス化
- `child`フィールドに定義した`_ProvoiderCounterPage` widgetにインスタンスを注入

```dart

class ProviderCounterPage extends StatelessWidget {
  const ProviderCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderCounterState(),
      child: _ProviderCounterPage(),
    );
  }
}
```

これによりwidgetツリー上で`_ProviderCounterPage` widgetより下に位置する全てのWidgetで`ProviderCounterState`クラスにアクセスできる様になりました。

## 状態へのアクセス
状態管理クラスへのアクセス方法には二つあります。

単発的に状態管理クラスにアクセスする`context.read()`と状態変化を監視する`context.watch()`です。

メソッドなど定義が変更されないものは`context.read()`でアクセスし、状態値など変更を検知したい対象については`context.watch()`でアクセスします。

### メソッドへのアクセス：
```dart
final ProviderCounterState unListenState = context.read<ProviderCounterState>(); 


FloatingActionButton(
  onPressed: unListenState.incrementCounter,
  tooltip: 'Increment',
  heroTag: 'Increment',
  child: Icon(Icons.add),
),

```

### 状態値の監視：
- `context.watch()`では前述の`notifyListeners`からの通知に応じて、値を取得し直します。
- 取得し直した値を元にその値を扱うWidgetを再描画(リビルド)します。
- その為、`build`メソッド内で`context.watch()`を定義してしまうと状態が変化する度にwidgetが丸ごと再描画されてしまいます。
```dart
 @override
  Widget build(BuildContext context) { 
    // ProviderCounterStateの値が変わる度にbuildメソッドが走る
    final ProviderCounterState state =
        context.watch<ProviderCounterState>(); 
    return Scaffold(
      appBar: MainAppBar(
        title: 'ChangeNotifier x Provider',
        ...

```

- `notifiListeners`メソッドの通知に応じてラップしているwidgetだけを再描画する`Consumer`クラスを使用する事で再描画される範囲を限定する事が出来ます。

```dart
...,
Consumer<ProviderCounterState>(
  builder: (context, state, _) => Text(
    '${state.obj.count}',
    style: Theme.of(context).textTheme.headline4,
  ),
),
...
```
- 実際に状態値を参照して描画しているText widgetだけを`Consumer`クラスでラップする事で状態値が変更しても再描画されるのはラップされたText Widgetだけになりました
- `Consumer`クラスの他に特定の状態値だけを監視し、`Selector`クラスを使う事で再描画される条件をより絞る事が出来ます。

## 実は...
### **Providerは状態管理手法の事じゃない**：
最もポピュラーな状態管理手法としてProviderが紹介される事が多いが、実際Providerパッケージから利用してるのは状態管理クラスをWidgteツリーに沿って流し込む`ChangeNotifierProvider`であって、状態管理クラスの`ChangeNotifier`自体ではありません。

そういう意味で言うと`Provider`は依存関係の注入を手助けするパッケージであって、状態管理手法自体ではありません。

どうもGoogleIOにて`Provider`パッケージを状態管理手法として紹介した事が元凶のようです。
### **Providerを使うのはProviderだけじゃない**：
禅問答の様ですが、先の捉え方がなぜややこしいかというとProviderが様々な状態管理手法で使われているからです。状態管理手法として有名なBLoCでも`BlocProvider`クラスによって依存関係をWidgetツリーに沿って流し込んでいきます。

### **Providerと比較されるべきなのはRiverpodやGetItでは？**：
BlocやRedux、GetXなど他の状態管理手法とProviderを同列で比較するような言い方が多いかと思いますが、「Provider = 依存関係の注入を手助けするパッケージ」という視点から考えれば、Providerパッケージと比較されるべきなのは、 厳密には`Riverpod`やServiceLocatorである`GetIt`だと思います。
### **Providerパターン、Providerパッケージ**：
そんな訳で`Provider`という言葉を使うとこんがらがるのですが、状態管理手法としての`Provider`と言う時は

「`Provider`(パターン) = `ChangeNotifier` x `ChangeNotifierProvider` の組み合わせ」

と言うニュアンスで考えるのが良さそうです。ちょっと「Providerパターン」なんて名前があるかは定かじゃありませんが。

## 参考文献
