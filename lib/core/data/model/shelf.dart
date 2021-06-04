import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'book.dart';

class Shelf extends Equatable {
  const Shelf({
    required this.title,
    this.description,
    required this.books,
    required this.userId,
    required this.createdDate,
    this.lastModifiedDate, 
  });
  
  factory Shelf.fromMap(Map<String, dynamic> map) {
    return Shelf(
      title: map['title'],
      description: map['description'],
      books: List<Book>.from((map['books'] as List<Map<String, Book>>).map((x) => Book.fromMap(x))),
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      lastModifiedDate: DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate']),
      userId: map['userId'],
    );
  }

  factory Shelf.fromJson(String source) => Shelf.fromMap(json.decode(source));

  final String title;
  final String? description;
  final List<Book> books;
  final String userId;
  final DateTime createdDate;
  final DateTime? lastModifiedDate;

  Shelf copyWith({
    String? title,
    String? description,
    List<Book>? books,
    String? userId,
    DateTime? createdDate,
    DateTime? lastModifiedDate,
  }) {
    return Shelf(
      title: title ?? this.title,
      description: description ?? this.description,
      books: books ?? this.books,
      userId: userId ?? this.userId,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'books': books.map((x) => x.toMap()).toList(),
      'userId': userId,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'lastModifiedDate': createdDate.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, description ?? '', createdDate];
}
