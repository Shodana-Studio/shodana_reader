import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
class FileModel extends Equatable {
  const FileModel({
    required String filename,
    required String path,
  })  : _filename = filename,
        _path = path;

  factory FileModel.fromJson(Map<String, dynamic> map) {
    final Map<String, dynamic> props = map['properties'];

    return FileModel(
      filename: props['filename'],
      path: props['path'],
    );
  }

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

  @override
  List<Object?> get props => [filename, path];
}