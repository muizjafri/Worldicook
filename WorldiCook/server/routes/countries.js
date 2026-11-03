const express = require('express');
const pool = require('../db');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT id, name, iso_code, continent, region, flag_emoji, latitude, longitude
       FROM countries
       ORDER BY name`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load countries' });
  }
});

router.get('/:iso', async (req, res) => {
  const iso = req.params.iso.toUpperCase();
  try {
    const result = await pool.query(`SELECT * FROM countries WHERE iso_code = $1`, [iso]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Country not found' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load country' });
  }
});

router.get('/:iso/dishes', async (req, res) => {
  const iso = req.params.iso.toUpperCase();
  try {
    const result = await pool.query(
      `SELECT d.*
       FROM dishes d
       JOIN countries c ON c.id = d.country_id
       WHERE c.iso_code = $1
       ORDER BY d.name`,
      [iso]
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load dishes for country' });
  }
});

module.exports = router;