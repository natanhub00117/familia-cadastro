import 'package:flutter/material.dart';
import 'screens/cadastro_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Cadastro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          errorStyle: const TextStyle(
            color: Colors.red, // Cor do texto de erro
            fontSize: 14.0, // Tamanho da fonte do texto de erro
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(Colors.white),
          checkColor: WidgetStateProperty.all(Colors.green[400]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green[700],
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
      home: const CadastroScreen(),
    );
  }
}
