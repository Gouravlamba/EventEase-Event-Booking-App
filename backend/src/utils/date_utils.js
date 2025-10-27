const { format, isToday, isFuture, isPast } = require('date-fns');

function formatDate(date) {
  try {
    return format(new Date(date), 'dd-MMM-yyyy');
  } catch (e) {
    return date;
  }
}

function getEventStatus(date) {
  const d = new Date(date);
  if (isToday(d)) return 'Ongoing';
  if (isFuture(d)) return 'Upcoming';
  if (isPast(d)) return 'Completed';
  return 'Unknown';
}

module.exports = { formatDate, getEventStatus };
