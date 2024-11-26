const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const AmpSchema = new Schema({
  tel: {
    type: String,
    required: true,
    unique: true,
    validate: {
      validator: function(v) {
        return /^[234]\d{7}$/.test(v); // Doit commencer par 2, 3, ou 4 et contenir exactement 8 chiffres
      },
      message: props => `${props.value} is not a valid phone number! Must start with 2, 3, or 4 and contain 8 digits.`
    }
  },
  pwd: {
    type: String,
    required: true
  },
  nom: {
    type: String,
    required: true
  },
  salaire: {
    type: Number,
    required: true,
    default: 0
  },
 
  isActive: {
    type: Boolean,
    default: false
  },
    isFree: {
    type: Boolean,
    default: false
  },
  location: {
    type: {
      type: String, // Always 'Point'
      enum: ['Point'],
      required: true
    },
    coordinates: {
      type: [Number], // Array of numbers [longitude, latitude]
      required: true,
      default: [18.122989, -15.992324]
    }
  }
}, {
  timestamps: true // Automatically adds createdAt and updatedAt fields
});

const Emps = mongoose.model('Emps', AmpSchema);
module.exports = Emps;
