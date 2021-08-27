// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingStatsAdapter extends TypeAdapter<ReadingStats> {
  @override
  final int typeId = 1;

  @override
  ReadingStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadingStats(
      id: fields[4] as String?,
      date: fields[0] as DateTime,
      timeRead: fields[1] as int,
      userId: fields[2] as String,
      bookId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReadingStats obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.timeRead)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.bookId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
