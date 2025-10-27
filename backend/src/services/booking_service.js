const bookingModel = require('../models/booking_model');
const eventModel = require('../models/event_model');
const { generateBookingId } = require('../utils/booking_id_generator');
const { formatISO } = require('date-fns');
const pdfService = require('./pdf_service');

async function createBooking({ userId, eventId }) {
  // check event exists
  const ev = await eventModel.getEventById(eventId);
  if (!ev) throw new Error('Event not found');

  // check if event already started or passed
  const now = new Date();
  const evDate = new Date(ev.date);
  if (evDate < new Date(now.toDateString())) { // event passed
    throw new Error('Cannot book past events');
  }

  // check user already booked
  const already = await bookingModel.userHasBookingForEvent(userId, eventId);
  if (already) throw new Error('User already has a booking for this event');

  // attempt to decrement capacity atomically
  const ok = await eventModel.decrementCapacityIfAvailable(eventId);
  if (!ok) throw new Error('Event is full');

  // create booking record
  const bookingId = generateBookingId();
  const created_at = formatISO(new Date());
  const booking = await bookingModel.createBooking({ booking_id: bookingId, user_id: userId, event_id: eventId, created_at });

  // log booking action
  await bookingModel.logBookingAction({ user_id: userId, booking_id: bookingId, action: 'created', timestamp: created_at });

  // optionally generate PDF confirmation (returns buffer path)
  const pdfBuffer = await pdfService.generateBookingPdf({
    bookingId,
    event: ev,
    userId
  });

  // return booking plus maybe base64/pdf path
  return { booking, confirmationPdf: pdfBuffer ? 'pdf-buffer' : null, bookingId };
}

async function cancelBooking({ userId, bookingId }) {
  // find booking
  const booking = await bookingModel.findBookingById(bookingId);
  if (!booking) throw new Error('Booking not found');
  if (booking.user_id !== userId) throw new Error('Not authorized to cancel this booking');

  // check event not started
  const ev = await eventModel.getEventById(booking.event_id);
  const now = new Date();
  const evDate = new Date(ev.date);
  if (evDate <= new Date(now.toDateString())) {
    throw new Error('Cannot cancel booking for event that has started or passed');
  }

  // delete booking record
  await bookingModel.deleteBooking(bookingId);

  // increment capacity back
  await eventModel.incrementCapacity(booking.event_id);

  // log cancel
  await bookingModel.logBookingAction({ user_id: userId, booking_id: bookingId, action: 'cancelled', timestamp: new Date().toISOString() });

  return { cancelled: true };
}

module.exports = { createBooking, cancelBooking };
