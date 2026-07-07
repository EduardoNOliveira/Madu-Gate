const bcrypt = require("bcrypt");
const { pool } = require("../config/db");

async function listUsers() {
  const result = await pool.query(
    `SELECT id, name, email, role, is_active, created_at FROM users ORDER BY created_at DESC`
  );
  return result.rows;
}

async function createUser({ name, email, password, role = "resident" }) {
  const passwordHash = await bcrypt.hash(password, 12);

  const result = await pool.query(
    `
      INSERT INTO users (name, email, password_hash, role)
      VALUES ($1, $2, $3, $4)
      RETURNING id, name, email, role, is_active, created_at
    `,
    [name, email, passwordHash, role]
  );

  return result.rows[0];
}

module.exports = {
  listUsers,
  createUser
};
