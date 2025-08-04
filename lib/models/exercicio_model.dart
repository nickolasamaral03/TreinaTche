class Treino {
  String nome;
  int series;
  double peso;

  Treino({required this.nome, required this.series, required this.peso});
  // Treino(nome: 'Supino reto', series: 4, peso: 40.0);

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'series': series,
    'peso': peso,
  };
  // Transforma o objeto Treino em um Map (estrutura tipo JSON).

  factory Treino.fromJson(Map<String, dynamic> json) => Treino(
    nome: json['nome'],
    series: json['series'],
    peso: json['peso'],
  );
}
// fromJson(): Construtor que cria um Treino a partir de um Map (como o que você salva/recupera do armazenamento).

class GrupoTreino {
  String nome;
  String horario;
  List<Treino> treinos;

  GrupoTreino({required this.nome, required this.horario, required this.treinos});

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'horario': horario,
    'treinos': treinos.map((e) => e.toJson()).toList(),
  };

  factory GrupoTreino.fromJson(Map<String, dynamic> json) => GrupoTreino(
    nome: json['nome'],
    horario: json['horario'],
    treinos: (json['treinos'] as List).map((e) => Treino.fromJson(e)).toList(),
  );
}
