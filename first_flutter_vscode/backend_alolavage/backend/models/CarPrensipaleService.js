const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const Carsprensipchema = new Schema({
 
  model: {
    type: String,
    required: true,
    unique: false,
  },
  ServicePren: {
    type: String,
    required: true
  },
  image: {
    type: String,
    required: true
  },
  prix: {
    type: Number,
    required: true
  },
 
}, {
  timestamps: true  
});

const carprensipe = mongoose.model('carprensipe', Carsprensipchema);
module.exports = carprensipe;
