const express = require('express');
const axios = require('axios');
const app = express();
const port = 3000;

app.get('/', async (req, res) => {
  const hostname = process.env.HOST;
  console.log('app 2 hostname: ', hostname);
  const response = await axios.get(`http://${hostname}:3001`);
  console.log(response.data);
  res.sendStatus(200);
});

app.listen(port, () => {
  console.log(`HTTP server is listening on http://localhost:${port}`);
});
