const { getPool } = require('../config/db');

async function createEvent({ title, description, date, location, capacity, category }) {
  const pool = getPool();
  const res = await pool.query(
    `INSERT INTO events (title, description, date, location, capacity, category, created_at)
     VALUES ($1, $2, $3, $4, $5, $6, now())
     RETURNING *`,
    [title, description, date, location, capacity, category]
  );
  return res.rows[0];
}

async function updateEvent(id, fields = {}) {
  const pool = getPool();
  // Build set clause dynamically
  const keys = Object.keys(fields);
  if (keys.length === 0) return null;
  const setClause = keys.map((k, i) => `${k}=$${i + 2}`).join(', ');
  const values = [id, ...keys.map(k => fields[k])];
  const res = await pool.query(`UPDATE events SET ${setClause} WHERE id = $1 RETURNING *`, values);
  return res.rows[0];
}

async function deleteEvent(id) {
  const pool = getPool();
  await pool.query(`DELETE FROM events WHERE id = $1`, [id]);
  return true;
}

async function getEvents() {
  const pool = getPool();
  const res = await pool.query(`SELECT * FROM events ORDER BY date ASC`);
  return res.rows;
}

async function getEventById(id) {
  const pool = getPool();
  const res = await pool.query(`SELECT * FROM events WHERE id = $1`, [id]);
  return res.rows[0];
}

async function filterEvents({ dateFrom, dateTo, location, category }) {
  const pool = getPool();
  let query = `SELECT * FROM events WHERE 1=1`;
  const params = [];
  let idx = 1;
  if (dateFrom) {
    query += ` AND date >= $${idx++}`;
    params.push(dateFrom);
  }
  if (dateTo) {
    query += ` AND date <= $${idx++}`;
    params.push(dateTo);
  }
  if (location) {
    query += ` AND location ILIKE $${idx++}`;
    params.push(`%${location}%`);
  }
  if (category) {
    query += ` AND category ILIKE $${idx++}`;
    params.push(`%${category}%`);
  }
  query += ` ORDER BY date ASC`;
  const res = await pool.query(query, params);
  return res.rows;
}

async function decrementCapacityIfAvailable(eventId) {
  const pool = getPool();
  // Use transaction to avoid race conditions
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    const r = await client.query(`SELECT capacity, id FROM events WHERE id=$1 FOR UPDATE`, [eventId]);
    if (r.rowCount === 0) throw new Error('Event not found');
    const event = r.rows[0];
    if (event.capacity <= 0) {
      await client.query('ROLLBACK');
      return false;
    }
    await client.query(`UPDATE events SET capacity = capacity - 1 WHERE id = $1`, [eventId]);
    await client.query('COMMIT');
    return true;
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}

async function incrementCapacity(eventId) {
  const pool = getPool();
  await pool.query(`UPDATE events SET capacity = capacity + 1 WHERE id = $1`, [eventId]);
  return true;
}

async function getRemainingCapacity(eventId) {
  const pool = getPool();
  const res = await pool.query(`SELECT capacity FROM events WHERE id = $1`, [eventId]);
  if (res.rowCount === 0) return null;
  return res.rows[0].capacity;
}

module.exports = {
  createEvent,
  updateEvent,
  deleteEvent,
  getEvents,
  getEventById,
  filterEvents,
  decrementCapacityIfAvailable,
  incrementCapacity,
  getRemainingCapacity
};
