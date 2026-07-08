const express = require("express");
const { body } = require("express-validator");

const { listVehiclesController, createVehicleController } = require("../controllers/vehicleController");
const { authRequired, roleRequired } = require("../middlewares/authMiddleware");
const { validate } = require("../middlewares/validate");

const router = express.Router();

router.use(authRequired);

router.get("/", roleRequired(["admin", "employee"]), listVehiclesController);

router.post(
  "/",
  roleRequired(["admin", "employee"]),
  [
    body("plate")
      .notEmpty()
      .withMessage("Placa obrigatoria")
      .matches(/^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$/i)
      .withMessage("Placa invalida"),
    body("model").optional().isLength({ min: 1, max: 80 }).withMessage("Modelo invalido"),
    body("color").optional().isLength({ min: 1, max: 40 }).withMessage("Cor invalida"),
    body("ownerName").optional().isLength({ min: 1, max: 120 }).withMessage("Nome do proprietario invalido")
  ],
  validate,
  createVehicleController
);

module.exports = router;
