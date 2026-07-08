const { openGate, listAccessHistory } = require("../services/accessService");

async function openGateController(req, res, next) {
  try {
    const event = await openGate({
      userId: req.user.sub,
      gateId: req.body.gateId,
      source: req.body.source || "mobile"
    });

    if (!event) {
      return res.status(404).json({ error: "Portao nao encontrado ou inativo" });
    }

    return res.status(201).json(event);
  } catch (error) {
    return next(error);
  }
}

async function accessHistoryController(req, res, next) {
  try {
    const limit = Number(req.query.limit || 50);
    const offset = Number(req.query.offset || 0);

    const history = await listAccessHistory({ limit, offset });
    return res.status(200).json(history);
  } catch (error) {
    return next(error);
  }
}

module.exports = {
  openGateController,
  accessHistoryController
};
