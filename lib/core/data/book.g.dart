// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 10;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      fileId: fields[2] as String?,
      localStorageId: fields[3] as String?,
      bookType: fields[4] as BookType,
      title: fields[5] as String?,
      author: fields[6] as String?,
      description: fields[7] as String?,
      readingProgress: fields[8] as int?,
      publisher: fields[9] as String?,
      publishedDate: fields[10] as DateTime?,
      createdDate: fields[11] as DateTime?,
      lastModifiedDate: fields[12] as DateTime,
      startReadingDate: fields[13] as DateTime?,
      finishReadingDate: fields[14] as DateTime?,
      metadata: fields[15] as dynamic,
      shelfIds: (fields[16] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.fileId)
      ..writeByte(3)
      ..write(obj.localStorageId)
      ..writeByte(4)
      ..write(obj.bookType)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.author)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.readingProgress)
      ..writeByte(9)
      ..write(obj.publisher)
      ..writeByte(10)
      ..write(obj.publishedDate)
      ..writeByte(11)
      ..write(obj.createdDate)
      ..writeByte(12)
      ..write(obj.lastModifiedDate)
      ..writeByte(13)
      ..write(obj.startReadingDate)
      ..writeByte(14)
      ..write(obj.finishReadingDate)
      ..writeByte(15)
      ..write(obj.metadata)
      ..writeByte(16)
      ..write(obj.shelfIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
