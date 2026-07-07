const express = require("express");
const cors = require("cors");
const helmet = require("helmet");

const authRoutes = require("../routes/authRoutes");
const userRoutes = require("../routes/userRoutes");
const accessRoutes = require("../routes/accessRoutes");
const visitorRoutes = require("../routes/visitorRoutes");
const vehicleRoutes = require("../routes/vehicleRoutes");

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.json());

app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok", service: "madu-gate-backend" });
});

app.use("/auth", authRoutes);
app.use("/users", userRoutes);
app.use("/access", accessRoutes);
app.use("/visitors", visitorRoutes);
app.use("/vehicles", vehicleRoutes);

app.use((req, res) => {
  res.status(404).json({ error: "Rota nao encontrada" });
});

app.use((error, req, res, next) => {
  if (res.headersSent) {
    return next(error);
  }

  const status = error.status || 500;
  return res.status(status).json({
    error: error.message || "Erro interno no servidor"
  });
});

module.exports = app;
