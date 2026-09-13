const Restaurant = require('../models/Restaurant');
const MenuItem = require('../models/MenuItem');

// Get all restaurants
exports.getAllRestaurants = async (req, res) => {
  try {
    const restaurants = await Restaurant.find()
      .select('name description cuisine rating reviewCount image address phone deliveryTime deliveryFee minimumOrder');
    res.json(restaurants);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get restaurant by ID
exports.getRestaurantById = async (req, res) => {
  try {
    const restaurant = await Restaurant.findById(req.params.id)
      .populate('menu');

    if (!restaurant) {
      return res.status(404).json({ message: 'Restaurant not found' });
    }

    res.json(restaurant);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Search restaurants by location (near user)
exports.searchNearby = async (req, res) => {
  try {
    const { latitude, longitude, maxDistance = 5000 } = req.query;

    if (!latitude || !longitude) {
      return res.status(400).json({ message: 'Latitude and longitude are required' });
    }

    const restaurants = await Restaurant.find({
      location: {
        $near: {
          $geometry: {
            type: 'Point',
            coordinates: [parseFloat(longitude), parseFloat(latitude)]
          },
          $maxDistance: parseInt(maxDistance)
        }
      }
    }).select('name description cuisine rating image address deliveryTime deliveryFee minimumOrder');

    res.json(restaurants);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Search restaurants by name or cuisine
exports.searchRestaurants = async (req, res) => {
  try {
    const { query, cuisine, minRating = 0, maxPrice = Infinity } = req.query;

    let filter = {};

    if (query) {
      filter.$or = [
        { name: { $regex: query, $options: 'i' } },
        { description: { $regex: query, $options: 'i' } },
        { cuisine: { $in: [new RegExp(query, 'i')] } }
      ];
    }

    if (cuisine) {
      filter.cuisine = cuisine;
    }

    if (minRating) {
      filter.rating = { $gte: parseFloat(minRating) };
    }

    const restaurants = await Restaurant.find(filter)
      .select('name description cuisine rating reviewCount image address deliveryTime deliveryFee minimumOrder')
      .limit(20);

    res.json(restaurants);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Create restaurant (admin only)
exports.createRestaurant = async (req, res) => {
  try {
    const { name, description, cuisine, address, location, phone, email, website, hours, deliveryTime, deliveryFee, minimumOrder, acceptsOnlinePayment, acceptsCashPayment } = req.body;

    const restaurant = new Restaurant({
      name,
      description,
      cuisine,
      address,
      location,
      phone,
      email,
      website,
      hours,
      deliveryTime,
      deliveryFee,
      minimumOrder,
      acceptsOnlinePayment,
      acceptsCashPayment
    });

    await restaurant.save();

    res.status(201).json({
      message: 'Restaurant created successfully',
      restaurant
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update restaurant
exports.updateRestaurant = async (req, res) => {
  try {
    let restaurant = await Restaurant.findById(req.params.id);

    if (!restaurant) {
      return res.status(404).json({ message: 'Restaurant not found' });
    }

    Object.assign(restaurant, req.body);
    restaurant.updatedAt = Date.now();
    await restaurant.save();

    res.json({
      message: 'Restaurant updated successfully',
      restaurant
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get top rated restaurants
exports.getTopRated = async (req, res) => {
  try {
    const restaurants = await Restaurant.find()
      .sort({ rating: -1 })
      .limit(10)
      .select('name description cuisine rating reviewCount image address deliveryTime deliveryFee minimumOrder');

    res.json(restaurants);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get restaurants by district in Mersin
exports.getByDistrict = async (req, res) => {
  try {
    const { district } = req.params;

    const restaurants = await Restaurant.find({ 'address.district': new RegExp(district, 'i') })
      .select('name description cuisine rating reviewCount image address deliveryTime deliveryFee minimumOrder');

    res.json(restaurants);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
