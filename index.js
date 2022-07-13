require('dotenv').config();

const express = require('express');
const cors = require('cors');
const bodySanitizer = require('./app/sanitizer');

const router = require('./app/router');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.urlencoded({ extended: true }));

app.use(express.json());
app.use(bodySanitizer);

app.use(
  cors({
    origin: '*',
  }),
);

const multer = require('multer');
const bodyParser = multer();

// on utlise .none() pour dire qu'on attends pas de fichier, uniquement des inputs "classiques" !
app.use(bodyParser.none());

// on sert les fichiers statiques
app.use(express.static('./public'));

app.use(router);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
