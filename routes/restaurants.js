const express = require('express');
const router = express.Router();
const restaurantController = require('../controllers/restaurantController');
const auth = require('../middleware/auth');

// Public routes
router.get('/', restaurantController.getAllRestaurants);
router.get('/search', restaurantController.searchRestaurants);
router.get('/nearby', restaurantController.searchNearby);
router.get('/top-rated', restaurantController.getTopRated);
router.get('/district/:district', restaurantController.getByDistrict);
router.get('/:id', restaurantController.getRestaurantById);

// Admin routes (protected)
router.post('/', auth, restaurantController.createRestaurant);
router.put('/:id', auth, restaurantController.updateRestaurant);

module.exports = router;
