const express = require("express");
const bcryptjs = require("bcryptjs");
const Car = require("../models/Car");
const carRouter = express.Router();
// const jwt = require("jsonwebtoken");
// const auth = require("../middleware/auth");

carRouter.post("/api/create-car", async (req, res) => {
  try {
    // Destructure the data from the request body
    const { Numero,mark,iduser,size } = req.body;

 
    // Create a new cours object
    const newCar = new Car({
      Numero,
      size,
      iduser,
      mark // Optional, will use default if not provided
    });

    // Save the cours to the database
    const savedCar = await newCar.save();
    console.log("the cors has been created !")

    // Return the saved cours
    res.status(201).json(savedCar);

  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "An error occurred while creating the cours" });
  }
});


carRouter.post("/api/get-cars", async (req, res) => {
  const { id } = req.body;

    try {
      const list = await Car.find({iduser:id});  // Fetch all courses from the database
      res.status(200).json(list);  // Send the list of courses in the response
    } catch (error) {
      res.status(500).json({ message: "Error fetching courses =================== \n", error });
    }
  });
  



module.exports = carRouter;
