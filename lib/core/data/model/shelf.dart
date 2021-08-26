import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'shelf.g.dart';

@HiveType(typeId : 3)
class Shelf extends Equatable {
  // Constructors
  const Shelf({
    this.id,
    required this.userId,
    required this.title,
    required this.titleLastModDate,
    required this.createdDate,
    this.description,
    this.descriptionLastModDate,
    this.startReadingDate,
    this.startReadingDateLastModDate,
    this.finishReadingDate,
    this.finishReadingDateLastModDate,
    // this.books,
  });

  factory Shelf.fromMap(Map<String, dynamic> map) {
    return Shelf(
      id: map[r'$id'],
      userId: map['userId'],
      title: map['title'],
      titleLastModDate: DateTime.fromMillisecondsSinceEpoch(map['titleLastModDate']),
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      description: map['description'],
      descriptionLastModDate: DateTime.fromMillisecondsSinceEpoch(map['descriptionLastModDate']),
      startReadingDate: DateTime.fromMillisecondsSinceEpoch(map['startReadingDate']),
      startReadingDateLastModDate: DateTime.fromMillisecondsSinceEpoch(map['startReadingDateLastModDate']),
      finishReadingDate: DateTime.fromMillisecondsSinceEpoch(map['finishReadingDate']),
      finishReadingDateLastModDate: DateTime.fromMillisecondsSinceEpoch(map['finishReadingDateLastModDate']),
      // books: List<Book>.from((map['books'] as List<Map<String, Book>>).map((x) => Book.fromMap(x))),
    );
  }

  factory Shelf.fromJson(String source) => Shelf.fromMap(json.decode(source));

  // Variables
  @HiveField(10)
  final String? id;
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime titleLastModDate;

  @HiveField(3)
  final DateTime createdDate;

  @HiveField(4)
  final String? description;
  @HiveField(5)
  final DateTime? descriptionLastModDate;

  @HiveField(6)
  final DateTime? startReadingDate;
  @HiveField(7)
  final DateTime? startReadingDateLastModDate;
  
  @HiveField(8)
  final DateTime? finishReadingDate;
  @HiveField(9)
  final DateTime? finishReadingDateLastModDate;

  // Removed from database, instead replaced with reference to shelf id in each book document. This is because duplicate data will be stored locally with hive
  // @HiveField(10)
  // final List<Book>? books;

  // Utility Functions
  Shelf copyWith({
    String? id,
    String? userId,
    String? title,
    DateTime? titleLastModDate,
    DateTime? createdDate,
    String? description,
    DateTime? descriptionLastModDate,
    DateTime? startReadingDate,
    DateTime? startReadingDateLastModDate,
    DateTime? finishReadingDate,
    DateTime? finishReadingDateLastModDate,
    // List<Book>? books,
  }) {
    return Shelf(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      titleLastModDate: titleLastModDate ?? this.titleLastModDate,
      createdDate: createdDate ?? this.createdDate,
      description: description ?? this.description,
      descriptionLastModDate: descriptionLastModDate ?? this.descriptionLastModDate,
      startReadingDate: startReadingDate ?? this.startReadingDate,
      startReadingDateLastModDate: startReadingDateLastModDate ?? this.startReadingDateLastModDate,
      finishReadingDate: finishReadingDate ?? this.finishReadingDate,
      finishReadingDateLastModDate: finishReadingDateLastModDate ?? this.finishReadingDateLastModDate,
      // books: books ?? this.books,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      r'$id': id,
      'userId': userId,
      'title': title,
      'titleLastModDate': titleLastModDate.millisecondsSinceEpoch,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'description': description,
      'descriptionLastModDate': descriptionLastModDate?.millisecondsSinceEpoch,
      'startReadingDate': startReadingDate?.millisecondsSinceEpoch,
      'startReadingDateLastModDate': startReadingDateLastModDate?.millisecondsSinceEpoch,
      'finishReadingDate': finishReadingDate?.millisecondsSinceEpoch,
      'finishReadingDateLastModDate': finishReadingDateLastModDate?.millisecondsSinceEpoch,
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
      id,
      userId,
      title,
      // Allows shelves with the same title
      createdDate,
    ];
  }
}
