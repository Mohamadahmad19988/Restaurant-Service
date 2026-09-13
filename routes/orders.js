const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');
const auth = require('../middleware/auth');

// All order routes require authentication
router.post('/', auth, orderController.createOrder);
router.get('/user/orders', auth, orderController.getUserOrders);
router.get('/:id', auth, orderController.getOrderById);
router.put('/:id/status', auth, orderController.updateOrderStatus);
router.put('/:id/cancel', auth, orderController.cancelOrder);
router.post('/:id/rate', auth, orderController.rateOrder);

module.exports = router;
