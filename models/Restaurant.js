const mongoose = require('mongoose');

const restaurantSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  description: String,
  cuisine: [String], // e.g., ['Turkish', 'Arabic', 'Italian']
  rating: {
    type: Number,
    default: 0,
    min: 0,
    max: 5
  },
  reviewCount: {
    type: Number,
    default: 0
  },
  image: String,
  address: {
    street: String,
    district: String,
    city: { type: String, default: 'Mersin' },
    postalCode: String
  },
  location: {
    type: {
      type: String,
      enum: ['Point'],
      default: 'Point'
    },
    coordinates: {
      type: [Number], // [longitude, latitude]
      required: true
    }
  },
  phone: String,
  email: String,
  website: String,
  hours: {
    open: String,
    close: String,
    closed: [String] // Days closed
  },
  deliveryTime: {
    min: Number,
    max: Number,
    unit: { type: String, default: 'minutes' }
  },
  deliveryFee: Number,
  minimumOrder: Number,
  acceptsOnlinePayment: { type: Boolean, default: true },
  acceptsCashPayment: { type: Boolean, default: true },
  menu: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'MenuItem'
  }],
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  }
});

// Create geospatial index for location-based search
restaurantSchema.index({ 'location': '2dsphere' });

module.exports = mongoose.model('Restaurant', restaurantSchema);
