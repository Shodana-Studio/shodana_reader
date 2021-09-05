// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShelfAdapter extends TypeAdapter<Shelf> {
  @override
  final int typeId = 20;

  @override
  Shelf read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shelf(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      title: fields[2] as String?,
      createdDate: fields[3] as DateTime?,
      lastModifiedDate: fields[4] as DateTime,
      description: fields[5] as String?,
      startReadingDate: fields[6] as DateTime?,
      finishReadingDate: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Shelf obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.createdDate)
      ..writeByte(4)
      ..write(obj.lastModifiedDate)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.startReadingDate)
      ..writeByte(7)
      ..write(obj.finishReadingDate);
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
