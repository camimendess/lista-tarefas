import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {    
    const String title = 'Lista de Afazeres';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: _tarefas[index].status ? Color.fromARGB(255, 170, 182, 223) : Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(_tarefas[index].descricao),
                          ],
                        ),
                        if (!_tarefas[index].status) 
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _tarefas[index].status = true;
                                });
                              },
                              child: const Text('Concluir Tarefa')
                            ),
                            const SizedBox(width: 15,),
                            IconButton(
                              onPressed: () {
                                TextEditingController controller = TextEditingController(text: _tarefas[index].descricao);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Editar Tarefa',
                                      ),
                                      content: TextField(
                                        controller: controller,
                                        decoration: const InputDecoration(
                                          hintText: 'Descrição da tarefa',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _tarefas[index].descricao = controller.text;
                                            });
                                            Navigator.of(context).pop(); // Fecha o modal
                                          },
                                          child: const Text('Salvar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Fecha o modal
                                          },
                                          child: const Text('Fechar'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                              },
                              icon: const Icon(Icons.edit, color: Color.fromARGB(255, 102, 102, 102),),
                            ),
                            const SizedBox(width: 15,),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _tarefas.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 102, 102, 102),)
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controlador,
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(200, 60))),
                    child: const Text('Adicionar Tarefa'),
                    onPressed: () {
                      if (controlador.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        _tarefas.add(
                          Tarefa(
                            descricao: controlador.text,
                            status: false,
                          ),
                        );
                      });
                      controlador.clear();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tarefa {
  String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}
