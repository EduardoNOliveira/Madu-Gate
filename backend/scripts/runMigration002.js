require("dotenv").config();

const fs = require("fs");
const path = require("path");
const { pool } = require("../src/config/db");

async function run() {
  const migrationPath = path.resolve(__dirname, "../../database/migrations/002_visitors_vehicles.sql");
  const sql = fs.readFileSync(migrationPath, "utf-8");

  await pool.query(sql);
  console.log("Migration 002_visitors_vehicles.sql aplicada com sucesso.");
  await pool.end();
}

run().catch(async (error) => {
  console.error("Erro ao aplicar migration 002:", error.message);
  await pool.end();
  process.exit(1);
});
