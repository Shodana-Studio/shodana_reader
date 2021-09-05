// ignore_for_file: sort_constructors_first
import 'dart:convert';
import 'dart:io' as io;

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../service/storage_util.dart';
import 'book_type.dart';

part 'book.g.dart';

@HiveType(typeId : 10)
class Book extends Equatable {
  // Constructors
  const Book({
    this.id,
    this.userId,
    this.fileId,
    this.localStorageId,
    this.bookType = BookType.unknown,
    this.title,
    this.author,
    this.description,
    this.readingProgress,
    this.publisher,
    this.publishedDate,
    this.createdDate,
    required this.lastModifiedDate, 
    this.startReadingDate,
    this.finishReadingDate,
    this.metadata,
    this.shelfIds,
  });
  
  // Variables
  /// Do not include the document id in the book object when using the update appwrite method or when creating a document
  /// Only assign id when the document is downloaded from the appwrite database
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? userId;
  @HiveField(2)
  final String? fileId;
  /// This should always be assigned when uploading a document to the appwrite database. 
  /// It should not be included if using the modification method.
  @HiveField(3)
  final String? localStorageId;

  @HiveField(4)
  final BookType bookType;

  @HiveField(5)
  final String? title;
  @HiveField(6)
  final String? author;
  @HiveField(7)
  final String? description;

  @HiveField(8)
  final int? readingProgress;

  @HiveField(9)
  final String? publisher;
  @HiveField(10)
  final DateTime? publishedDate;

  /// Date and time the file was uploaded to the app
  @HiveField(11)
  final DateTime? createdDate;
  /// The time the object was last updated. It is required when updating a document on the appwrite database.
  @HiveField(12)
  final DateTime lastModifiedDate;

  @HiveField(13)
  final DateTime? startReadingDate;
  @HiveField(14)
  final DateTime? finishReadingDate;

  @HiveField(15)
  final dynamic metadata;

  @HiveField(16)
  final List<String>? shelfIds;

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
      id ?? 'No id',
      userId ?? 'No User ID',
      fileId ?? 'No File ID',
      localStorageId ?? 'No Local Storage ID',
      bookType,
      title ?? 'No Title',
      author ?? 'No Author',
      description ?? 'No Description',
      readingProgress ?? 'No Reading Progress Set',
      publisher ?? 'No Publisher',
      publishedDate ?? 'No Published Date',
      createdDate ?? 'No Document Creation Date',
      lastModifiedDate,
      startReadingDate ?? 'No Started Reading Date',
      finishReadingDate ?? 'No Finished Reading Date',
      metadata ?? 'No metadata',
      shelfIds ?? 'Not associated with any shelves',
    ];
  }

  Book copyWith({
    String? id,
    String? userId,
    String? fileId,
    String? localStorageId,
    BookType? bookType,
    String? title,
    String? author,
    String? description,
    int? readingProgress,
    String? publisher,
    DateTime? publishedDate,
    DateTime? createdDate,
    DateTime? lastModifiedDate,
    DateTime? startReadingDate,
    DateTime? finishReadingDate,
    dynamic metadata,
    List<String>? shelfIds,
  }) {
    return Book(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fileId: fileId ?? this.fileId,
      localStorageId: localStorageId ?? this.localStorageId,
      bookType: bookType ?? this.bookType,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      readingProgress: readingProgress ?? this.readingProgress,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      startReadingDate: startReadingDate ?? this.startReadingDate,
      finishReadingDate: finishReadingDate ?? this.finishReadingDate,
      metadata: metadata ?? this.metadata,
      shelfIds: shelfIds ?? this.shelfIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      r'$id': id,
      'userId': userId,
      'fileId': fileId,
      'localStorageId': localStorageId,
      'bookType': EnumToString.convertToString(bookType),
      'title': title,
      'author': author,
      'description': description,
      'readingProgress': readingProgress,
      'publisher': publisher,
      'publishedDate': publishedDate?.millisecondsSinceEpoch,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'lastModifiedDate': lastModifiedDate.millisecondsSinceEpoch,
      'startReadingDate': startReadingDate?.millisecondsSinceEpoch,
      'finishReadingDate': finishReadingDate?.millisecondsSinceEpoch,
      'metadata': metadata,
      'shelfIds': shelfIds,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map[r'$id'],
      userId: map['userId'],
      fileId: map['fileId'],
      localStorageId: map['localStorageId'],
      bookType: EnumToString.fromString(BookType.values, map['bookType']) ?? BookType.unknown,
      title: map['title'],
      author: map['author'],
      description: map['description'],
      readingProgress: map['readingProgress'],
      publisher: map['publisher'],
      publishedDate: DateTime.fromMillisecondsSinceEpoch(map['publishedDate']),
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
      startReadingDate: DateTime.fromMillisecondsSinceEpoch(map['startReadingDate']),
      finishReadingDate: DateTime.fromMillisecondsSinceEpoch(map['finishReadingDate']),
      metadata: map['metadata'],
      shelfIds: List<String>.from(map['shelfIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
