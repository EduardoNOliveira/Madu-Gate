const { pool } = require("../config/db");

async function openGate({ userId, gateId, source = "mobile" }) {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const gateResult = await client.query(
      `SELECT id, name, is_active FROM gates WHERE id = $1 LIMIT 1`,
      [gateId]
    );

    const gate = gateResult.rows[0];
    if (!gate || !gate.is_active) {
      await client.query("ROLLBACK");
      return null;
    }

    const eventResult = await client.query(
      `
        INSERT INTO access_events (user_id, gate_id, source, status)
        VALUES ($1, $2, $3, 'opened')
        RETURNING id, user_id, gate_id, source, status, created_at
      `,
      [userId, gateId, source]
    );

    await client.query(
      `UPDATE gates SET last_opened_at = NOW() WHERE id = $1`,
      [gateId]
    );

    await client.query("COMMIT");

    return eventResult.rows[0];
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
}

async function listAccessHistory({ limit = 50, offset = 0 }) {
  const result = await pool.query(
    `
      SELECT
        ae.id,
        ae.created_at,
        ae.status,
        ae.source,
        u.id AS user_id,
        u.name AS user_name,
        g.id AS gate_id,
        g.name AS gate_name
      FROM access_events ae
      INNER JOIN users u ON u.id = ae.user_id
      INNER JOIN gates g ON g.id = ae.gate_id
      ORDER BY ae.created_at DESC
      LIMIT $1 OFFSET $2
    `,
    [limit, offset]
  );

  return result.rows;
}

module.exports = {
  openGate,
  listAccessHistory
};
