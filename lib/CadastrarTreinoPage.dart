import 'package:flutter/material.dart';
import 'pages/treino_detalhes_page.dart'; // Importa a página de detalhes do treino

class CadastrarTreinoPage extends StatefulWidget {
  @override
  _CadastrarTreinoPageState createState() => _CadastrarTreinoPageState();
}

class _CadastrarTreinoPageState extends State<CadastrarTreinoPage> {
  final _nomeController = TextEditingController();
  TimeOfDay? _horarioSelecionado;

  void _selecionarHorario() async {
    final TimeOfDay? horario = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horario != null) {
      setState(() {
        _horarioSelecionado = horario;
      });
    }
  }

  void _salvarTreino() {
    final nomeTreino = _nomeController.text.trim();

    if (nomeTreino.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira o nome do treino.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TreinoDetalhesPage(nomeTreino: nomeTreino),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Treino')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Treino'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _horarioSelecionado == null
                      ? 'Horário não selecionado'
                      : 'Horário: ${_horarioSelecionado!.format(context)}',
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _selecionarHorario,
                  child: Text('Selecionar Horário'),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: _salvarTreino, child: Text('Próximo')),
          ],
        ),
      ),
    );
  }
}
