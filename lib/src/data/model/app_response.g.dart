// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppResponseAdapter extends TypeAdapter<AppResponse> {
  @override
  final int typeId = 0;

  @override
  AppResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppResponse(
      data: fields[0] as dynamic,
      type: fields[1] as Type,
    );
  }

  @override
  void write(BinaryWriter writer, AppResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
