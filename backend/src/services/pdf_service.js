const PDFDocument = require('pdfkit');
const getStream = require('get-stream'); // note: not in package.json - we'll instead return buffer manually

// simple PDF generation, returns Buffer
async function generateBookingPdf({ bookingId, event, userId }) {
  try {
    const doc = new PDFDocument();
    const chunks = [];
    doc.on('data', (chunk) => chunks.push(chunk));
    doc.on('end', () => {});
    doc.fontSize(20).text('Booking Confirmation', { align: 'center' });
    doc.moveDown();
    doc.fontSize(12).text(`Booking ID: ${bookingId}`);
    doc.text(`Event: ${event.title}`);
    doc.text(`Date: ${new Date(event.date).toDateString()}`);
    doc.text(`Location: ${event.location}`);
    doc.text(`User ID: ${userId}`);
    doc.end();

    // Wait for buffer
    await new Promise(resolve => doc.on('end', resolve));
    const buffer = Buffer.concat(chunks);
    return buffer;
  } catch (err) {
    console.error('PDF generation error', err);
    return null;
  }
}

module.exports = { generateBookingPdf };
