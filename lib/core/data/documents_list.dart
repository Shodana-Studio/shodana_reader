import 'dart:convert';

class DocumentsList {
  DocumentsList(this.sum, this.documents);

  factory DocumentsList.fromMap(Map<String, dynamic> map) {
    return DocumentsList(
      map['sum'],
      List<dynamic>.from(map['documents']),
    );
  }
  
  factory DocumentsList.fromJson(String source) => DocumentsList.fromMap(json.decode(source));

  final int sum;
  final List<dynamic> documents;

}
