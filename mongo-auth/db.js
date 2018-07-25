const mongoose = require('mongoose');

const {
  MONGODB_APPLICATION_USER,
  MONGODB_APPLICATION_PASS,
  MONGODB_APPLICATION_DATABASE,
  MONGO_HOST,
  MONGO_PORT
} = process.env;
const auth =
  MONGODB_APPLICATION_USER && MONGODB_APPLICATION_PASS
    ? `${MONGODB_APPLICATION_USER}:${MONGODB_APPLICATION_PASS}@`
    : '';

const uri = `mongodb://${auth}${MONGO_HOST}:${MONGO_PORT}/${MONGODB_APPLICATION_DATABASE}`;
console.log('uri: ', uri);
mongoose.connect(
  uri,
  { useNewUrlParser: true }
);

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => {
  console.log('connect mongodb successfully');
});

const kittySchema = new mongoose.Schema({
  name: String
});

const Kitten = mongoose.model('Kitten', kittySchema);

const silence = new Kitten({ name: 'Silence' });
console.log(silence.name);
