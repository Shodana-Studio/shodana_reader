import 'dart:io' as io;

import 'package:shodana_reader/core/data/file_model.dart';

class BookModel extends FileModel {
  BookModel({
    required String filename,
    required String path,
    required io.File targetFile,
    required String title
  }) : _title = title,
        super(filename: filename, path: path, targetFile: targetFile);

  final String _title;

  String get title => _title;
}