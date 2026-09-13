const express = require('express');
const router = express.Router();
const paymentController = require('../controllers/paymentController');
const auth = require('../middleware/auth');

// Payment routes
router.post('/create-intent', auth, paymentController.createPaymentIntent);
router.post('/cash-payment', auth, paymentController.processCashPayment);
router.get('/status/:id', auth, paymentController.getPaymentStatus);

// Webhook (no auth needed)
router.post('/webhook', express.raw({type: 'application/json'}), paymentController.handleWebhook);

module.exports = router;
