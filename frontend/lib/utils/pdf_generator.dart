import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfGenerator {
  static Future<String> generateBookingPdf(String eventTitle, String userName, String date) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Booking Confirmation\nEvent: $eventTitle\nUser: $userName\nDate: $date'),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/booking_$eventTitle.pdf');
    await file.writeAsBytes(await pdf.save());
    return file.path; 
  }
}
