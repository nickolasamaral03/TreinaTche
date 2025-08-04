import 'package:flutter/material.dart';
import '../models/exercicio_model.dart'; // Ajuste o caminho se necessário

class CadastrarTreinoPage extends StatefulWidget {
  @override
  _CadastrarTreinoPageState createState() => _CadastrarTreinoPageState();
}

class _CadastrarTreinoPageState extends State<CadastrarTreinoPage> {
  final _nomeGrupoController = TextEditingController();
  final _horarioController = TextEditingController();
  final _nomeTreinoController = TextEditingController();
  final _seriesController = TextEditingController();
  final _pesoController = TextEditingController();

  List<Treino> _treinos = [];

  void _adicionarTreino() {
    final nome = _nomeTreinoController.text;
    final series = int.tryParse(_seriesController.text);
    final peso = double.tryParse(_pesoController.text);

    if (nome.isNotEmpty && series != null && peso != null) {
      setState(() {
        _treinos.add(
          Treino(nome: nome, series: series, peso: peso),
        );
      });

      _nomeTreinoController.clear();
      _seriesController.clear();
      _pesoController.clear();
    }
  }

  void _salvarGrupoTreino() {
    final nomeGrupo = _nomeGrupoController.text;
    final horario = _horarioController.text;

    if (nomeGrupo.isNotEmpty && horario.isNotEmpty && _treinos.isNotEmpty) {
      final grupo = GrupoTreino(
        nome: nomeGrupo,
        horario: horario,
        treinos: _treinos,
      );

      Navigator.pop(context, grupo); // Retorna para a tela inicial com o grupo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Grupo de Treino')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeGrupoController,
              decoration: InputDecoration(labelText: 'Nome do Grupo de Treino'),
            ),
            TextField(
              controller: _horarioController,
              decoration: InputDecoration(labelText: 'Horário'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nomeTreinoController,
              decoration: InputDecoration(labelText: 'Nome do Exercício'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _seriesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Séries'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Peso (kg)'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _adicionarTreino,
              child: Text('Adicionar Exercício'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _treinos.length,
                itemBuilder: (context, index) {
                  final treino = _treinos[index];
                  return ListTile(
                    title: Text('${treino.nome} - ${treino.series}x - ${treino.peso}kg'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _salvarGrupoTreino,
              child: Text('Salvar Grupo de Treino'),
            ),
          ],
        ),
      ),
    );
  }
}
