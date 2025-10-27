module.exports = {
  JWT_SECRET: process.env.JWT_SECRET || 'replace_this_with_strong_secret',
  JWT_EXPIRES_IN: process.env.JWT_EXPIRES_IN || '7d'
};
