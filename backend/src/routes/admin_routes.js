const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth_middleware');
const { createEvent, updateEvent, deleteEvent } = require('../models/event_model');

// admin middleware: require auth then check role
router.use(auth);
router.use((req, res, next) => {
  if (req.user.role !== 'admin') return res.status(403).json({ error: 'Admin only' });
  next();
});

// POST /api/admin/events -> create event
router.post('/events', async (req, res) => {
  try {
    const { title, description, date, location, capacity, category } = req.body;
    const ev = await createEvent({ title, description, date, location, capacity, category });
    res.json(ev);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// PUT /api/admin/events/:id -> update
router.put('/events/:id', async (req, res) => {
  try {
    const ev = await updateEvent(req.params.id, req.body);
    res.json(ev);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/admin/events/:id
router.delete('/events/:id', async (req, res) => {
  try {
    await deleteEvent(req.params.id);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
