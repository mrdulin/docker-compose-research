# multiple-compose-files

可以通过下面的`docker-compose`命令查看最终 merge 后的`docker-compose`配置文件

开发环境：

```bash
☁  multiple-compose-files [master] ⚡  docker-compose -f docker-compose.yml -f docker-compose.override.yml config
networks:
  docker-compose-research: {}
services:
  redis:
    image: redis:alpine
    networks:
      docker-compose-research: null
    ports:
    - published: 6379
      target: 6379
  web:
    build:
      context: /Users/ldu020/workspace/docker-compose-research/get-started
    depends_on:
    - redis
    environment:
      DEBUG: "true"
    image: getstarted_web:latest
    networks:
      docker-compose-research: null
    ports:
    - published: 8883
      target: 5000
    volumes:
    - /Users/ldu020/workspace/docker-compose-research/get-started:/code:rw
version: '3.6'
```

生产环境：

```bash
☁  multiple-compose-files [master] ⚡  docker-compose -f docker-compose.yml -f docker-compose.prod.yml config
networks:
  docker-compose-research: {}
services:
  redis:
    environment:
      TTL: '500'
    image: redis:alpine
    networks:
      docker-compose-research: null
  web:
    depends_on:
    - redis
    environment:
      PRODUCTION: "true"
    image: getstarted_web:latest
    networks:
      docker-compose-research: null
    ports:
    - published: 80
      target: 5000
version: '3.6'
```
