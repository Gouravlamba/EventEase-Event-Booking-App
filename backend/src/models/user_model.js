const { getPool } = require('../config/db');
const bcrypt = require('bcrypt');

const SALT_ROUNDS = 10;

async function createUser({ name, email, password, role = 'user' }) {
  const pool = getPool();
  const hashed = await bcrypt.hash(password, SALT_ROUNDS);
  const result = await pool.query(
    `INSERT INTO users (name, email, password, role, created_at)
     VALUES ($1, $2, $3, $4, now()) RETURNING id, name, email, role, created_at`,
    [name, email, hashed, role]
  );
  return result.rows[0];
}

async function findByEmail(email) {
  const pool = getPool();
  const result = await pool.query(`SELECT * FROM users WHERE email = $1`, [email]);
  return result.rows[0];
}

async function findById(id) {
  const pool = getPool();
  const result = await pool.query(`SELECT id, name, email, role, created_at FROM users WHERE id = $1`, [id]);
  return result.rows[0];
}

async function validatePassword(plain, hashed) {
  return bcrypt.compare(plain, hashed);
}

module.exports = { createUser, findByEmail, findById, validatePassword };
