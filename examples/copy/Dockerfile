FROM busybox

# 拷贝文件目录
COPY ./src/ /dest/

# 拷贝文件
COPY ./b.txt /b.txt

# src指定多个源, dest必须是目录，否则，报错:
# [dockerfile-utils] When using COPY with more than one source file, the destination must be a directory and end with a / or a \
COPY ./src/ ./b.txt /dest-1/
