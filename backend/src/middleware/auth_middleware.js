const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../config/jwt_config');
const { findById } = require('../models/user_model');

module.exports = async function (req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: 'Missing Authorization header' });
  const parts = authHeader.split(' ');
  if (parts.length !== 2) return res.status(401).json({ error: 'Invalid Authorization header' });
  const token = parts[1];
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    // attach user minimal info to req
    const user = await findById(payload.id);
    if (!user) return res.status(401).json({ error: 'Invalid token user' });
    req.user = { id: user.id, role: user.role, email: user.email, name: user.name };
    next();
  } catch (err) {
    console.error(err);
    return res.status(401).json({ error: 'Invalid token' });
  }
};
