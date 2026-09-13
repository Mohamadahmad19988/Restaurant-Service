const express = require('express');
const router = express.Router();
const menuController = require('../controllers/menuController');
const auth = require('../middleware/auth');

// Public routes
router.get('/restaurant/:restaurantId', menuController.getMenuByRestaurant);
router.get('/restaurant/:restaurantId/category/:category', menuController.getByCategory);
router.get('/item/:id', menuController.getMenuItemById);
router.get('/search', menuController.searchMenuItems);
router.get('/recommended/:restaurantId', menuController.getRecommended);

// Protected routes (admin/restaurant owner)
router.post('/', auth, menuController.createMenuItem);
router.put('/:id', auth, menuController.updateMenuItem);

module.exports = router;
