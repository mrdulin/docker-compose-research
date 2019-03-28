# entrypoint

```bash
☁  entrypoint [master] ⚡  docker run entrypoint-demo
当前 IP：155.201.35.107 来自：美国
```

```bash
☁  entrypoint [master] ⚡  docker run entrypoint-demo -i
docker: Error response from daemon: OCI runtime create failed: container_linux.go:348: starting container process caused "exec: \"-i\": executable file not found in $PATH": unknown.
ERRO[0000] error waiting for container: context canceled
```

## 参考连接

https://yeasy.gitbooks.io/docker_practice/image/dockerfile/entrypoint.html
