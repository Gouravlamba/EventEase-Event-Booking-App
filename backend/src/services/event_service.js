// Thin wrapper - we already use event_model directly in routes, but keep this for tests/extensibility.
const eventModel = require('../models/event_model');

async function listEvents() {
  return eventModel.getEvents();
}

module.exports = { listEvents };
