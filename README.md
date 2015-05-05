# site-diff

Site monitoring tool.

# 動作概要

* 本番デプロイとかの契機に`bundle exec rake db:capture SITES=site_name`を実行する
  * スクリーンショットを事前に登録している各URLにFireFox, Chromeで撮影していく
* 前回画像と比較を行う
  * 前回差分が閾値を超えていた場合メールとか何かする
  * 結果のHTMLを生成する。
      * `public/current/index.html`に出力する
* 最貧の比較結果は、`APP_ROOT/public/current/index.html` をwebサーバで見れる

# Requirements

* ImageMagick

# Installation

```
$ bundle install
$ bundle exec rake db:create && bundle exec rake db:migrate
$ bundle exec rails server
(ブラウザから対象のURLを登録する)
```
運用時にサーバを起動する必要なし。設定値を登録するk時に起動するイメージ。
