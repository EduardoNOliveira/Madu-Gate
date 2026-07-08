const { pool } = require("../config/db");

async function listVehicles() {
  const result = await pool.query(
    `
      SELECT id, plate, model, color, owner_name, is_active, created_at
      FROM vehicles
      ORDER BY created_at DESC
    `
  );
  return result.rows;
}

async function createVehicle({ plate, model, color, ownerName }) {
  const result = await pool.query(
    `
      INSERT INTO vehicles (plate, model, color, owner_name)
      VALUES (UPPER($1), $2, $3, $4)
      RETURNING id, plate, model, color, owner_name, is_active, created_at
    `,
    [plate, model || null, color || null, ownerName || null]
  );

  return result.rows[0];
}

module.exports = {
  listVehicles,
  createVehicle
};
