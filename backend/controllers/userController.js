const { listUsers, createUser } = require("../services/userService");

async function listUsersController(req, res, next) {
  try {
    const users = await listUsers();
    return res.status(200).json(users);
  } catch (error) {
    return next(error);
  }
}

async function createUserController(req, res, next) {
  try {
    const user = await createUser(req.body);
    return res.status(201).json(user);
  } catch (error) {
    if (error.code === "23505") {
      return res.status(409).json({ error: "E-mail ja cadastrado" });
    }
    return next(error);
  }
}

module.exports = {
  listUsersController,
  createUserController
};
