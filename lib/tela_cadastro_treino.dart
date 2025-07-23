import 'package:flutter/material.dart';

class TelaCadastroTreino extends StatefulWidget {
  @override
  _TelaCadastroTreinoState createState() => _TelaCadastroTreinoState();
}

class _TelaCadastroTreinoState extends State<TelaCadastroTreino> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController =
      TextEditingController(); // controller para o campo de nome do treino
  final TextEditingController _pesoController =
      TextEditingController(); // controller para o campo de peso
  TimeOfDay?
  _horarioSelecionado; // variável para armazenar o horário selecionado

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
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text;
      final peso = _pesoController.text;
      final horario = _horarioSelecionado;

      print('Treino Salvo: ');
      print('Nome: $nome');
      print('Peso: $peso');
      print('Horário: ${horario?.format(context) ?? 'Não selecionado'}');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Treino salvo com sucesso!')));

      // Limpar os campos após salvar
      _nomeController.clear();
      _pesoController.clear();
      setState(() {
        _horarioSelecionado = null; // Reseta o horário selecionado
      });
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Cadastrar Treino'),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nome do exercício',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o nome do exercício';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _pesoController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o peso';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    _horarioSelecionado != null
                        ? 'Horário: ${_horarioSelecionado!.format(context)}'
                        : 'Horário não definido',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _selecionarHorario,
                    child: Text('Selecionar horário'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent[400],
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _salvarTreino,
                child: Text('Salvar Treino'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[400],
                  foregroundColor: Colors.black87,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
