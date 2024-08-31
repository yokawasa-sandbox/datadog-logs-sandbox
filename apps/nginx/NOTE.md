# NGINX デフォルトの状態ではHTTP STATUS 405のエラーになる問題の対応

```bash
docker ps

CONTAINER ID   IMAGE                              COMMAND                   CREATED          STATUS                 PORTS                  NAMES
52fa19c17dd6   sample-app                         "/docker-entrypoint.…"   52 minutes ago   Up 52 minutes          0.0.0.0:8080->80/tcp   sleepy_keller
084bcbcb0ede   gcr.io/datadoghq/agent:latest      "/bin/entrypoint.sh"      10 hours ago     Up 9 hours (healthy)   8125/udp, 8126/tcp     datadog-agent
789fd73da1e0   langgenius/dify-api:0.7.0          "/bin/bash /entrypoi…"   2 weeks ago      Up 2 weeks             5001/tcp               docker-worker-1

# コンテナIDを指定して、そこのdefault.confをコピー
# Dockerコンテナ -> ローカルファイルシステム
# docker container cp CONTAINER:コンテナ内のパス ローカルファイルシステムのコピー先パス
docker container cp 52fa19c17dd6:/etc/nginx/nginx.conf ./nginx.conf
docker container cp 52fa19c17dd6:/etc/nginx/conf.d/default.conf ./default.conf

```

default.confに次の設定を追加

```
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    # Add THIS
    error_page 405 =200 $uri;

}
```
>  `error_page 405 =200 $uri;` は、Nginx の設定ファイルに記述されるディレクティブの一つです。このディレクティブは、特定の HTTP ステータスコードが発生した際に、どのページを表示するかを指定します。 具体的には、この設定は HTTP 405 エラー（メソッドが許可されていないエラー）が発生した場合に、HTTP 200 ステータスコード（成功）として `$uri` にリダイレクトすることを意味します。`$uri` はリクエストされた URI を指し、通常はリクエストされたリソースのパスです。
> この設定は、例えば、特定のリクエストメソッド（例えば POST）が許可されていない場合でも、ユーザーにエラーページを表示するのではなく、正常なページを表示するために使用されます。これにより、ユーザーエクスペリエンスを向上させることができますが、同時に適切なエラーハンドリングが行われているかを確認する必要があります。

# REFERENCE
https://www.rk-k.com/archives/3838#index_id2
