import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/exercicio_model.dart';

class TreinoDetalhesPage extends StatefulWidget {
  final String nomeTreino;

  const TreinoDetalhesPage({super.key, required this.nomeTreino});

  @override
  _TreinoDetalhesPageState createState() => _TreinoDetalhesPageState();
}

class _TreinoDetalhesPageState extends State<TreinoDetalhesPage> {
  final List<Treino> exercicios = [];

  final nomeController = TextEditingController();
  final seriesController = TextEditingController();
  final pesoController = TextEditingController();

  void adicionarExercicio() {
    final nome = nomeController.text;
    final series = int.tryParse(seriesController.text) ?? 0;
    final peso = double.tryParse(pesoController.text) ?? 0;

    if (nome.isNotEmpty && series > 0) {
      setState(() {
        exercicios.add(Treino(
          nome: nome,
          series: series,
          peso: peso,
        ));
      });

      nomeController.clear();
      seriesController.clear();
      pesoController.clear();
    }
  }

  Future<void> salvarGrupoTreino() async {
    final prefs = await SharedPreferences.getInstance();

    final grupo = GrupoTreino(
      nome: widget.nomeTreino,
      horario: TimeOfDay.now().format(context),
      treinos: exercicios,
    );

    final grupoJson = jsonEncode(grupo.toJson());

    await prefs.setString('grupo_treino', grupoJson);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Grupo salvo com sucesso!')),
    );

    Navigator.pop(context); // Volta para tela anterior
  }

  @override
  void dispose() {
    nomeController.dispose();
    seriesController.dispose();
    pesoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treino: ${widget.nomeTreino}'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: salvarGrupoTreino,
            tooltip: 'Salvar Grupo',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome do Exercício'),
            ),
            TextField(
              controller: seriesController,
              decoration: InputDecoration(labelText: 'Séries'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: pesoController,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: adicionarExercicio,
              child: Text('Adicionar Exercício'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  final exercicio = exercicios[index];
                  return ListTile(
                    title: Text(exercicio.nome),
                    subtitle: Text('${exercicio.series} séries - ${exercicio.peso} kg'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

