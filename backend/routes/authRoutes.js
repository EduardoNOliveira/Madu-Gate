const express = require("express");
const { body } = require("express-validator");

const { loginController, refreshController } = require("../controllers/authController");
const { validate } = require("../middleware/validate");

const router = express.Router();

router.post(
  "/login",
  [
    body("email").isEmail().withMessage("E-mail invalido"),
    body("password").isLength({ min: 6 }).withMessage("Senha invalida")
  ],
  validate,
  loginController
);

router.post(
  "/refresh",
  [body("refreshToken").notEmpty().withMessage("Refresh token obrigatorio")],
  validate,
  refreshController
);

module.exports = router;
