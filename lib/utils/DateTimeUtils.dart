import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;



extension DateTimeUtils on Timestamp {

  DateTime get convertFrom =>
     DateTime.fromMicrosecondsSinceEpoch(this.microsecondsSinceEpoch, isUtc: true);

}