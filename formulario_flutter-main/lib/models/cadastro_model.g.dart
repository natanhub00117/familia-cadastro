// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CadastroModelAdapter extends TypeAdapter<CadastroModel> {
  @override
  final int typeId = 0;

  @override
  CadastroModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CadastroModel()
      ..nome = fields[0] as String?
      ..classificacaoIdade = fields[1] as String?
      ..bairro = fields[2] as String?
      ..profissao = fields[3] as String?
      ..contato = fields[4] as String?
      ..whatsapp = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, CadastroModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.classificacaoIdade)
      ..writeByte(2)
      ..write(obj.bairro)
      ..writeByte(3)
      ..write(obj.profissao)
      ..writeByte(4)
      ..write(obj.contato)
      ..writeByte(5)
      ..write(obj.whatsapp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CadastroModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
