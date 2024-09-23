import 'dart:convert';
import 'package:flutter/services.dart';

class DadosService {
  static Map<String, dynamic> _dados = {};

  static Future<void> carregarDados() async {
    final String response = await rootBundle.loadString('assets/dados.json');
    _dados = json.decode(response);
  }

  static Future<Map<String, dynamic>> obterDados() async {
    return _dados;
  }
}
