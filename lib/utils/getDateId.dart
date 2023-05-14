import 'package:cloud_firestore/cloud_firestore.dart';

String getDateId() {
  final date = Timestamp.now().toDate();
  return '${date.day}-${date.month}-${date.year}';
}

String getDateIdFromDate(DateTime date) {
  return '${date.day}-${date.month}-${date.year}';
}
