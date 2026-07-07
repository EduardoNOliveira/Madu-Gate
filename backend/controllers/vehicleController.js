const { listVehicles, createVehicle } = require("../services/vehicleService");

async function listVehiclesController(req, res, next) {
  try {
    const vehicles = await listVehicles();
    return res.status(200).json(vehicles);
  } catch (error) {
    return next(error);
  }
}

async function createVehicleController(req, res, next) {
  try {
    const vehicle = await createVehicle(req.body);
    return res.status(201).json(vehicle);
  } catch (error) {
    if (error.code === "23505") {
      return res.status(409).json({ error: "Placa ja cadastrada" });
    }
    return next(error);
  }
}

module.exports = {
  listVehiclesController,
  createVehicleController
};
