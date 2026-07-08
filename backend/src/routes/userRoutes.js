const express = require("express");
const { body } = require("express-validator");

const { listUsersController, createUserController } = require("../controllers/userController");
const { authRequired, roleRequired } = require("../middlewares/authMiddleware");
const { validate } = require("../middlewares/validate");

const router = express.Router();

router.use(authRequired);

router.get("/", roleRequired(["admin"]), listUsersController);

router.post(
  "/",
  roleRequired(["admin"]),
  [
    body("name").notEmpty().withMessage("Nome obrigatorio"),
    body("email").isEmail().withMessage("E-mail invalido"),
    body("password").isLength({ min: 6 }).withMessage("Senha precisa ter no minimo 6 caracteres"),
    body("role").optional().isIn(["admin", "resident", "employee", "visitor"]).withMessage("Role invalida")
  ],
  validate,
  createUserController
);

module.exports = router;
