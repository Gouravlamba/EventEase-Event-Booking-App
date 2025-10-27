const { format } = require('date-fns');

function random3() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let res = '';
  for (let i = 0; i < 3; i++) res += chars.charAt(Math.floor(Math.random() * chars.length));
  return res;
}

function generateBookingId(date = new Date()) {
  const MMM = format(date, 'MMM').toUpperCase(); // e.g., SEP
  const YYYY = format(date, 'yyyy');
  return `BKG-${MMM}${YYYY}-${random3()}`;
}

module.exports = { generateBookingId };
