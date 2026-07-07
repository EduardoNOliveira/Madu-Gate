const bcrypt = require("bcrypt");
const { pool } = require("../config/db");
const { signAccessToken, signRefreshToken, verifyToken } = require("../utils/tokens");

async function login(email, password) {
  const query = `
    SELECT id, name, email, password_hash, role, is_active
    FROM users
    WHERE email = $1
    LIMIT 1
  `;

  const { rows } = await pool.query(query, [email]);
  const user = rows[0];

  if (!user || !user.is_active) {
    return null;
  }

  const isPasswordValid = await bcrypt.compare(password, user.password_hash);
  if (!isPasswordValid) {
    return null;
  }

  const accessToken = signAccessToken(user);
  const refreshToken = signRefreshToken(user);

  await pool.query(
    `INSERT INTO refresh_tokens (user_id, token) VALUES ($1, $2)`,
    [user.id, refreshToken]
  );

  return {
    accessToken,
    refreshToken,
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role
    }
  };
}

async function refresh(refreshToken) {
  const payload = verifyToken(refreshToken);
  if (payload.type !== "refresh") {
    return null;
  }

  const stored = await pool.query(
    `SELECT id, user_id FROM refresh_tokens WHERE token = $1 LIMIT 1`,
    [refreshToken]
  );

  if (!stored.rows[0]) {
    return null;
  }

  const userResult = await pool.query(
    `SELECT id, name, email, role, is_active FROM users WHERE id = $1 LIMIT 1`,
    [payload.sub]
  );

  const user = userResult.rows[0];
  if (!user || !user.is_active) {
    return null;
  }

  const newAccessToken = signAccessToken(user);
  return { accessToken: newAccessToken };
}

module.exports = {
  login,
  refresh
};
