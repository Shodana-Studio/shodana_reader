import 'dart:convert';

import 'file_model.dart';

class BookModel extends FileModel {
  const BookModel({
    required String title,
    required String author,
    required String filename,
    required String path,
  }) : _title = title,
        _author = author,
        super(filename: filename, path: path);

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      title: map['title'],
      author: map['author'],
      filename: map['filename'],
      path: map['path'],
    );
  }

  factory BookModel.fromJson(String source) => BookModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'filename': filename,
      'path': path,
    };
  }

  String toJson() => json.encode(toMap());

  final String _title;
  final String _author;

  String get title => _title;
  String get author => _author;

  // @override
  // String toString() => 'BookModel(title: $title, filename: $filename, path: $path)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) {
  //     return true;
  //   }

  //   return other is BookModel && other.title == title && other.filename == filename && other.path == path;
  // }

  // @override
  // int get hashCode => title.hashCode ^ filename.hashCode ^ path.hashCode;

  @override
  List<Object?> get props => [title, author, filename, path];


  BookModel copyWith({
    String? title,
    String? author,
    String? filename,
    String? path,
  }) {
    return BookModel(
      title: title ?? this.title,
      author: author ?? this.author,
      filename: filename ?? this.filename,
      path: path ?? this.path,
    );
  }
}