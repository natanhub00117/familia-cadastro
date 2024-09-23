class Dados {
  final List<String> bairros;
  final List<String> classificacaoIdade;
  final List<String> profissoes;

  Dados({
    required this.bairros,
    required this.classificacaoIdade,
    required this.profissoes,
  });

  factory Dados.fromJson(Map<String, dynamic> json) {
    return Dados(
      bairros: List<String>.from(json['Bairros']),
      classificacaoIdade: List<String>.from(json['ClassificacaoIdade']),
      profissoes: List<String>.from(json['Profissoes']),
    );
  }
}