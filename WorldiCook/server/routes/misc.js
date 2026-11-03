const express = require('express');
const pool = require('../db');

const router = express.Router();

router.get('/daily-country', async (req, res) => {
  try {
    const countries = await pool.query(
      `SELECT id, name, iso_code, continent, region, flag_emoji, description, latitude, longitude
       FROM countries
       ORDER BY id`
    );
    if (countries.rows.length === 0) {
      return res.status(404).json({ error: 'No countries seeded yet' });
    }

    const start = new Date(new Date().getFullYear(), 0, 0);
    const diff = new Date() - start;
    const dayOfYear = Math.floor(diff / (1000 * 60 * 60 * 24));
    const country = countries.rows[dayOfYear % countries.rows.length];

    const featuredDish = await pool.query(
      `SELECT id, name, description, emoji, category
       FROM dishes
       WHERE country_id = $1
       ORDER BY id
       LIMIT 1`,
      [country.id]
    );

    res.json({ ...country, featuredDish: featuredDish.rows[0] || null });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load daily country' });
  }
});

router.get('/search', async (req, res) => {
  const q = (req.query.q || '').trim();
  if (!q) return res.json({ countries: [], dishes: [] });

  try {
    const countries = await pool.query(
      `SELECT id, name, iso_code, flag_emoji FROM countries WHERE name ILIKE $1 ORDER BY name LIMIT 20`,
      [`%${q}%`]
    );
    const dishes = await pool.query(
      `SELECT d.id, d.name, d.emoji, c.iso_code, c.flag_emoji, c.name AS country_name
       FROM dishes d
       JOIN countries c ON c.id = d.country_id
       WHERE d.name ILIKE $1
       ORDER BY d.name
       LIMIT 20`,
      [`%${q}%`]
    );
    res.json({ countries: countries.rows, dishes: dishes.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Search failed' });
  }
});

module.exports = router;