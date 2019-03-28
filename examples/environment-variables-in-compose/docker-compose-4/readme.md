需要切换到当前目录下，再执行

```bash
☁  docker-compose-4 [master] ⚡  docker-compose config
services:
  busybox:
    command: echo 999
    environment:
      DEBUG: '999'
    image: busybox
version: '3.6'
```
