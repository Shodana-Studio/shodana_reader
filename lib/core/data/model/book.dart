import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import 'reading_stats.dart';

enum BookType{epub, pdf, unknown}

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
  final String userId;
  final String fileId;

  final BookType bookType;

  final String? title;
  final DateTime? titleLastModDate;

  final String? author;
  final DateTime? authorLastModDate;

  final String? description;
  final DateTime? descriptionLastModDate;

  final int? readingProgress;
  final DateTime? readingProgressLastModDate;

  final String? publisher;
  final DateTime? publisherLastModDate;

  final DateTime? publishedDate;
  final DateTime? publishedDateLastModDate;

  final DateTime createdDate;

  final DateTime? startReadingDate;
  final DateTime? startReadingDateLastModDate;

  final DateTime? finishReadingDate;
  final DateTime? finishReadingDateLastModDate;

  final dynamic metadata;
  final DateTime? metadataLastModDate;

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
