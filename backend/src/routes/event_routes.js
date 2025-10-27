const express = require('express');
const router = express.Router();
const { getEvents, getEventById, filterEvents, getRemainingCapacity } = require('../models/event_model');
const { formatDate, getEventStatus } = require('../utils/date_utils');

// GET /api/events
router.get('/', async (req, res) => {
  try {
    const events = await getEvents();
    // map to include formatted date and status and remaining seats
    const enhanced = await Promise.all(events.map(async ev => {
      const remaining = await getRemainingCapacity(ev.id);
      return {
        ...ev,
        formattedDate: formatDate(ev.date),
        status: getEventStatus(ev.date),
        remainingCapacity: remaining
      };
    }));
    res.json(enhanced);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/events/:id
router.get('/:id', async (req, res) => {
  try {
    const ev = await getEventById(req.params.id);
    if (!ev) return res.status(404).json({ error: 'Event not found' });
    const remaining = await getRemainingCapacity(ev.id);
    res.json({
      ...ev,
      formattedDate: formatDate(ev.date),
      status: formatDate(ev.date) ? require('../utils/date_utils').getEventStatus(ev.date) : null,
      remainingCapacity: remaining
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/events/filter
router.post('/filter', async (req, res) => {
  try {
    const { dateFrom, dateTo, location, category } = req.body;
    const events = await filterEvents({ dateFrom, dateTo, location, category });
    const enhanced = await Promise.all(events.map(async ev => {
      const remaining = await getRemainingCapacity(ev.id);
      return {
        ...ev,
        formattedDate: formatDate(ev.date),
        status: require('../utils/date_utils').getEventStatus(ev.date),
        remainingCapacity: remaining
      };
    }));
    res.json(enhanced);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
