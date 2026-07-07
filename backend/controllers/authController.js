const { login, refresh } = require("../services/authService");

async function loginController(req, res, next) {
  try {
    const { email, password } = req.body;
    const result = await login(email, password);

    if (!result) {
      return res.status(401).json({ error: "Credenciais invalidas" });
    }

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
