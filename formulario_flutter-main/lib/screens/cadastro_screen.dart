import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import '../services/dados_service.dart';
import '../models/cadastro_model.dart';
import 'historico_cadastro.dart';
import 'cadastro_form.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  createState() => CadastroScreenState();
}

class CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Box<CadastroModel>? _cadastroBox;
  bool isWhatsApp = false;
  final ValueNotifier<int> _imageIndexNotifier = ValueNotifier<int>(0);
  late Timer _timer;

  List<String> bairros = [];
  List<String> classificacaoIdade = [];
  List<String> profissoes = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CadastroModelAdapter());
    }
    _openBox();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      _imageIndexNotifier.value = (_imageIndexNotifier.value + 1) % 2;
    });
  }

  Future<void> _carregarDados() async {
    await DadosService.carregarDados();
    final dados = await DadosService.obterDados();
    setState(() {
      bairros = List<String>.from(dados['Bairros']);
      classificacaoIdade = List<String>.from(dados['ClassificacaoIdade']);
      profissoes = List<String>.from(dados['Profissoes']);
    });
  }

  Future<void> _openBox() async {
    _cadastroBox = await Hive.openBox<CadastroModel>('cadastroBox');
  }

  @override
  void dispose() {
    _timer.cancel();
    Hive.close();
    _imageIndexNotifier.dispose();
    super.dispose();
  }

  void _mostrarDialogo(BuildContext context, String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(titulo, style: const TextStyle(color: Colors.black)),
          content: Text(mensagem, style: const TextStyle(color: Colors.black)),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Função para resetar o formulário

  // Variáveis para controle de cadastros e tempo
  int _contagemCadastros = 0;
  DateTime? _ultimoCadastroTimestamp;

  void _adicionarCadastro() async {
  if (_formKey.currentState!.saveAndValidate()) {
    final cadastro = CadastroModel()
      ..nome = _formKey.currentState!.value['nome']
      ..classificacaoIdade =
          _formKey.currentState!.value['classificacao_idade']
      ..bairro = _formKey.currentState!.value['bairro']
      ..profissao = _formKey.currentState!.value['profissao']
      ..contato = _formKey.currentState!.value['contato']
      ..whatsapp = isWhatsApp;

    try {
      await _cadastroBox?.add(cadastro);

      final DatabaseReference dbRef =
          FirebaseDatabase.instance.ref().child('cadastros');
      await dbRef.push().set({
        'nome': cadastro.nome,
        'classificacaoIdade': cadastro.classificacaoIdade,
        'bairro': cadastro.bairro,
        'profissao': cadastro.profissao,
        'contato': cadastro.contato,
        'whatsapp': cadastro.whatsapp,
      });

      DateTime agora = DateTime.now();
      if (_ultimoCadastroTimestamp == null ||
          agora.difference(_ultimoCadastroTimestamp!).inSeconds > 2) {
        _ultimoCadastroTimestamp = agora;
        _contagemCadastros = 1;
      } else {
        _contagemCadastros++;
      }

      Future.delayed(const Duration(seconds: 2)).then((_) {
        if (mounted && _contagemCadastros > 0) {
          _mostrarDialogo(context, 'Sucesso',
              '$_contagemCadastros Cadastro(s) realizado(s) com sucesso!');
          _contagemCadastros = 0;
        }
      });

      // Resetar o formulário e o estado do checkbox
      _formKey.currentState?.reset();
      _formKey.currentState?.patchValue({
        'nome': null,
        'classificacao_idade': null,
        'bairro': null,
        'profissao': null,
        'contato': null,
      });
      setState(() {
        isWhatsApp = false;
      });

    } catch (e) {
      if (mounted) {
        _mostrarDialogo(context, 'Erro', 'Ocorreu um erro: $e');
      }
    }
  } else {
    if (mounted) {
      _mostrarDialogo(
          context, 'Erro', 'Preencha todos os campos corretamente.');
    }
  }
}


  void _mostrarHistorico(BuildContext context) {
    if (_cadastroBox == null || _cadastroBox!.isEmpty) {
      _mostrarDialogo(context, 'Erro', 'Nenhum cadastro realizado.');
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HistoricoCadastros(
            cadastros: _cadastroBox!.values.toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder<int>(
            valueListenable: _imageIndexNotifier,
            builder: (context, imageIndex, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: imageIndex == 0
                    ? Image.asset('assets/app_icon.png',
                        key: ValueKey<int>(imageIndex))
                    : Image.asset('assets/app_banner.png',
                        key: ValueKey<int>(imageIndex)),
              );
            },
          ),
        ),
      ),
      body: CadastroForm(
        formKey: _formKey,
        bairros: bairros,
        classificacaoIdade: classificacaoIdade,
        profissoes: profissoes,
        isWhatsApp: isWhatsApp,
        onWhatsAppChanged: (bool value) {
          setState(() {
            isWhatsApp = value;
          });
        },
        onSave: _adicionarCadastro,
        onShowHistory: () => _mostrarHistorico(context),
      ),
    );
  }
}
