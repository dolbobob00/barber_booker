import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Settings {
  @HiveField(0)
  bool isLight = true;
}
