import 'package:flutter/material.dart';
import '../models/exercicio_model.dart';

class TreinoDetalhesPage extends StatefulWidget {
  final String nomeTreino;

  const TreinoDetalhesPage({super.key, required this.nomeTreino});

  @override
  _TreinoDetalhesPageState createState() => _TreinoDetalhesPageState();
}

class _TreinoDetalhesPageState extends State<TreinoDetalhesPage> {
  final List<ExercicioModel> exercicios = [];

  final nomeController = TextEditingController();
  final seriesController = TextEditingController();
  final pesoController = TextEditingController();

  void adicionarExercicio() {
    final nome = nomeController.text;
    final series = int.tryParse(seriesController.text) ?? 0;
    final peso = double.tryParse(pesoController.text) ?? 0;

    if (nome.isNotEmpty && series > 0) {
      setState(() {
        exercicios.add(ExercicioModel(
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

  @override
  void dispose() {
    nomeController.dispose();
    seriesController.dispose();
    pesoController.dispose();
    super.dispose();
  } // Limpa na memória os controladores quando a página é descartada 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treino: ${widget.nomeTreino}'),
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
