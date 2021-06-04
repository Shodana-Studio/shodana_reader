import 'dart:convert';

import 'package:equatable/equatable.dart';

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

  final DateTime date;
  final int timeRead;
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
