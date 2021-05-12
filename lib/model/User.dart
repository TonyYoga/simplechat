import 'package:hive/hive.dart';

part 'User.g.dart';
@HiveType(typeId: 1)
class User {
  @HiveField(0)
  late String name;

}