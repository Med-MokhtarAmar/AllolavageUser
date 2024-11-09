const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const Carschema = new Schema({
  Numero: {
    type: String,
    required: true,
    unique: false,
  },
  mark: {
    type: String,
    required: true
  },
  size: {
    type: String,
    required: true
  },
  iduser: {
    type: String,
    required: true
  },
 
}, {
  timestamps: true  
});

const Car = mongoose.model('car', Carschema);
module.exports = Car;
