// import 'dart:async';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:logger/logger.dart'; // Importe o pacote logger
// import '../models/cadastro_model.dart';

// class SyncService {
//   static Timer? _timer;
//   static const Duration _interval = Duration(seconds: 30); // Intervalo de tempo para tentar sincronizar
//   static var logger = Logger(); // Crie uma instância do logger

//   static void iniciarSincronizacao() {
//     _timer = Timer.periodic(_interval, (timer) async {
//       await _sincronizarCadastros();
//     });
//   }

//   static Future<void> _sincronizarCadastros() async {
//     Box<CadastroModel> cadastroBox = await Hive.openBox<CadastroModel>('cadastroBox');
//     List<CadastroModel> cadastrosPendentes = cadastroBox.values.toList();

//     if (cadastrosPendentes.isNotEmpty) {
//       DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('cadastros');

//       for (CadastroModel cadastro in cadastrosPendentes) {
//         await dbRef.push().set({
//           'nome': cadastro.nome,
//           'classificacaoIdade': cadastro.classificacaoIdade,
//           'bairro': cadastro.bairro,
//           'profissao': cadastro.profissao,
//           'contato': cadastro.contato,
//           'whatsapp': cadastro.isWhatsApp,
//         });
//       }

//       // Limpar os cadastros do box após sincronização bem-sucedida
//       await cadastroBox.clear();

//       // Mostrar mensagem de sucesso
//       logger.i('Todos os ${cadastrosPendentes.length} cadastros foram realizados com sucesso!');
//     }
//   }

//   static void pararSincronizacao() {
//     _timer?.cancel();
//   }
// }
