import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'reading_stats.g.dart';

@HiveType(typeId : 1)
class ReadingStats extends Equatable {
  const ReadingStats({
    this.id,
    required this.date,
    required this.timeRead,
    required this.userId,
    required this.bookId,
  });

  factory ReadingStats.fromMap(Map<String, dynamic> map) {
    return ReadingStats(
      id: map[r'$id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      timeRead: map['timeRead'],
      userId: map['userId'],
      bookId: map['bookId'],
    );
  }

  factory ReadingStats.fromJson(String source) => ReadingStats.fromMap(json.decode(source));

  @HiveField(4)
  final String? id;
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final int timeRead;
  @HiveField(2)
  final String userId;
  @HiveField(3)
  final String bookId;

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'timeRead': timeRead,
      'userId': userId,
      'bookId': bookId,
    };
  }

  String toJson() => json.encode(toMap());

  ReadingStats copyWith({
    DateTime? date,
    int? timeRead,
    String? userId,
    String? bookId,
  }) {
    return ReadingStats(
      id: id,
      date: date ?? this.date,
      timeRead: timeRead ?? this.timeRead,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
    );
  }

  @override
  List<Object> get props => [id ?? '', date, timeRead, userId, bookId];
}
