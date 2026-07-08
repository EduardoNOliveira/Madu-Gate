require("dotenv").config();

const bcrypt = require("bcrypt");
const { pool } = require("../src/config/db");

async function run() {
  const adminName = process.env.ADMIN_NAME || "Administrador";
  const adminEmail = process.env.ADMIN_EMAIL;
  const adminPassword = process.env.ADMIN_PASSWORD;

  if (!adminEmail || !adminPassword) {
    throw new Error("Defina ADMIN_EMAIL e ADMIN_PASSWORD no .env");
  }

  const passwordHash = await bcrypt.hash(adminPassword, 12);

  const result = await pool.query(
    `
      INSERT INTO users (name, email, password_hash, role)
      VALUES ($1, $2, $3, 'admin')
      ON CONFLICT (email)
      DO UPDATE SET
        name = EXCLUDED.name,
        password_hash = EXCLUDED.password_hash,
        role = 'admin',
        is_active = TRUE,
        updated_at = NOW()
      RETURNING id, name, email, role
    `,
    [adminName, adminEmail, passwordHash]
  );

  console.log("Admin pronto:", result.rows[0]);
  await pool.end();
}

run().catch(async (error) => {
  console.error("Erro ao seed de admin:", error.message);
  await pool.end();
  process.exit(1);
});
