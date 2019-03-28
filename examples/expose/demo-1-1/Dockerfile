FROM mhart/alpine-node:8.7.0

RUN apk update \
  && apk add --no-cache curl

COPY ./server.js /app/

WORKDIR /app

CMD [ "node", "./server.js" ]

HEALTHCHECK --interval=3s --timeout=3s --start-period=5s --retries=3 CMD [ "curl", "-fs", "http://localhost:3000" ] || exit 1

EXPOSE 3000