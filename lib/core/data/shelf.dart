import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'shelf.g.dart';

@HiveType(typeId : 20)
class Shelf extends Equatable {
  // Constructors
  const Shelf({
    this.id,
    this.userId,
    this.title,
    this.createdDate,
    required this.lastModifiedDate,
    this.description,
    this.startReadingDate,
    this.finishReadingDate,
    // this.books,
  });

  factory Shelf.fromMap(Map<String, dynamic> map) {
    return Shelf(
      id: map[r'$id'],
      userId: map['userId'],
      title: map['title'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
      description: map['description'],
      startReadingDate: DateTime.fromMillisecondsSinceEpoch(map['startReadingDate']),
      finishReadingDate: DateTime.fromMillisecondsSinceEpoch(map['finishReadingDate']),
    );
  }

  factory Shelf.fromJson(String source) => Shelf.fromMap(json.decode(source));

  // Variables
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? userId;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final DateTime? createdDate;

  /// The time the object was last updated. It is required when updating a document on the appwrite database.
  @HiveField(4)
  final DateTime lastModifiedDate;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final DateTime? startReadingDate;
  
  @HiveField(7)
  final DateTime? finishReadingDate;

  // Utility Functions
  Shelf copyWith({
    String? id,
    String? userId,
    String? title,
    DateTime? createdDate,
    DateTime? lastModifiedDate,
    String? description,
    DateTime? startReadingDate,
    DateTime? finishReadingDate,
    // List<Book>? books,
  }) {
    return Shelf(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      createdDate: createdDate ?? this.createdDate,
      description: description ?? this.description,
      startReadingDate: startReadingDate ?? this.startReadingDate,
      finishReadingDate: finishReadingDate ?? this.finishReadingDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      // books: books ?? this.books,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      r'$id': id,
      'userId': userId,
      'title': title,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'description': description,
      'startReadingDate': startReadingDate?.millisecondsSinceEpoch,
      'finishReadingDate': finishReadingDate?.millisecondsSinceEpoch,
      // 'books': books?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  // Overrides
  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id ?? 'No ID',
      userId ?? 'No User ID',
      title ?? 'No Title',
      createdDate ?? 'No Shelf Created Date',
      lastModifiedDate,
      description ?? 'No Description',
      startReadingDate ?? 'No Started Reading Date',
      finishReadingDate ?? 'No Finished Reading Date',
    ];
  }
}
