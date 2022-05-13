import 'package:hive_flutter/hive_flutter.dart';
part 'book_type.g.dart';

@HiveType(typeId : 0)
enum BookType{
  @HiveField(0)
  unknown,

  @HiveField(1)
  epub,

  @HiveField(2)
  pdf,
}