# change it to your node version 10+
FROM node:10.16.0-alpine AS build 
WORKDIR /app
# add your dependencies here
ARG ALPINE_LINUX_MIRROR
RUN if [[ -n "$ALPINE_LINUX_MIRROR" ]]; then sed -i "s/dl-cdn.alpinelinux.org/$ALPINE_LINUX_MIRROR/g" /etc/apk/repositories; fi \
  && apk update \
  && apk add --no-cache libc6-compat 
COPY package*.json /app/
RUN npm install

# Release
FROM build AS release
WORKDIR /app
COPY . .
COPY --from=build /app/package*.json /app/
RUN npm install --production --ignore-scripts --prefer-offline

CMD npm start