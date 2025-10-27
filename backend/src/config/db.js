const { Pool } = require('pg');

let pool;

function initDb() {
  if (pool) return pool;
  pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    // optionally add ssl if needed
    // ssl: { rejectUnauthorized: false }
  });

  pool.on('error', (err) => {
    console.error('Unexpected PG client error', err);
    process.exit(-1);
  });

  console.log('Postgres pool created.');
  return pool;
}

function getPool() {
  if (!pool) initDb();
  return pool;
}

module.exports = { initDb, getPool };
