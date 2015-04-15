# tools-screenshot
HTML をパースしてリストを作成。Basic auth を越えてスクリーンキャプチャ。


## Require

- [paulhammond/webkit2png](https://github.com/paulhammond/webkit2png/)




## Config

config.rb に設定を用意する。

```ruby:config.rb
OUTPUT = 'output.txt'
CHARSET = 'utf-8'
BASE_URI = 'http://www.example.com/'

OPEN_URI_OPTIONS = {
    :http_basic_authentication => %w(user password),
    :ssl_verify_mode => 'OpenSSL::SSL::VERIFY_NONE'
}
```




## Create URI list

input.txt にターゲットURIを用意する。

```
http://www.example.com
```

実行。

```
% ruby create_list.rb input.txt
```

サーバから HTML を取得。
パースして anchor リンクのリストを作成する。


### option

BASE_URI で指定した内部リンクのみを出力する。

```
% ruby create_list.rb --help
Usage: create_list [options]
    -i, --internal-link
```

オプショ付きで繰り返し実行することで、再帰的にターゲット配下の URI を収集できる。

1度目。

```
% ruby create_list.rb -i input.txt
Target size: 3
```

2度目。

```
% ruby create_list.rb -i output.txt
Target size: 4
```




## Capture screen

webkit2png を利用して画面をキャプチャする。

```
% ruby capture_screen.rb output.txt
```

キャプチャサイズ等のオプションは、ファイル内で設定している。
