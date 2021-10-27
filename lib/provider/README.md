# Provider
package: [provider](https://pub.dev/packages/provider) v6.0.1

## 概要
----
- 現在最もポピュラーな状態管理パッケージ 
- Googleも状態管理パッケージの中でもオススメしているパッケージ
- providerだけでなく、stateNotifierやRiverpod、freezedなど数多くの人気Flutterパッケージをリリースしている[Remi Rousselet](https://github.com/rrousselGit)氏が制作
- 初版リリースは2018年10月

## 全体像
----
特徴は2点、
  1. 依存関係がWidgetツリーに沿って下っていく
  2. 状態変更を明示的に通知する

状態を保持したクラスは依存関係を注入されたWidgetとそのWidgetツリー傘下のWidgetからアクセスが可能になります。Widgetツリーに沿って依存関係が下っていくようなイメージ。
<絵>

Widgetは状態管理クラスの変数やメソッドをProviderを通してアクセスします。変数を変更した際は用意されている通知メソッドを実行し、変数を利用しているクラスに通知。その通知を受けったクラス達は新しい値で自身を再生成(リビルド)する事になります。

## キーとなるクラス
---
- `ChangeNotifier`クラス：状態管理クラスが継承するクラス
- `ChangeNotifierProvider`クラス：状態管理クラスを注入するクラス
- `notifyListener`メソッド：状態変更を通知するメソッド

## 準備
----
具体的にカウンターアプリを例に見ていきましょう。
