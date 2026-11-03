const express = require('express');
const pool = require('../db');

const router = express.Router();

router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT d.*, c.name AS country_name, c.iso_code, c.flag_emoji
       FROM dishes d
       JOIN countries c ON c.id = d.country_id
       WHERE d.id = $1`,
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Dish not found' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load dish' });
  }
});

router.get('/:id/ingredients', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT i.name, di.quantity, di.unit, di.notes
       FROM dish_ingredients di
       JOIN ingredients i ON i.id = di.ingredient_id
       WHERE di.dish_id = $1
       ORDER BY di.id`,
      [req.params.id]
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load ingredients' });
  }
});

router.get('/:id/steps', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT step_number, instruction
       FROM recipe_steps
       WHERE dish_id = $1
       ORDER BY step_number`,
      [req.params.id]
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load recipe steps' });
  }
});

router.get('/:id/sources', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT source_type, title, url, publisher
       FROM sources
       WHERE dish_id = $1
       ORDER BY id`,
      [req.params.id]
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load sources' });
  }
});

module.exports = router;