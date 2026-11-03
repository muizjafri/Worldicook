// server/index.js
require('dotenv').config();
const express = require('express');
const cors = require('cors');

const countriesRouter = require('./routes/countries');
const dishesRouter = require('./routes/dishes');
const miscRouter = require('./routes/misc');

const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ status: 'ok', service: 'worldicook-api' });
});

app.use('/countries', countriesRouter);
app.use('/dishes', dishesRouter);
app.use('/', miscRouter);

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`WorldiCook API listening on http://localhost:${PORT}`);
});
