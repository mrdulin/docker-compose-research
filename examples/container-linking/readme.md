# container linking

Run container for node-app-2

```bash
docker run -d --name node-app-2 node-app-2
```

Run container for node-app-1 and link to node-app-2

```bash
docker run -d --env HOST=node-app-2 -p 3000:3000 --name node-app-1 --link node-app-2 node-app-1
```

Check the hosts in node-app-1 container:

```bash
☁  app-1 [master] ⚡  docker exec -it 026 sh
/app # cat /etc/hosts
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
172.17.0.2      node-app-2 bee2bd947745
172.17.0.3      026aeadda007
```

So, the host of node-app-2 is `node-app-2`, in order to sending HTTP request to node-app-2 from node-app-1, we need to use `http://node-app-2:3001` rather than `http://localhost:3001` in node-app-1
