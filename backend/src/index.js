require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const authRoutes = require('./routes/auth_routes');
const eventRoutes = require('./routes/event_routes');
const bookingRoutes = require('./routes/booking_routes');
const adminRoutes = require('./routes/admin_routes');

const { initDb } = require('./config/db');

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());
app.use(bodyParser.json());

// initialize db pool (ensures env present)
initDb();

app.get('/', (req, res) => res.json({ message: 'EventEase API up' }));

app.use('/api/auth', authRoutes);
app.use('/api/events', eventRoutes);
app.use('/api/bookings', bookingRoutes);
app.use('/api/admin', adminRoutes);

app.listen(PORT, () => {
  console.log(`EventEase backend listening on port ${PORT}`);
});
