// cadastro_model.dart

import 'package:hive/hive.dart';

part 'cadastro_model.g.dart'; // Gerado pelo Hive

@HiveType(typeId: 0)
class CadastroModel extends HiveObject {
  @HiveField(0)
  String? nome;

  @HiveField(1)
  String? classificacaoIdade;

  @HiveField(2)
  String? bairro;

  @HiveField(3)
  String? profissao;

  @HiveField(4)
  String? contato;

  @HiveField(5)
  late bool whatsapp;
}