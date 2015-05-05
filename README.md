# site-diff

Site monitoring tool.

# 動作概要

* 本番デプロイとかの契機に`bundle exec rake db:capture SITES=site_name`を実行する
  * 事前に登録している各URLにFireFox, Chromeでスクリーンショットを撮影していく
* 前回画像と比較を行う
  * 差分が閾値を超えていた場合メールとか何かする
  * 結果のHTMLを生成する。
      * `APP_ROOT/public/current/index.html`に出力する
* 最後の比較結果は、`APP_ROOT/public/current/index.html` をwebサーバで見る

# Requirements

* ImageMagick

# Installation

```
$ bundle install
$ bundle exec rake db:create && bundle exec rake db:migrate
$ bundle exec rails server # データ入力のために起動
```
運用時にサーバを起動する必要なし。
