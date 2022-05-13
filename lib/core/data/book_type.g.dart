// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookTypeAdapter extends TypeAdapter<BookType> {
  @override
  final int typeId = 0;

  @override
  BookType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BookType.unknown;
      case 1:
        return BookType.epub;
      case 2:
        return BookType.pdf;
      default:
        return BookType.unknown;
    }
  }

  @override
  void write(BinaryWriter writer, BookType obj) {
    switch (obj) {
      case BookType.unknown:
        writer.writeByte(0);
        break;
      case BookType.epub:
        writer.writeByte(1);
        break;
      case BookType.pdf:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
