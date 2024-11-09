const express = require("express");
const bcryptjs = require("bcryptjs");
const Emps = require("../models/Emps");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

// Sign Up
authRouter.post("/api/emp/signup", async (req, res) => {
    try {
      const { tel, pwd, nom, role, coordinates } = req.body;
  
      // Validation des champs
      const existingUser = await Emps.findOne({ tel });
      if (existingUser) {
        return res.status(400).json({ msg: "User with the same phone number already exists!" });
      }
  
      const hashedPassword = await bcryptjs.hash(pwd, 8);
  
      let emp = new Emps({
        tel,
        pwd: hashedPassword,
        nom,
        salaire:0,
        isActive:false,
        isFree:true,
        location: {
          type: "Point",
          coordinates: coordinates || [18.122989, -15.992324] // Default coordinates
        }
      });
  
      emp = await emp.save();
      console.log("one Emp is created !")
      res.json(emp);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
// Sign In

authRouter.post("/api/emp/signin", async (req, res) => {
  // consol.log("======================")
    try {
      const { tel, pwd } = req.body;
  
      const emp = await Emps.findOne({ tel });
      if (!emp) {
        return res.status(400).json({ msg: "User with this phone number does not exist!" });
      }
  
      const isMatch = await bcryptjs.compare(pwd, emp.pwd);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password." });
      }
  
      const token = jwt.sign({ id: emp._id }, "passwordKey");
      console.log({ token, ...emp._doc })
      res.json({ token, ...emp._doc });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


 
 

module.exports = authRouter;
