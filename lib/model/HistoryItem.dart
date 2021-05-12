import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryItem{
  late String user;
  late Timestamp dateTimeUts;
  late String message;

  HistoryItem({required this.user, required this.dateTimeUts, required this.message});
}