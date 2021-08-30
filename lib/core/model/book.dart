import 'dart:convert';
import 'dart:io' as io;

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../service/storage_util.dart';

import 'book_type.dart';
part 'book.g.dart';

@HiveType(typeId : 2)
class Book extends Equatable {
  // Constructors
  const Book({
    this.id,
    required this.userId,
    this.fileId,
    required this.localStorageId,
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
    required this.shelfIds,
    required this.shelfIdsLastModDate
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map[r'$id'],
      userId: map['userId'],
      fileId: map['fileId'],
      localStorageId: map['localStorageId'],
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
      // readingTimes: List<ReadingStats>.from((map['readingTimes'] as List<Map<String, ReadingStats>>).map((x) => ReadingStats.fromMap(x))),
      shelfIds: map['shelfIds'],
      shelfIdsLastModDate: map['shelfIdsLastModDate'],
    );
  }

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
  
  // Variables
  @HiveField(25)
  final String? id;
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String? fileId;
  @HiveField(26)
  final String localStorageId;

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

  // Removed from database, instead replaced with reference to book id in each ReadingStats document. This is because duplicate data will be stored locally with hive
  // Replaced with shelfIds, do not reuse HiveField 22
  // @HiveField(22)
  // final List<ReadingStats>? readingTimes;

  @HiveField(23)
  final List<String> shelfIds;
  @HiveField(24)
  final DateTime shelfIdsLastModDate;

  Map<String, dynamic> toMap() {
    return {
      r'$id': id,
      'userId': userId,
      'fileId': fileId,
      'localStorageId': localStorageId,
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
      // Replaced with shelfIds
      // 'readingTimes': readingTimes?.map((x) => x.toMap()).toList(),
      'shelfIds': shelfIds,
      'shelfIdsLastModDate': shelfIdsLastModDate.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  Book copyWith({
    String? id,
    String? fileId,
    String? localStorageId,
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
    // Replaced with shelfIds
    // List<ReadingStats>? readingTimes,
    // TODO: When deleting a shelf, all books must be removed from it first
    List<String>? shelfIds,
    DateTime? shelfIdsLastModDate,
  }) {
    return Book(
      id: id ?? this.id,
      userId: userId,
      fileId: fileId ?? this.fileId,
      localStorageId: localStorageId ?? this.localStorageId,
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
      // Replaced with shelfIds
      // readingTimes: readingTimes ?? this.readingTimes,
      shelfIds: shelfIds ?? this.shelfIds,
      shelfIdsLastModDate: shelfIdsLastModDate ?? this.shelfIdsLastModDate,
    );
  }

  /// Gets the path to the epub file.
  /// Ex: Documents/ShodanaReader/123456789/123456789
  Future<io.Directory> get bookPath async {
    final io.Directory dir = await StorageUtil.getAppDirectory();
    return io.Directory('${dir.path}/ShodanaReader/$localStorageId/$localStorageId');
  }

  /// Gets the path to the cover image.
  /// Ex: Documents/ShodanaReader/123456789/123456789
  Future<io.Directory> get imagePath async {
    final io.Directory dir = await StorageUtil.getAppDirectory();
    return io.Directory('${dir.path}/ShodanaReader/$localStorageId/cover.png');
  }

  /// Gets the path to the directory the epub and cover image is in.
  /// Ex: Documents/ShodanaReader/123456789
  Future<io.Directory> get bookDirectoryPath async {
    final io.Directory dir = await StorageUtil.getAppDirectory();
    return io.Directory('${dir.path}/ShodanaReader/$localStorageId');
  }

  // Overrides
  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      // id is generated by Appwrite once it is uploaded, it cannot be created client side
      // It will be null it if it not uploaded. In that case, use a unique key for the
      // widget if needed.
      id ?? 'Not uploaded',
      userId,
      bookType,
      // fileId should be unique to the book and given by appwrite storage
      fileId ?? '',
      // The id used to identify what folder the book is stored in
      localStorageId,
      // Commented out createdDate so that if a book is uploaded twice, it will recognize it as a duplicate
      // createdDate,
    ];
  }
}
