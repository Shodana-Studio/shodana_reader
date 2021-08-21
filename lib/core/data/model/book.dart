import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'book_type.dart';
import 'reading_stats.dart';
part 'book.g.dart';

@HiveType(typeId : 2)
class Book extends Equatable {
  // Constructors
  const Book({
    required this.userId,
    required this.fileId,
    required this.bookType,
    this.title,
    this.titleLastModDate,
    this.author,
    this.authorLastModDate,
    this.description,
    this.descriptionLastModDate,
    this.readingProgress,
    this.readingProgressLastModDate,
    this.publisher,
    this.publisherLastModDate,
    this.publishedDate,
    this.publishedDateLastModDate,
    required this.createdDate,
    this.startReadingDate,
    this.startReadingDateLastModDate,
    this.finishReadingDate,
    this.finishReadingDateLastModDate,
    this.metadata,
    this.metadataLastModDate,
    this.readingTimes,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      userId: map['userId'],
      fileId: map['fileId'],
      bookType: EnumToString.fromString(BookType.values, map['bookType']) ?? BookType.unknown,
      title: map['title'],
      titleLastModDate: DateTime.fromMillisecondsSinceEpoch(map['titleLastModDate']),
      author: map['author'],
      authorLastModDate: DateTime.fromMillisecondsSinceEpoch(map['authorLastModDate']),
      description: map['description'],
      descriptionLastModDate: DateTime.fromMillisecondsSinceEpoch(map['descriptionLastModDate']),
      readingProgress: map['readingProgress'],
      readingProgressLastModDate: DateTime.fromMillisecondsSinceEpoch(map['readingProgressLastModDate']),
      publisher: map['publisher'],
      publisherLastModDate: DateTime.fromMillisecondsSinceEpoch(map['publisherLastModDate']),
      publishedDate: DateTime.fromMillisecondsSinceEpoch(map['publishedDate']),
      publishedDateLastModDate: DateTime.fromMillisecondsSinceEpoch(map['publishedDateLastModDate']),
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      startReadingDate: DateTime.fromMillisecondsSinceEpoch(map['startReadingDate']),
      startReadingDateLastModDate: DateTime.fromMillisecondsSinceEpoch(map['startReadingDateLastModDate']),
      finishReadingDate: DateTime.fromMillisecondsSinceEpoch(map['finishReadingDate']),
      finishReadingDateLastModDate: DateTime.fromMillisecondsSinceEpoch(map['finishReadingDateLastModDate']),
      metadata: map['metadata'],
      metadataLastModDate: DateTime.fromMillisecondsSinceEpoch(map['metadataLastModDate']),
      readingTimes: List<ReadingStats>.from((map['readingTimes'] as List<Map<String, ReadingStats>>).map((x) => ReadingStats.fromMap(x))),
    );
  }

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
  
  // Variables
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String fileId;

  @HiveField(2)
  final BookType bookType;

  @HiveField(3)
  final String? title;
  @HiveField(4)
  final DateTime? titleLastModDate;

  @HiveField(5)
  final String? author;
  @HiveField(6)
  final DateTime? authorLastModDate;

  @HiveField(7)
  final String? description;
  @HiveField(8)
  final DateTime? descriptionLastModDate;

  @HiveField(9)
  final int? readingProgress;
  @HiveField(10)
  final DateTime? readingProgressLastModDate;

  @HiveField(11)
  final String? publisher;
  @HiveField(12)
  final DateTime? publisherLastModDate;

  @HiveField(13)
  final DateTime? publishedDate;
  @HiveField(14)
  final DateTime? publishedDateLastModDate;

  /// Date and time the file was uploaded to the app
  @HiveField(15)
  final DateTime createdDate;

  @HiveField(16)
  final DateTime? startReadingDate;
  @HiveField(17)
  final DateTime? startReadingDateLastModDate;

  @HiveField(18)
  final DateTime? finishReadingDate;
  @HiveField(19)
  final DateTime? finishReadingDateLastModDate;

