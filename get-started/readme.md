# get started

## 错误

```bash
☁  multiple-compose-files [master] ⚡  docker-compose up
Creating network "multiplecomposefiles_default" with the default driver
Building web
Step 1/5 : FROM python:3.4-alpine
 ---> 2b794a3b3750
Step 2/5 : ADD . /code
 ---> c34a32d87954
Step 3/5 : WORKDIR /code
Removing intermediate container 1a2493f0204a
 ---> 9b25a8931f08
Step 4/5 : RUN pip install -r requirements.txt
 ---> Running in 52f70cd0e080
Collecting flask (from -r requirements.txt (line 1))
  Retrying (Retry(total=4, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError(SSLError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:600)'),)': /simple/flask/
  Retrying (Retry(total=3, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError(SSLError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:600)'),)': /simple/flask/
^CGracefully stopping... (press Ctrl+C again to force)
```

我这里的解决方法是断开公司的 vpn

## 参考连接

https://docs.docker.com/compose/gettingstarted/
