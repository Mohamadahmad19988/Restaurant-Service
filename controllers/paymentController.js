const Payment = require('../models/Payment');
const Order = require('../models/Order');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

// Create payment intent for Stripe
exports.createPaymentIntent = async (req, res) => {
  try {
    const { orderId } = req.body;

    const order = await Order.findById(orderId);
    if (!order) {
      return res.status(404).json({ message: 'Order not found' });
    }

    // Create Stripe payment intent
    const paymentIntent = await stripe.paymentIntents.create({
      amount: Math.round(order.total * 100), // Convert to cents
      currency: 'try',
      metadata: {
        orderId: orderId
      }
    });

    // Create payment record
    const payment = new Payment({
      order: orderId,
      user: order.user,
      amount: order.total,
      currency: 'TRY',
      method: 'credit_card',
      status: 'pending',
      stripePaymentIntentId: paymentIntent.id
    });

    await payment.save();

    // Update order with payment reference
    order.payment = payment._id;
    await order.save();

    res.json({
      clientSecret: paymentIntent.client_secret,
      paymentId: payment._id
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Handle Stripe webhook
exports.handleWebhook = async (req, res) => {
  const sig = req.headers['stripe-signature'];
  let event;

  try {
    event = stripe.webhooks.constructEvent(
      req.rawBody,
      sig,
      process.env.STRIPE_WEBHOOK_SECRET
    );
  } catch (error) {
    return res.status(400).send(`Webhook Error: ${error.message}`);
  }

  try {
    switch (event.type) {
      case 'payment_intent.succeeded':
        const paymentIntent = event.data.object;
        const payment = await Payment.findOne({
          stripePaymentIntentId: paymentIntent.id
        });
        if (payment) {
          payment.status = 'completed';
          payment.transactionId = paymentIntent.id;
          await payment.save();

          // Update order
          const order = await Order.findById(payment.order);
          if (order) {
            order.paymentStatus = 'completed';
            order.status = 'confirmed';
            await order.save();
          }
        }
        break;

      case 'payment_intent.payment_failed':
        const failedPayment = await Payment.findOne({
          stripePaymentIntentId: event.data.object.id
        });
        if (failedPayment) {
          failedPayment.status = 'failed';
          failedPayment.errorMessage = event.data.object.last_payment_error?.message;
          await failedPayment.save();
        }
        break;

      default:
        console.log(`Unhandled event type ${event.type}`);
    }

    res.json({ received: true });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Process cash payment
exports.processCashPayment = async (req, res) => {
  try {
    const { orderId } = req.body;

    const order = await Order.findById(orderId);
    if (!order) {
      return res.status(404).json({ message: 'Order not found' });
    }

    const payment = new Payment({
      order: orderId,
      user: order.user,
      amount: order.total,
      currency: 'TRY',
      method: 'cash',
      status: 'pending'
    });

    await payment.save();

    order.payment = payment._id;
    order.paymentStatus = 'pending';
    order.status = 'pending';
    await order.save();

    res.json({
      message: 'Cash payment registered. Please pay the driver.',
      payment
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get payment status
exports.getPaymentStatus = async (req, res) => {
  try {
    const payment = await Payment.findById(req.params.id);

    if (!payment) {
      return res.status(404).json({ message: 'Payment not found' });
    }

    res.json(payment);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
