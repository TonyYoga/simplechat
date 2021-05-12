import 'User.dart';
import 'package:hive/hive.dart';

part 'HistoryItem.g.dart';

@HiveType(typeId: 0)
class HistoryItem extends HiveObject{
  @HiveField(0)
  late User user;
  @HiveField(1)
  late DateTime dateTimeUts;
  @HiveField(2)
  late String message;

  // HistoryItem(this.user, this.dateTimeUts, this.message);
}