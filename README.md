バッジ
# TAKO Widget 2R

![タイトルロゴ](https://user-images.githubusercontent.com/99729195/170691129-33a3c60a-6b4f-448f-aaab-a032f274f507.jpg)

# 概要

デモページ:
[github用デモページ_TAKO_Widget_2R](https://yahoo.co.jp)

TAKO Widget 2R（タコウィジェットツーアール）は、  
Nintendo Switch用ゲームソフト『スプラトゥーン2』のプレイヤー向けに開発したメモ管理ツールです。

マップ24種 × ルール5種 × ブキ130種 = 15,600通りにもおよぶ立ち回りを、  
メモとして簡単に呼び出し、編集・閲覧することが可能です。

自分の考えた立ち回りを記録し、管理することで、  
対戦ゲームとして戦術を練ることの面白さと、ウデマエ向上のサポートを目的としています。


※本アプリはポートフォリオ用に作成しています。
最下部に、ポートフォリオとしての情報を記載しておりますので、ぜひご高覧いただけますと幸いでございます。

# プレビュー

![スケジュール確認](https://user-images.githubusercontent.com/99729195/170691425-ce292bce-5d80-4edd-8e14-1a584ff1eec8.png)
![メモ編集](https://user-images.githubusercontent.com/99729195/170691491-da19c7e6-bc9d-4418-a162-8c1b16d6407c.png)
![S3画像に対応](https://user-images.githubusercontent.com/99729195/170691538-53d228a5-c262-40b9-bdbe-b42e90821396.png)
![他ユーザーの投稿も検索できる](https://user-images.githubusercontent.com/99729195/170691583-42769cb5-f4e1-4648-904b-c4f892cf95b5.png)


# 現在実装されている機能(v1.0)
- ユーザー登録機能により、複数のユーザーが使えるWEBアプリケーション
- それぞれのユーザーが、マップ24 × ルール5 × ブキ130 = 15,600通りのメモを管理できる
- 外部APIとの連携により、現在のスケジュールの確認が可能
- 上記により、現在必要なメモの呼び出しがスムーズに行える
- メモはテキストの他、画像の埋め込みが可能
- 他のユーザーの投稿を検索したり、いいねで評価できる


# 目次
  - [必要条件](#必要条件)
  - [使用言語](#使用言語)
  - [ERD](#ERD)
  - [使い方](#使い方)
  - [ライセンス情報](#ライセンス情報)
  - [今後の計画](#今後の計画)
  - [ポートフォリオとして](#ポートフォリオとして)

# 必要条件
## 管理側
- ruby 2.7.3
- rails 6.1.6
- Bundler version 2.1.4
- AWS S3 bucket

## ユーザー側
- Webブラウザ(PC・スマホ対応)

# 使用言語
- HTML
- CSS
- JavaScript
- Ruby

# ERD

# 使い方

## インストール方法

1. 下記コマンドにて、clone、gemのインストール、DBの初期設定を行ってください。

```bash
$ git clone https://github.com/hoge/~
$ cd takowidget2
$ gem install bundler -v 2.1.4
$ bundle install

$ rails db:migrate
$ rails db:seed
```

2. 画像保存の機能としてAWSのS3を利用しています。下記の通り、環境変数を設定してください

```bash
AWS_ACCESS_KEY_ID = アクセスキーID
AWS_SECRET_ACCESS_KEY = シークレットアクセスキー
AWS_DEFAULT_REGION = リージョン
AWS_S3_BUCKET = バケット名
```

3. 環境によっては、Rails6のセキュリティの都合上、「Blocked host: ～」エラーが表示される場合があります。
適宜、 config/application.rb にhostを追加してください。


## テスト方法

下記コマンドにてRSpecテストを実行してください
```bash
$ bundle exec rspec
```

## デプロイ方法
下記コマンドにて、unicorn経由でRailsをスタートさせてください
```bash
$ unicorn_rails -c config/unicorn.rb -E production -D
```

## テスト用アカウント
テスト用のアカウントが自動作成されますので、適宜ご利用ください

```
ID : testaccount
パスワード : WnrU4FCq4nklrh
```

# ライセンス情報
MIT License

# 今後の計画
実際にユーザーに利用してもらい、いくつか要望をもらっていますので、
今後スキルアップした際には、アップデートしていきたいと考えています。

## ユーザーから要望があった機能の実装
- メモへのTwitter・Youtubeの埋め込み機能を実装する
- メモの閲覧を非同期通信のモーダル化し、操作しやすいように変更する

## その他実装予定の機能
- 不適切な投稿の通報機能
- 通報された投稿を確認・管理するページ　　
  管理権限用に、Userにadmnflgカラムを作成済み（テスト用ユーザーにだけ付与）
- ブキの並び順変更機能
  Weaponにorderカラムを作成済み
  ゲーム側のアップデートに対応する為、事前設定済

---

# ポートフォリオとして
本項目をご覧くださり、ありがとうございます。  
こちらでは、ポートフォリオとしてのアピールポイントを掲載させて頂きます。

## 開発の経緯
本アプリは、もともと趣味でPHPで作成・運用していたものを、ポートフォリオ用にRuby on Railsで作り直した物になります。

前身となるアプリは、現在も実際に知人・友人など、複数の方に利用していただいております。

もともとはAPIを用いて、ただスケジュールを確認するだけのWEBアプリでしたが、  
ユーザーから「メモを書けるようにできないか？」「複数のブキでメモを管理できないか？」などの要望を受け、現在の機能に至ります。


Ruby on Rails版への移植にあたり、自身の技術不足でまだ実装できていない機能もございますが、  
今後もユーザーからのフィードバックを元にアップデートを重ねて、アップデートをしていきたいと考えております。

## こだわった点
ポートフォリオ用にただ自分の技術確認や振り返りで終わるのではなく、  
実際にユーザーに利用してもらう為に、開発を行いました。  

ユーザー目線でのUI設計・必要になる機能の実装や、  
拡張性を考慮しての設計と、新しい技術の導入を積極的にチャレンジしました。

例えば、文章内への画像の埋め込み機能については複数の実装方法がありますが、今後の拡張性を考慮し、
- ActiveStorageとS3の連携
- ActionTextを利用しリッチテキストエディタにする

方式で実装を行いました。
今後、自分がスキルアップした際に、TwitterやYoutubeなどの外部サービスの埋め込みにも挑戦したいと考えています。

BootStrapやkaminariなどのライブラリも積極的に採用し、開発・運用のしやすさと、ユーザービリティの両立を目指しました。

会員登録にはDeviseを利用していますが、認証方法をメールアドレスではなく、ユーザーIDで認証する方式に変更しています。  
これは、前身となるアプリのユーザーの中には中学生や高校生もいる為、  
個人情報の流出リスクや、メール認証のわずらわしさを無くすことで、子供でも使いやすいサービスにしたいという理由から採用しています。
パスワードリセットが使えないという欠点はありますが、今後、こちらについても対策を考えたいです。

その他、APIから取得したデータをController側でハッシュに整形し直してviewに渡すことで、可能な限りクライエント側の処理負荷を減らすことにも注力しています。



## 反省点
commitの書き方をよく理解しないまま進めてしまい、複数の調整を1つのcommitにまとめたり、commitの内容を細かく記載できていなかったのは失敗でした。

S3にアップロード時のバリデーションをどこに書いたか忘れてしまい、過去のcommitから辿ろうとしたのですが、  
前述の通り、コミットを丁寧に書いていなかった為、見つけるまでに時間がかかり、commitの粒度や詳細を書くことの大切さを、身をもって痛感いたしました。

途中からですが、commitの粒度や概要、詳細の書き方を変更して、進めるように意識しました。

以上です。
よろしくお願いいたします。
