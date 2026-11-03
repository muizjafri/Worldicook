require('dotenv').config();
const { Pool } = require('pg');

if (!process.env.DATABASE_URL) {
  console.warn(
    'Warning: DATABASE_URL is not set. Copy server/.env.example to server/.env and fill it in.'
  );
}

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

module.exports = pool;