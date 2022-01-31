# Scoped Model
package:
- [scoped_model](https://pub.dev/packages/scoped_model) v1.1.0

## 概要
- 元々はGoogleが開発しているOS Fuchsiaで用いられていた
- そのコードを取り出しパッケージ化したもの
- コメント含めて300行くらいのコンパクトなパッケージ
- `Provider`パッケージに似た管理手法であり、Provider普及後は存在感が希薄に
- flutter_reduxなどの開発も手掛けた[Brian Egan](https://github.com/brianegan)などが開発に関わっている
- 初版リリースは2017年8月

## 全体像
特徴はProviderと同じく下記の2点,
  1. 依存関係がWidgetツリーに沿って下っていく
  2. 状態変更を明示的に通知する

状態を保持したクラスは依存関係を注入されたWidgetとそのWidgetツリー傘下のWidgetからアクセスが可能になります。Widgetツリーに沿って依存関係が下っていくようなイメージ。

<img width="350" src="https://user-images.githubusercontent.com/44666053/151802595-38bd6d0a-29ff-4bbb-95e6-fa869d7c938d.png">


Widgetは状態管理クラスの変数やメソッドをProviderを通してアクセスします。変数を変更した際は用意されている通知メソッドを実行し、変数を利用しているクラスに通知。その通知を受けったクラス達は新しい値で自身を再生成(リビルド)する事になります。

## キーとなるクラスやメソッド
- `Model`クラス：状態管理クラスが継承するクラス
- `ScopedModel`クラス：状態管理クラスを注入するクラス
- `ScopedModelDescendant`クラス：子孫Widgetから注入された`Model`クラスにアクセスする為のクラス
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

状態を保持するクラス`ScopedModelCounterState`を準備。
-  `Model`クラスを継承する事で前述の通知メソッド`notifyListener`を使う事が出来ます。
-  クラスに定義したメソッドで保持している状態の値に変更を加え、`notifiyListener`で変更を外部に通知します。

```dart

class ScopedModelCounterState extends Model {
  ScopedModelCounterState() : obj = CounterObj();
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

`ScopedModel`クラスを使って状態管理クラスをUIに注入。
- `model`フィールドに状態管理クラス`ScopedModelCounterState`のインスタンスを渡す
- `child`フィールドで子孫となる`_ScopedModelCounterPage` widgetにインスタンスを注入

```dart

class ScopedModelCounterPage extends StatelessWidget {
  const ScopedModelCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ScopedModelCounterState(),
      child: _ScopedModelCounterPage(),
    );
  }
}
```

これによりwidgetツリー上で`_ScopedModelCounterPage` widgetより下に位置する全てのWidgetで`ScopedModelCounterState`クラスにアクセスできる様になりました。

## 状態へのアクセス
状態管理クラスへのアクセス方法は中身は同じですが、二通りの書き方が有ります

ベースとなるのは`ScopedModelDescendant`クラスを使ったアクセスです。builder、child、rebuildOnChangeと3つの引数を持ち、builderで状態管理クラスへのアクセス権を付与したwidgetを返します

builderではBuildContext, child引数で渡したWidget, 型で定義したModelクラスをラップしたwidgetに渡す事ができ、これを介して状態管理クラスへアクセスします

child引数で渡したWidgetはあまり使うことはないかも知れませんが、`Model`クラスと関わりのないWidgetでModelの変更時もリビルドされたくないWidgetを渡す事ができます

`rebuildOnChange`は`notifyListeners`が実行された際に、`Model`クラスを参照しているWidgetをリビルドするかを制御します

```dart
  ScopedModelDescendant<ScopedModelCounterState>(
    builder: (context, _, model) => Text(
      '${model.obj.count}',
      style: Theme.of(context).textTheme.headline4,
    ),
  ),
```

もう一つのアクセス方法は`ScopedModel.of`を使ったアクセスです

こちらではWidgetをラップする必要はなく、参照する箇所に直接値を渡せます

上記の`ScopedModelDescendant`クラスを使った例を書き直すと下記の様になります

```dart
  Text(
      '${ScopedModel.of<ScopedModelCounterState>(context).obj.count}',
      style: Theme.of(context).textTheme.headline4,
    ),
```

これらの大きな違いは`ScopedModelDescendant`クラスでは`rebuildOnChange`がデフォルトで`true`となっている事とリビルドされるスコープはラップしたwidgetに限定されます

一方、`ScopedModel.of`では`rebuildOnChange`がデフォルトで`false`になっている事、また`rebuildOnChange`の引数に`true`を渡す事でリビルドを走らせる事も可能ですが、Modelクラスを注入したWidgetが丸ごとリビルドされてしまいます

## ProviderとScoped Modelの違い
`Provider`パターンに馴染みがある方は`Provider`とどこが違うの？と思ったかと思います

それについては `Provider`パッケージの作者であるRemi Rousselet氏本人が以下で返答しています

曰く`Scoped Model`は`Listenable`クラスを継承した`Model`クラスを使ったアーキテクチャであり、この仕組みはその後`ChangeNotifier`としてFlutterに標準実装されています

`Provider`はこの`ChangeNotifier`を活用する事で`Scoped Model`アーキテクチャを模倣する事も出来るし、それ以外の使い方も出来るパッケージであると説明しています

どちらにせよ`Model`クラスと同機能の`ChangeNotifier`が標準実装された事により、`Scoped Model`パッケージを使うメリットが無くなったのは事実で、特殊な理由がない限りは`ChangeNotifier` x `Provider`を使えば良いと個人的には思いました

## 参考
- https://qiita.com/hayassh/items/690fa0d6528e056617b5
- https://www.reddit.com/r/FlutterDev/comments/brz0nu/scoped_model_vs_provider/ere338x/
- https://stackoverflow.com/questions/56886805/difference-between-changenotifierprovider-and-scopedmodel-in-flutter
- https://qiita.com/kabochapo/items/2b992cc00e9f464c1ea9#bloc%E4%BB%A5%E5%A4%96%E3%81%AE%E7%8A%B6%E6%85%8B%E7%AE%A1%E7%90%86%E6%96%B9%E6%B3%95
