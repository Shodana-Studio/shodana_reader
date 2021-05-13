import 'dart:io' as io;

class FileModel {
  const FileModel({
    required String filename,
    required String path,
    required io.File targetFile
  })  : _filename = filename,
        _path = path,
        _targetFile = targetFile;

  final String _filename;
  final String _path;
  final io.File _targetFile;

  String get filename => _filename;
  String get path => _path;
  io.File get targetFile => _targetFile;
}