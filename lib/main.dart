import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MudeApp());
}

class MudeApp extends StatelessWidget {
  const MudeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mude',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class TreinoDia {
  final String diaSemana;
  final List<ExercicioDetalhado> exercicios;
  TreinoDia(this.diaSemana, this.exercicios);
}

class ExercicioDetalhado {
  final String nome;
  final String repeticoes;
  ExercicioDetalhado(this.nome, this.repeticoes);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TreinoDia> _treinosSemana = [
    TreinoDia('Segunda', [
      ExercicioDetalhado('Peito - Supino Reto', '4x12'),
      ExercicioDetalhado('Peito - Crucifixo', '3x15'),
      ExercicioDetalhado('Ombro - Desenvolvimento', '4x10'),
      ExercicioDetalhado('Ombro - Elevação Lateral', '3x15'),
      ExercicioDetalhado('Tríceps - Tríceps Testa', '3x12'),
      ExercicioDetalhado('Tríceps - Mergulho', '3x15'),
    ]),
    TreinoDia('Terça', [
      ExercicioDetalhado('Perna - Agachamento', '4x10'),
      ExercicioDetalhado('Leg Press', '4x12'),
      ExercicioDetalhado('Cadeira Extensora', '3x15'),
      ExercicioDetalhado('Cadeira Flexora', '3x15'),
      ExercicioDetalhado('Panturrilha - Elevação', '4x20'),
    ]),
    TreinoDia('Quarta', [
      ExercicioDetalhado('Costas - Puxada Frontal', '4x12'),
      ExercicioDetalhado('Costas - Remada Curvada', '4x10'),
      ExercicioDetalhado('Bíceps - Rosca Direta', '3x12'),
      ExercicioDetalhado('Bíceps - Rosca Martelo', '3x15'),
    ]),
    TreinoDia('Quinta', [
      ExercicioDetalhado('Peito - Supino Reto', '4x12'),
      ExercicioDetalhado('Peito - Crucifixo', '3x15'),
      ExercicioDetalhado('Ombro - Desenvolvimento', '4x10'),
      ExercicioDetalhado('Ombro - Elevação Lateral', '3x15'),
      ExercicioDetalhado('Tríceps - Tríceps Testa', '3x12'),
      ExercicioDetalhado('Tríceps - Mergulho', '3x15'),
    ]),
    TreinoDia('Sexta', [
      ExercicioDetalhado('Perna - Agachamento', '4x10'),
      ExercicioDetalhado('Leg Press', '4x12'),
      ExercicioDetalhado('Cadeira Extensora', '3x15'),
      ExercicioDetalhado('Cadeira Flexora', '3x15'),
      ExercicioDetalhado('Panturrilha - Elevação', '4x20'),
    ]),
    TreinoDia('Sábado', [
      ExercicioDetalhado('Costas - Puxada Frontal', '4x12'),
      ExercicioDetalhado('Costas - Remada Curvada', '4x10'),
      ExercicioDetalhado('Bíceps - Rosca Direta', '3x12'),
      ExercicioDetalhado('Bíceps - Rosca Martelo', '3x15'),
    ]),
  ];

  int _diaSelecionado = 0;

  Future<void> _showEditarTreinoDialog() async {
    List<ExercicioDetalhado> copiaExercicios =
        List.from(_treinosSemana[_diaSelecionado].exercicios);

    final nomeController = TextEditingController();
    final repeticoesController = TextEditingController();

    Future<void> _editarExercicio(int index) async {
      nomeController.text = copiaExercicios[index].nome;
      repeticoesController.text = copiaExercicios[index].repeticoes;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.deepPurple[900],
          title: const Text('Editar Exercício', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              TextField(
                controller: repeticoesController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Repetições',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.deepPurpleAccent)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  copiaExercicios[index] = ExercicioDetalhado(
                    nomeController.text.trim(),
                    repeticoesController.text.trim(),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      );
    }

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple[900],
            title: const Text('Editar Treino', style: TextStyle(color: Colors.white)),
            content: SizedBox(
              width: double.maxFinite,
              height: 350,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: copiaExercicios.length,
                      itemBuilder: (context, index) {
                        final ex = copiaExercicios[index];
                        return ListTile(
                          title: Text(ex.nome, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(ex.repeticoes, style: TextStyle(color: Colors.deepPurpleAccent.shade100)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.deepPurpleAccent),
                                onPressed: () async {
                                  await _editarExercicio(index);
                                  setStateDialog(() {});
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () {
                                  setStateDialog(() {
                                    copiaExercicios.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(color: Colors.deepPurpleAccent),
                  TextField(
                    controller: nomeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Novo Exercício',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
                    ),
                  ),
                  TextField(
                    controller: repeticoesController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Repetições',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      final nome = nomeController.text.trim();
                      final reps = repeticoesController.text.trim();
                      if (nome.isNotEmpty && reps.isNotEmpty) {
                        setStateDialog(() {
                          copiaExercicios.add(ExercicioDetalhado(nome, reps));
                        });
                        nomeController.clear();
                        repeticoesController.clear();
                      }
                    },
                    child: const Text('Adicionar Exercício'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar', style: TextStyle(color: Colors.deepPurpleAccent)),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _treinosSemana[_diaSelecionado].exercicios
                      ..clear()
                      ..addAll(copiaExercicios);
                  });
                  Navigator.pop(context);
                },
                child: const Text('Salvar Treino'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final treinoAtual = _treinosSemana[_diaSelecionado];

    return Scaffold(
      body: Stack(
        children: [
          const GalaxyBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Mude',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent.shade200,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.deepPurpleAccent.shade100,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _treinosSemana.length,
                    itemBuilder: (context, index) {
                      final dia = _treinosSemana[index].diaSemana;
                      final isSelected = index == _diaSelecionado;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _diaSelecionado = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.deepPurpleAccent : Colors.deepPurple[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              dia,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.deepPurple[200],
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: treinoAtual.exercicios.length,
                    itemBuilder: (context, index) {
                      final ex = treinoAtual.exercicios[index];
                      return ListTile(
                        title: Text(
                          ex.nome,
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        trailing: Text(
                          ex.repeticoes,
                          style: TextStyle(color: Colors.deepPurpleAccent.shade100, fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.black, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                onPressed: _showEditarTreinoDialog,
                child: const Icon(Icons.add, size: 36),
                tooltip: 'Editar/Adicionar Exercício',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Fundo galáxia com pontinhos brancos animados
class GalaxyBackground extends StatefulWidget {
  const GalaxyBackground({super.key});

  @override
  State<GalaxyBackground> createState() => _GalaxyBackgroundState();
}

class _GalaxyBackgroundState extends State<GalaxyBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Offset> _stars = [];
  final int starCount = 100;
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < starCount; i++) {
      _stars.add(Offset(random.nextDouble(), random.nextDouble()));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _animateStar(Offset star, double progress) {
    double y = star.dy - 0.5 * progress;
    if (y < 0) y += 1.0;
    return Offset(star.dx, y);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        return CustomPaint(
          size: Size.infinite,
          painter: _GalaxyPainter(_stars, progress, _animateStar),
        );
      },
    );
  }
}

class _GalaxyPainter extends CustomPainter {
  final List<Offset> stars;
  final double progress;
  final Offset Function(Offset, double) animateStar;

  _GalaxyPainter(this.stars, this.progress, this.animateStar);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);

    for (final star in stars) {
      final pos = animateStar(star, progress);
      final offset = Offset(pos.dx * size.width, pos.dy * size.height);
      canvas.drawCircle(offset, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GalaxyPainter oldDelegate) => true;
}
