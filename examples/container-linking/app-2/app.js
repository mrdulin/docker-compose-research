const express = require('express');
const app = express();
const port = 3001;

app.get('/', (req, res) => {
  res.send('response from app 2');
});

app.listen(port, () => {
  console.log(`HTTP server is listening on http://localhost:${port}`);
});
