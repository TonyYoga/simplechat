
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplechat/model/HistoryItem.dart';
import 'package:simplechat/model/User.dart';
import 'package:simplechat/model/Word.dart';

class Boxes {
  static Box<User> getUsers () => Hive.box<User>('users');
  // static Box getWords () => Hive.box('words');
  static Box<Word> getWords () => Hive.box<Word>('words');
  static Box<HistoryItem> getHistory () => Hive.box<HistoryItem>('history');
}