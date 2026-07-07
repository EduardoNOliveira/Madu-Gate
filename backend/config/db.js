const { Pool } = require("pg");

const connectionString = process.env.DATABASE_URL;
const dbSsl = (process.env.DB_SSL || "false").toLowerCase() === "true";

if (!connectionString) {
  throw new Error("DATABASE_URL nao definido nas variaveis de ambiente");
}

const pool = new Pool({
  connectionString,
  ssl: dbSsl
    ? {
        rejectUnauthorized: false
      }
    : false
});

async function testConnection() {
  const client = await pool.connect();
  try {
    await client.query("SELECT 1");
  } finally {
    client.release();
  }
}

module.exports = {
  pool,
  testConnection
};
