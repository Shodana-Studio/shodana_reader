import 'dart:convert';

import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    this.title,
    this.author,
    this.description,
    required this.filename,
    this.publisher,
    this.publishedDate,
    required this.createdDate,
    this.startReadingDate,
    this.finishReadingDate,
    this.readingProgress,
    required this.userId,
    this.metadata,
    this.readingTimes,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'],
      author: map['author'],
      description: map['description'],
      filename: map['filename'],
      publisher: map['publisher'],
      publishedDate: DateTime.fromMillisecondsSinceEpoch(map['publishedDate']),
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      startReadingDate: DateTime.fromMillisecondsSinceEpoch(map['startReadingDate']),
      finishReadingDate: DateTime.fromMillisecondsSinceEpoch(map['finishReadingDate']),
      readingProgress: map['readingProgress'],
      userId: map['userId'],
      metadata: map['metadata'],
      readingTimes: List<String>.from(map['readingTimes']),
    );
  }

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  final String? title;
  final String? author;
  final String? description;
  final String filename;
  final String? publisher;
  final DateTime? publishedDate;
  final DateTime createdDate;
  final DateTime? startReadingDate;
  final DateTime? finishReadingDate;
  final int? readingProgress;
  final String userId;
  final dynamic metadata;
  final List<String>? readingTimes;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'filename': filename,
      'publisher': publisher,
      'publishedDate': publishedDate?.millisecondsSinceEpoch,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'startReadingDate': startReadingDate?.millisecondsSinceEpoch,
      'finishReadingDate': finishReadingDate?.millisecondsSinceEpoch,
      'readingProgress': readingProgress,
      'userId': userId,
      'metadata': metadata,
      'readingTimes': readingTimes,
    };
  }

  String toJson() => json.encode(toMap());

  Book copyWith({
    String? title,
    String? author,
    String? description,
    String? filename,
    String? publisher,
    DateTime? publishedDate,
    DateTime? createdDate,
    DateTime? startReadingDate,
    DateTime? finishReadingDate,
    int? readingProgress,
    String? userId,
    dynamic? metadata,
    List<String>? readingTimes,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      filename: filename ?? this.filename,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      createdDate: createdDate ?? this.createdDate,
      startReadingDate: startReadingDate ?? this.startReadingDate,
      finishReadingDate: finishReadingDate ?? this.finishReadingDate,
      readingProgress: readingProgress ?? this.readingProgress,
      userId: userId ?? this.userId,
      metadata: metadata ?? this.metadata,
      readingTimes: readingTimes ?? this.readingTimes,
    );
  }

  @override
  List<Object> get props {
    return [
      title ?? '',
      author ?? '',
      description ?? '',
      filename,
      publisher ?? '',
      publishedDate ?? DateTime.now(),
      createdDate,
      startReadingDate ?? DateTime.now(),
      finishReadingDate ?? DateTime.now(),
      readingProgress ?? 0,
      userId,
      metadata ?? {},
      readingTimes ?? '',
    ];
  }

  @override
  bool get stringify => true;
}
