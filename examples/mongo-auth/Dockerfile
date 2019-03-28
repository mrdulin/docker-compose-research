FROM mhart/alpine-node

COPY ./db.js ./package-lock.json ./package.json  /app/

WORKDIR /app

RUN npm install --production

CMD npm start
