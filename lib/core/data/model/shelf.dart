import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'book.dart';

class Shelf extends Equatable {
  // Constructors
  const Shelf({
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
    this.books,
  });

  factory Shelf.fromMap(Map<String, dynamic> map) {
    return Shelf(
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
      books: List<Book>.from((map['books'] as List<Map<String, Book>>).map((x) => Book.fromMap(x))),
    );
  }

  factory Shelf.fromJson(String source) => Shelf.fromMap(json.decode(source));

  // Variables
  final String userId;

  final String title;
  final DateTime titleLastModDate;

  final DateTime createdDate;

  final String? description;
  final DateTime? descriptionLastModDate;

  final DateTime? startReadingDate;
  final DateTime? startReadingDateLastModDate;
  
  final DateTime? finishReadingDate;
  final DateTime? finishReadingDateLastModDate;

  final List<Book>? books;

  // Utility Functions
  Shelf copyWith({
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
    List<Book>? books,
  }) {
    return Shelf(
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
      books: books ?? this.books,
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
      'books': books?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  // Overrides
  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      userId,
      title,
      // Allows shelves with the same title
      createdDate,
    ];
  }
}
