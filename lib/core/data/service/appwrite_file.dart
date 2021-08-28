import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppwriteFile extends Equatable {
  const AppwriteFile({
    required this.id,
    required this.permissions,
    required this.name,
    required this.dateCreated,
    required this.signature,
    required this.mimeType,
    required this.sizeOriginal,
  });

  factory AppwriteFile.fromMap(Map<String, dynamic> map) {
    return AppwriteFile(
      id: map[r'$id'],
      permissions: Map<String, List<String>>.from(map['permissions']),
      name: map['name'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
      signature: map['signature'],
      mimeType: map['mimeType'],
      sizeOriginal: map['sizeOriginal'],
    );
  }

  factory AppwriteFile.fromJson(String source) => AppwriteFile.fromMap(json.decode(source));

  final String id;
  final Map<String, List<String>> permissions;
  final String name;
  final DateTime dateCreated;
  final String signature;
  final String mimeType;
  final int sizeOriginal;

  AppwriteFile copyWith({
    String? id,
    Map<String, List<String>>? permissions,
    String? name,
    DateTime? dateCreated,
    String? signature,
    String? mimeType,
    int? sizeOriginal,
  }) {
    return AppwriteFile(
      id: id ?? this.id,
      permissions: permissions ?? this.permissions,
      name: name ?? this.name,
      dateCreated: dateCreated ?? this.dateCreated,
      signature: signature ?? this.signature,
      mimeType: mimeType ?? this.mimeType,
      sizeOriginal: sizeOriginal ?? this.sizeOriginal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'permissions': permissions,
      'name': name,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'signature': signature,
      'mimeType': mimeType,
      'sizeOriginal': sizeOriginal,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      permissions,
      name,
      dateCreated,
      signature,
      mimeType,
      sizeOriginal,
    ];
  }
}
