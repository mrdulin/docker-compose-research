# environment-variables-in-compose

```bash
☁  environment-variables-in-compose [master] ⚡  DEBUG=1234 docker-compose -f docker-compose-2.yml up
Creating network "environmentvariablesincompose_default" with the default driver
Creating environmentvariablesincompose_busybox_1 ... done
Attaching to environmentvariablesincompose_busybox_1
busybox_1  | PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
busybox_1  | HOSTNAME=5e01cb19a861
busybox_1  | DEBUG=1234
busybox_1  | HOME=/root
environmentvariablesincompose_busybox_1 exited with code 0
```

## 参考连接

https://docs.docker.com/compose/environment-variables/
