#

当存在 ENTRYPOINT 后，CMD 的内容将会作为参数传给 ENTRYPOINT，而这里 -i 就是新的 CMD，因此会作为参数传给 curl，从而达到了我们预期的效果。

```bash
☁  demo-1-2 [master] ⚡  docker run entrypoint-demo-1-2
当前 IP：155.201.35.107 来自：美国
☁  demo-1-2 [master] ⚡  docker run entrypoint-demo-1-2 -i
HTTP/1.1 200 OK
Date: Tue, 26 Jun 2018 06:32:26 GMT
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Set-Cookie: __cfduid=d02b7f59e6329128559e1fe7dec94faf31529994746; expires=Wed, 26-Jun-19 06:32:26 GMT; path=/; domain=.ip.cn; HttpOnly
Server: cloudflare
CF-RAY: 430da2fbd414387c-ATL

当前 IP：155.201.35.107 来自：美国
```
