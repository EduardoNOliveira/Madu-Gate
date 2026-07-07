const express = require("express");
const { body, query } = require("express-validator");

const { openGateController, accessHistoryController } = require("../controllers/accessController");
const { authRequired, roleRequired } = require("../middleware/authMiddleware");
const { validate } = require("../middleware/validate");

const router = express.Router();

router.use(authRequired);

router.post(
  "/open",
  [
    body("gateId").isInt({ min: 1 }).withMessage("gateId deve ser inteiro positivo"),
    body("source").optional().isIn(["mobile", "web", "esp32"]).withMessage("source invalido")
  ],
  validate,
  openGateController
);

router.get(
  "/history",
  roleRequired(["admin", "employee"]),
  [
    query("limit").optional().isInt({ min: 1, max: 200 }).withMessage("limit invalido"),
    query("offset").optional().isInt({ min: 0 }).withMessage("offset invalido")
  ],
  validate,
  accessHistoryController
);

module.exports = router;
