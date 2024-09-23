// historico_cadastro.dart

import 'package:flutter/material.dart';
import '../models/cadastro_model.dart';

class HistoricoCadastros extends StatefulWidget {
  final List<CadastroModel> cadastros;

  const HistoricoCadastros({super.key, required this.cadastros});

  @override
  createState() => _HistoricoCadastrosState();
}

class _HistoricoCadastrosState extends State<HistoricoCadastros> {
  bool isSearching = false;
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final cadastrosFiltrados = _filterCadastros(widget.cadastros, searchText);

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? _buildSearchField()
            : const Text('Histórico de Cadastros'),
        actions: [_buildSearchIcon()],
      ),
      body: ListView.builder(
        itemCount: cadastrosFiltrados.length,
        itemBuilder: (context, index) =>
            _buildCadastroCard(cadastrosFiltrados[index]),
      ),
    );
  }

  List<CadastroModel> _filterCadastros(
      List<CadastroModel> cadastros, String searchText) {
    return cadastros.where((cadastro) {
      return cadastro.nome?.toLowerCase().contains(searchText.toLowerCase()) ??
          false;
    }).toList();
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
      style: TextStyle(color: Colors.green[700]),
      decoration: InputDecoration(
        icon: Icon(Icons.search, color: Colors.green[700]),
        hintText: "Buscar por nome...",
        hintStyle: TextStyle(color: Colors.green[700]),
      ),
    );
  }

  IconButton _buildSearchIcon() {
    return IconButton(
      icon: Icon(isSearching ? Icons.cancel : Icons.search),
      onPressed: () {
        setState(() {
          isSearching = !isSearching;
          if (!isSearching) {
            searchText = "";
          }
        });
      },
    );
  }

  Card _buildCadastroCard(CadastroModel cadastro) {
    return Card(
      child: ListTile(
        title: Text(cadastro.nome ?? 'Nome não disponível'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Idade: ${cadastro.classificacaoIdade}'),
            Text('Bairro: ${cadastro.bairro}'),
            Text('Profissão: ${cadastro.profissao}'),
            Text('Contato: ${cadastro.contato}'),
            Text('O contato é WhatsApp? ${cadastro.whatsapp ? 'Sim' : 'Não'}'),
          ],
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
