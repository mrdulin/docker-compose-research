FROM busybox

# 从本地复制文件到镜像
ADD ./b.txt ./b.txt

# 与COPY的区别
# 复制网络文件到镜像，但不推荐这种做法
# 应该使用RUN wget或者RUN curl代替。这样可以删除解压后的不再需要的文件，并且不需要在镜像中再添加一层
ADD https://github.com/mrdulin/docker-research/blob/master/copy/src/a.txt /dest/


