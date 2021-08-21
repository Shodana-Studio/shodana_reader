import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'reading_stats.g.dart';

@HiveType(typeId : 1)
class ReadingStats extends Equatable {
  const ReadingStats({
    required this.date,
    required this.timeRead,
    required this.userId,
  });

  factory ReadingStats.fromMap(Map<String, dynamic> map) {
    return ReadingStats(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      timeRead: map['timeRead'],
      userId: map['userId'],
    );
  }

  factory ReadingStats.fromJson(String source) => ReadingStats.fromMap(json.decode(source));

  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final int timeRead;
  @HiveField(2)
  final String userId;

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'timeRead': timeRead,
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());

  ReadingStats copyWith({
    DateTime? date,
    int? timeRead,
    String? userId,
  }) {
    return ReadingStats(
      date: date ?? this.date,
      timeRead: timeRead ?? this.timeRead,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object> get props => [date, timeRead, userId];
}
