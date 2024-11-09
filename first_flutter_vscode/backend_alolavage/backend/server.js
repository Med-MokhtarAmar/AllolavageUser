const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const carRouter = require("./routes/Car");
const path = require('path');

const carRouterprencip = require("./routes/Carprencip");
const cors = require("cors"); // Import cors
 

const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json());
app.use(cors());  
// Logging middleware
app.use((req, res, next) => {
  const logInfo = {
    method: req.method,
    url: req.url,
    body: req.body,
  };
  console.log(logInfo)
  next();
});
app.use('/media', express.static(path.join(__dirname, 'media')));

app.use(authRouter);
app.use(carRouter);
app.use(carRouterprencip);

// app.use(realetimec)

const DB = "mongodb://localhost:27017/allolavage";

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

// Start the server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
