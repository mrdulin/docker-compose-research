# mongo-auth

## 启动 mongodb

```bash
docker-compose up -d
```

## 连接需要身份认证的 mongodb

在宿主机终端中执行

```bash
☁  mongo-auth [master] ⚡  mongo -u admin -p admin123
MongoDB shell version v3.6.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.5
WARNING: shell and server versions do not match
2018-07-25T14:26:38.877+0800 E QUERY    [thread1] Error: Authentication failed. :
DB.prototype._authOrThrow@src/mongo/shell/db.js:1608:20
@(auth):6:1
@(auth):1:2
exception: login failed
```

正确的命令:

```bash
mongo -u admin -p admin123 --authenticationDatabase "admin"
```

**注意：应该将.env 文件加入.gitignore 中，本例是为了演示**

## 问题

ERROR: Service 'mongoose' failed to build: COPY failed: Forbidden path outside the build context: ../package-lock.json ()