  @HiveField(20)
  final dynamic metadata;
  @HiveField(21)
  final DateTime? metadataLastModDate;

  @HiveField(22)
  final List<ReadingStats>? readingTimes;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fileId': fileId,
      'bookType': EnumToString.convertToString(bookType),
      'title': title,
      'titleLastModDate': titleLastModDate?.millisecondsSinceEpoch,
      'author': author,
      'authorLastModDate': authorLastModDate?.millisecondsSinceEpoch,
      'description': description,
      'descriptionLastModDate': descriptionLastModDate?.millisecondsSinceEpoch,
      'readingProgress': readingProgress,
      'readingProgressLastModDate': readingProgressLastModDate?.millisecondsSinceEpoch,
      'publisher': publisher,
      'publisherLastModDate': publisherLastModDate?.millisecondsSinceEpoch,
      'publishedDate': publishedDate?.millisecondsSinceEpoch,
      'publishedDateLastModDate': publishedDateLastModDate?.millisecondsSinceEpoch,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'startReadingDate': startReadingDate?.millisecondsSinceEpoch,
      'startReadingDateLastModDate': startReadingDateLastModDate?.millisecondsSinceEpoch,
      'finishReadingDate': finishReadingDate?.millisecondsSinceEpoch,
      'finishReadingDateLastModDate': finishReadingDateLastModDate?.millisecondsSinceEpoch,
      'metadata': metadata,
      'metadataLastModDate': metadataLastModDate?.millisecondsSinceEpoch,
      'readingTimes': readingTimes?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  Book copyWith({
    String? fileId,
    BookType? bookType,
    String? title,
    DateTime? titleLastModDate,
    String? author,
    DateTime? authorLastModDate,
    String? description,
    DateTime? descriptionLastModDate,
    int? readingProgress,
    DateTime? readingProgressLastModDate,
    String? publisher,
    DateTime? publisherLastModDate,
    DateTime? publishedDate,
    DateTime? publishedDateLastModDate,
    DateTime? createdDate,
    DateTime? startReadingDate,
    DateTime? startReadingDateLastModDate,
    DateTime? finishReadingDate,
    DateTime? finishReadingDateLastModDate,
    dynamic metadata,
    DateTime? metadataLastModDate,
    List<ReadingStats>? readingTimes,
  }) {
    return Book(
      userId: userId,
      fileId: fileId ?? this.fileId,
      bookType: bookType ?? this.bookType,
      title: title ?? this.title,
      titleLastModDate: titleLastModDate ?? this.titleLastModDate,
      author: author ?? this.author,
      authorLastModDate: authorLastModDate ?? this.authorLastModDate,
      description: description ?? this.description,
      descriptionLastModDate: descriptionLastModDate ?? this.descriptionLastModDate,
      readingProgress: readingProgress ?? this.readingProgress,
      readingProgressLastModDate: readingProgressLastModDate ?? this.readingProgressLastModDate,
      publisher: publisher ?? this.publisher,
      publisherLastModDate: publisherLastModDate ?? this.publisherLastModDate,
      publishedDate: publishedDate ?? this.publishedDate,
      publishedDateLastModDate: publishedDateLastModDate ?? this.publishedDateLastModDate,
      createdDate: createdDate ?? this.createdDate,
      startReadingDate: startReadingDate ?? this.startReadingDate,
      startReadingDateLastModDate: startReadingDateLastModDate ?? this.startReadingDateLastModDate,
      finishReadingDate: finishReadingDate ?? this.finishReadingDate,
      finishReadingDateLastModDate: finishReadingDateLastModDate ?? this.finishReadingDateLastModDate,
      metadata: metadata ?? this.metadata,
      metadataLastModDate: metadataLastModDate ?? this.metadataLastModDate,
      readingTimes: readingTimes ?? this.readingTimes,
    );
  }

  // Overrides
  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      userId,
      bookType,
      // fileId should be unique to the book and determined by contents of the file metadata
      fileId,
      // Commented out createdDate so that if a book is uploaded twice, it will recognize it as a duplicate
      // createdDate,
    ];
  }
}
