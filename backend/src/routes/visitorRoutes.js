const express = require("express");
const { body } = require("express-validator");

const { listVisitorsController, createVisitorController } = require("../controllers/visitorController");
const { authRequired, roleRequired } = require("../middlewares/authMiddleware");
const { validate } = require("../middlewares/validate");

const router = express.Router();

router.use(authRequired);

router.get("/", roleRequired(["admin", "employee"]), listVisitorsController);

router.post(
  "/",
  roleRequired(["admin", "employee"]),
  [
    body("name").notEmpty().withMessage("Nome obrigatorio"),
    body("document").optional().isLength({ min: 5, max: 30 }).withMessage("Documento invalido"),
    body("phone").optional().isLength({ min: 8, max: 25 }).withMessage("Telefone invalido")
  ],
  validate,
  createVisitorController
);

module.exports = router;
