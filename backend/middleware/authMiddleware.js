const { verifyToken } = require("../utils/tokens");

function authRequired(req, res, next) {
  const authHeader = req.headers.authorization || "";
  const [type, token] = authHeader.split(" ");

  if (type !== "Bearer" || !token) {
    return res.status(401).json({ error: "Token ausente ou invalido" });
  }

  try {
    req.user = verifyToken(token);
    return next();
  } catch (error) {
    return res.status(401).json({ error: "Token expirado ou invalido" });
  }
}

function roleRequired(allowedRoles) {
  return (req, res, next) => {
    const role = req.user?.role;
    if (!role || !allowedRoles.includes(role)) {
      return res.status(403).json({ error: "Permissao negada" });
    }
    return next();
  };
}

module.exports = {
  authRequired,
  roleRequired
};
