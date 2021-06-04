import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
class FileModel extends Equatable {
  const FileModel({
    required String filename,
    required String path,
  })  : _filename = filename,
        _path = path;

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      filename: map['filename'],
      path: map['path'],
    );
  }

  factory FileModel.fromJson(String source) => FileModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'filename': filename,
      'path': path,
    };
  }

  String toJson() => json.encode(toMap());

  final String _filename;
  final String _path;

  String get filename => _filename;
  String get path => _path;
  String get fullPath => '$_path/$_filename';

  // @override
  // String toString() => 'FileModel(filename: $filename, path: $path)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) {
  //     return true;
  //   }

  //   return other is FileModel && other.filename == filename && other.path == path;
  // }

  // @override
  // int get hashCode => filename.hashCode ^ path.hashCode;

  FileModel copyWith({
    String? filename,
    String? path,
  }) {
    return FileModel(
      filename: filename ?? this.filename,
      path: path ?? this.path,
    );
  }

  @override
  List<Object?> get props => [filename, path];
}