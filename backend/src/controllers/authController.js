const { login, refresh } = require("../services/authService");
const { registerFailedLoginAttempt, clearLoginAttempts } = require("../middlewares/authSecurity");

async function loginController(req, res, next) {
  try {
    const { email, password } = req.body;
    const result = await login(email, password);

    if (!result) {
      const lockInfo = registerFailedLoginAttempt(req, email);
      if (lockInfo.blocked) {
        res.set("Retry-After", String(lockInfo.retryAfterSeconds));
        return res.status(429).json({
          error: "Login temporariamente bloqueado por excesso de tentativas.",
          retryAfterSeconds: lockInfo.retryAfterSeconds
        });
      }
      return res.status(401).json({ error: "Credenciais invalidas" });
    }

    clearLoginAttempts(req, email);

    return res.status(200).json(result);
  } catch (error) {
    return next(error);
  }
}

async function refreshController(req, res, next) {
  try {
    const { refreshToken } = req.body;
    const result = await refresh(refreshToken);

    if (!result) {
      return res.status(401).json({ error: "Refresh token invalido" });
    }

    return res.status(200).json(result);
  } catch (error) {
    return res.status(401).json({ error: "Refresh token invalido" });
  }
}

module.exports = {
  loginController,
  refreshController
};
