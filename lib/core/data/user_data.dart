// ignore_for_file: sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'book.dart';
import 'shelf.dart';

@immutable
class UserData extends Equatable {
  const UserData({
    required this.books,
    required this.shelves,
  });

  // In the future, this would contain other data about Users, maybe active friend lists, or notifications, etc
  final List<Book> books;
  final List<Shelf> shelves;

  UserData copyWith({
    List<Book>? books,
    List<Shelf>? shelves,
  }) {
    return UserData(
      books: books ?? this.books,
      shelves: shelves ?? this.shelves,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'books': books.map((x) => x.toMap()).toList(),
      'shelves': shelves.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      books: List<Book>.from((map['books'] as List<Map<String, dynamic>>).map((bookMap) => Book.fromMap(bookMap))),
      shelves: List<Shelf>.from((map['shelves'] as List<Map<String, dynamic>>).map((shelfMap) => Shelf.fromMap(shelfMap))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [books, shelves];
}
