const { listVisitors, createVisitor } = require("../services/visitorService");

async function listVisitorsController(req, res, next) {
  try {
    const visitors = await listVisitors();
    return res.status(200).json(visitors);
  } catch (error) {
    return next(error);
  }
}

async function createVisitorController(req, res, next) {
  try {
    const visitor = await createVisitor(req.body);
    return res.status(201).json(visitor);
  } catch (error) {
    return next(error);
  }
}

module.exports = {
  listVisitorsController,
  createVisitorController
};
