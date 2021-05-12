import 'package:hive/hive.dart';

part 'Word.g.dart';

@HiveType(typeId: 2)
class Word extends HiveObject{
  @HiveField(0)
  late String word;
  @HiveField(1)
  late int count;
}