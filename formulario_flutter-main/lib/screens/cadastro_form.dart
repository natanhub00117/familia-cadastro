import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<String> bairros;
  final List<String> classificacaoIdade;
  final List<String> profissoes;
  final bool isWhatsApp;
  final ValueChanged<bool> onWhatsAppChanged;
  final VoidCallback onSave;
  final VoidCallback onShowHistory;

  CadastroForm({
    super.key,
    required this.formKey,
    required this.bairros,
    required this.classificacaoIdade,
    required this.profissoes,
    required this.isWhatsApp,
    required this.onWhatsAppChanged,
    required this.onSave,
    required this.onShowHistory,
  });

  final maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              FormBuilderTextField(
                name: 'nome',
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hoverColor: Colors.white,
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Campo obrigatório'),
                  FormBuilderValidators.minLength(3,
                      errorText: 'Mínimo de 4 caracteres'),
                ]),
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown(
                name: 'classificacao_idade',
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  prefixIcon: Icon(Icons.cake, color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                items: classificacaoIdade
                    .map((classificacao) => DropdownMenuItem(
                        value: classificacao,
                        child: Text(classificacao,
                            style: const TextStyle(color: Colors.black))))
                    .toList(),
                validator: FormBuilderValidators.required(
                    errorText: 'Campo obrigatório'),
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown(
                name: 'bairro',
                decoration: const InputDecoration(
                  labelText: 'Bairro',
                  prefixIcon: Icon(Icons.location_city, color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                items: bairros
                    .map((bairro) => DropdownMenuItem(
                        value: bairro,
                        child: Text(bairro,
                            style: const TextStyle(color: Colors.black))))
                    .toList(),
                validator: FormBuilderValidators.required(
                    errorText: 'Campo obrigatório'),
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown(
                name: 'profissao',
                decoration: const InputDecoration(
                  labelText: 'Profissão',
                  prefixIcon: Icon(Icons.work, color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                items: profissoes
                    .map((profissao) => DropdownMenuItem(
                        value: profissao,
                        child: Text(profissao,
                            style: const TextStyle(color: Colors.black))))
                    .toList(),
                validator: FormBuilderValidators.required(
                    errorText: 'Campo obrigatório'),
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
              ),
              const SizedBox(height: 20),
              FormBuilderTextField(
                name: 'contato',
                decoration: const InputDecoration(
                  hoverColor: Colors.white,
                  labelText: 'Contato',
                  prefixIcon: Icon(Icons.phone, color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                inputFormatters: [maskFormatter],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Campo obrigatório'),
                  FormBuilderValidators.minLength(14,
                      errorText: 'Contato inválido'),
                ]),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: isWhatsApp,
                    onChanged: (bool? value) {
                      onWhatsAppChanged(value ?? false);
                    },
                  ),
                  const Text('O contato é WhatsApp?',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Salvar cadastro',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onShowHistory,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Ver Histórico de cadastros',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
