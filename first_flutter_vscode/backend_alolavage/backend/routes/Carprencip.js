const express = require("express");
const bcryptjs = require("bcryptjs");
const CarPrensipaleService = require("../models/CarPrensipaleService");
const carRouterprencip = express.Router();
// const jwt = require("jsonwebtoken");
// const auth = require("../middleware/auth");

carRouterprencip.post("/api/create-carprencip", async (req, res) => {
  try {
    // Destructure the data from the request body
    const { model,image,ServicePren,prix } = req.body;

 
    // Create a new cours object
    const newCar = new CarPrensipaleService({
      model,
      prix,
      image,
      ServicePren // Optional, will use default if not provided
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


carRouterprencip.get("/api/get-carprensip", async (req, res) => {
    try {
      const list = await CarPrensipaleService.find();  // Fetch all courses from the database
      res.status(200).json(list);  // Send the list of courses in the response
    } catch (error) {
      res.status(500).json({ message: "Error fetching courses =================== \n", error });
    }
  });
  



module.exports = carRouterprencip;
