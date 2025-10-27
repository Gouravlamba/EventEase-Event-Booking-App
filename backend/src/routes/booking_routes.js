const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth_middleware');
const logger = require('../middleware/logger_middleware');
const bookingService = require('../services/booking_service');
const { getBookingsByUser } = require('../models/booking_model');

// All booking routes require authentication
router.use(auth);

// GET /api/bookings/  -> list user's bookings
router.get('/', async (req, res) => {
  try {
    const userId = req.user.id;
    const bookings = await getBookingsByUser(userId);
    res.json(bookings);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/bookings/create -> book an event
router.post('/create', logger, async (req, res) => {
  try {
    const userId = req.user.id;
    const { eventId } = req.body;
    const booking = await bookingService.createBooking({ userId, eventId });
    res.json({ success: true, booking });
  } catch (err) {
    console.error(err);
    res.status(400).json({ error: err.message || 'Booking error' });
  }
});

// POST /api/bookings/cancel -> cancel by bookingId
router.post('/cancel', logger, async (req, res) => {
  try {
    const userId = req.user.id;
    const { bookingId } = req.body;
    const result = await bookingService.cancelBooking({ userId, bookingId });
    res.json({ success: true, result });
  } catch (err) {
    console.error(err);
    res.status(400).json({ error: err.message || 'Cancel error' });
  }
});

module.exports = router;
