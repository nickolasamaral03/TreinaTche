import 'package:flutter/material.dart';
import 'CadastrarTreinoPage.dart'; // Importa a página de cadastro de exercícios
import 'models/exercicio_model.dart'; // Importa os modelos de treino

void main() {
  runApp(TreinoApp());
} //é o ponto de entrada da aplicação Flutter

// StatelessWidget (ou seja, não muda o estado).
// MaterialApp é a base do app com o tema, título e rota inicial.
// home: TelaInicial() define qual tela será exibida primeiro.

class TreinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TreineTchê",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: TelaInicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<GrupoTreino> gruposTreino = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Text(
                'TreinaTchê',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              BotaoPrincipal(
                titulo: 'Cadastrar Treinos',
                onPressed: () async {
                final novoGrupo = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CadastrarTreinoPage()),
                );

                if (novoGrupo != null) {
                  setState(() {
                    gruposTreino.add(novoGrupo);
                  });
                }
              },
              ),

               Expanded(
                child: ListView.builder(
                  itemCount: gruposTreino.length,
                  itemBuilder: (context, index) {
                    final grupo = gruposTreino[index];
                    return ListTile(
                      title: Text(grupo.nome),
                      subtitle: Text('Horário: ${grupo.horario}'),
                    );
                  },
                ),
              ),

              BotaoPrincipal(titulo: 'Iniciar Treino', onPressed: () {}),
              BotaoPrincipal(titulo: 'Ver Progresso', onPressed: () {}),
              BotaoPrincipal(titulo: 'Resumo da Semana', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}


class BotaoPrincipal extends StatelessWidget {
  final String titulo;
  final VoidCallback onPressed;

  const BotaoPrincipal({
    Key? key,
    required this.titulo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent[400],
          padding: EdgeInsets.symmetric(vertical: 18.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          titulo,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

// TREINOS SENDO SALVOS NO LOCAL STORAGE AGORA É APARECER NO FRONT PARA TESTE
