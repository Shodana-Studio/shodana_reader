import 'package:flutter/cupertino.dart';

import 'file_model.dart';
@immutable
class BookModel extends FileModel {
  const BookModel({
    required String title,
    required String author,
    required String filename,
    required String path,
  }) : _title = title,
        _author = author,
        super(filename: filename, path: path);

  factory BookModel.fromJson(Map<String, dynamic> map) {
    final Map<String, dynamic> props = map['properties'];

    return BookModel(
      title: props['title'],
      author: props['author'],
      filename: props['filename'],
      path: props['path'],
    );
  }

  final String _title;
  final String _author;

  String get title => _title;
  String get author => _author;

  @override
  String toString() => 'BookModel(title: $title, filename: $filename, path: $path)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is BookModel && other.title == title && other.filename == filename && other.path == path;
  }

  @override
  int get hashCode => title.hashCode ^ filename.hashCode ^ path.hashCode;
}