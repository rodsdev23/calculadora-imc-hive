// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCAdapter extends TypeAdapter<IMC> {
  @override
  final int typeId = 1;

  @override
  IMC read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMC(
      fields[0] as double,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, IMC obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.altura);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
