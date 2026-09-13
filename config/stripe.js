const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

// Configure Stripe
stripe.setApiVersion('2023-10-16');

module.exports = stripe;
