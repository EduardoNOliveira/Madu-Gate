const { pool } = require("../config/db");

async function listVisitors() {
  const result = await pool.query(
    `SELECT id, name, document, phone, created_at FROM visitors ORDER BY created_at DESC`
  );
  return result.rows;
}

async function createVisitor({ name, document, phone }) {
  const result = await pool.query(
    `
      INSERT INTO visitors (name, document, phone)
      VALUES ($1, $2, $3)
      RETURNING id, name, document, phone, created_at
    `,
    [name, document || null, phone || null]
  );

  return result.rows[0];
}

module.exports = {
  listVisitors,
  createVisitor
};
