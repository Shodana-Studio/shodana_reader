// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShelfAdapter extends TypeAdapter<Shelf> {
  @override
  final int typeId = 3;

  @override
  Shelf read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shelf(
      shelfId: fields[10] as String,
      userId: fields[0] as String,
      title: fields[1] as String,
      titleLastModDate: fields[2] as DateTime,
      createdDate: fields[3] as DateTime,
      description: fields[4] as String?,
      descriptionLastModDate: fields[5] as DateTime?,
      startReadingDate: fields[6] as DateTime?,
      startReadingDateLastModDate: fields[7] as DateTime?,
      finishReadingDate: fields[8] as DateTime?,
      finishReadingDateLastModDate: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Shelf obj) {
    writer
      ..writeByte(11)
      ..writeByte(10)
      ..write(obj.shelfId)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.titleLastModDate)
      ..writeByte(3)
      ..write(obj.createdDate)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.descriptionLastModDate)
      ..writeByte(6)
      ..write(obj.startReadingDate)
      ..writeByte(7)
      ..write(obj.startReadingDateLastModDate)
      ..writeByte(8)
      ..write(obj.finishReadingDate)
      ..writeByte(9)
      ..write(obj.finishReadingDateLastModDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
