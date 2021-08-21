// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 2;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      userId: fields[0] as String,
      fileId: fields[1] as String,
      bookType: fields[2] as BookType,
      title: fields[3] as String?,
      titleLastModDate: fields[4] as DateTime?,
      author: fields[5] as String?,
      authorLastModDate: fields[6] as DateTime?,
      description: fields[7] as String?,
      descriptionLastModDate: fields[8] as DateTime?,
      readingProgress: fields[9] as int?,
      readingProgressLastModDate: fields[10] as DateTime?,
      publisher: fields[11] as String?,
      publisherLastModDate: fields[12] as DateTime?,
      publishedDate: fields[13] as DateTime?,
      publishedDateLastModDate: fields[14] as DateTime?,
      createdDate: fields[15] as DateTime,
      startReadingDate: fields[16] as DateTime?,
      startReadingDateLastModDate: fields[17] as DateTime?,
      finishReadingDate: fields[18] as DateTime?,
      finishReadingDateLastModDate: fields[19] as DateTime?,
      metadata: fields[20] as dynamic,
      metadataLastModDate: fields[21] as DateTime?,
      shelfIds: (fields[23] as List).cast<String>(),
      shelfIdsLastModDate: fields[24] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.fileId)
      ..writeByte(2)
      ..write(obj.bookType)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.titleLastModDate)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.authorLastModDate)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.descriptionLastModDate)
      ..writeByte(9)
      ..write(obj.readingProgress)
      ..writeByte(10)
      ..write(obj.readingProgressLastModDate)
      ..writeByte(11)
      ..write(obj.publisher)
      ..writeByte(12)
      ..write(obj.publisherLastModDate)
      ..writeByte(13)
      ..write(obj.publishedDate)
      ..writeByte(14)
      ..write(obj.publishedDateLastModDate)
      ..writeByte(15)
      ..write(obj.createdDate)
      ..writeByte(16)
      ..write(obj.startReadingDate)
      ..writeByte(17)
      ..write(obj.startReadingDateLastModDate)
      ..writeByte(18)
      ..write(obj.finishReadingDate)
      ..writeByte(19)
      ..write(obj.finishReadingDateLastModDate)
      ..writeByte(20)
      ..write(obj.metadata)
      ..writeByte(21)
      ..write(obj.metadataLastModDate)
      ..writeByte(23)
      ..write(obj.shelfIds)
      ..writeByte(24)
      ..write(obj.shelfIdsLastModDate);
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
