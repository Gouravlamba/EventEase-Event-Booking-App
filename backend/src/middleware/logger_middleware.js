// This middleware logs booking attempts and cancellations with user id + timestamp.
// It doesn't persist booking success/failure (the booking service writes to booking_logs).
module.exports = function (req, res, next) {
  // Only log booking creation/cancel endpoints (we use this middleware only on those routes)
  const user = req.user ? req.user.id : 'anonymous';
  console.log(`[BOOKING LOG] user=${user} endpoint=${req.originalUrl} method=${req.method} time=${new Date().toISOString()}`);
  next();
};
