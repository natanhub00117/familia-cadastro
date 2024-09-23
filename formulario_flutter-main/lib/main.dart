import 'package:dr_helio/firebase_options.dart';
import 'package:dr_helio/models/cadastro_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/dados_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  // Register the adapter for CadastroModel
  Hive.registerAdapter(CadastroModelAdapter());

  // Carregar os dados do JSON antes de inicializar o app
  await DadosService.carregarDados();

  // Fazer login anônimo
  await FirebaseAuth.instance.signInAnonymously();

  runApp(const MyApp());
}
