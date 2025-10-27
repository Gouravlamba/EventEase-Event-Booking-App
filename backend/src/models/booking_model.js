const { getPool } = require('../config/db');

async function createBooking({ booking_id, user_id, event_id, created_at }) {
  const pool = getPool();
  const res = await pool.query(
    `INSERT INTO bookings (booking_id, user_id, event_id, created_at)
     VALUES ($1, $2, $3, $4) RETURNING *`,
    [booking_id, user_id, event_id, created_at]
  );
  return res.rows[0];
}

async function getBookingsByUser(userId) {
  const pool = getPool();
  const res = await pool.query(
    `SELECT b.*, e.title, e.date, e.location
     FROM bookings b
     JOIN events e ON e.id = b.event_id
     WHERE b.user_id = $1
     ORDER BY e.date ASC`,
    [userId]
  );
  return res.rows;
}

async function findBookingById(bookingId) {
  const pool = getPool();
  const res = await pool.query(`SELECT * FROM bookings WHERE booking_id = $1`, [bookingId]);
  return res.rows[0];
}

async function userHasBookingForEvent(userId, eventId) {
  const pool = getPool();
  const res = await pool.query(`SELECT * FROM bookings WHERE user_id=$1 AND event_id=$2`, [userId, eventId]);
  return res.rowCount > 0;
}

async function deleteBooking(bookingId) {
  const pool = getPool();
  await pool.query(`DELETE FROM bookings WHERE booking_id = $1`, [bookingId]);
  return true;
}

// Optional: log table entry for bookings logs (if we want persistent logs)
async function logBookingAction({ user_id, booking_id, action, timestamp }) {
  const pool = getPool();
  await pool.query(
    `INSERT INTO booking_logs (user_id, booking_id, action, created_at)
     VALUES ($1, $2, $3, $4)`,
    [user_id, booking_id, action, timestamp]
  );
}

module.exports = {
  createBooking,
  getBookingsByUser,
  findBookingById,
  userHasBookingForEvent,
  deleteBooking,
  logBookingAction
};
