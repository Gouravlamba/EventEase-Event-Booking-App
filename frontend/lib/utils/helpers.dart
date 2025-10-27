import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final formatter = DateFormat('dd-MMM-yyyy');
  return formatter.format(date);
}
