
import 'package:hive/hive.dart';
import 'package:simplechat/model/HistoryItem.dart';
import 'package:simplechat/model/User.dart';
import 'package:simplechat/model/Word.dart';

class Boxes {
  static Box<User> getUsers () => Hive.box<User>('users');
  static Box<Word> getWords () => Hive.box<Word>('words');
  static Box<HistoryItem> getHistory () => Hive.box<HistoryItem>('history');
}