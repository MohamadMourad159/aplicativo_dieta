import 'package:flutter/material.dart';

class TelaCreditos extends StatelessWidget {
  const TelaCreditos({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Creditos"),
        ),
        body: const Center(
            child: Column(
          children: [
            SizedBox(height: 30),
            Text("Alunos", style: TextStyle(fontSize: 30)),
            Text("Mohamad Osman Mourad", style: TextStyle(fontSize: 20)),
            Text("Samuel Lucas Queiroz Mori", style: TextStyle(fontSize: 20)),
            Text("Pedro Lucas de Paula Lica", style: TextStyle(fontSize: 20)),
            Text("Gabriel da Silva Vaz", style: TextStyle(fontSize: 20)),
            Text("João Pedro Silva Souza", style: TextStyle(fontSize: 20)),
            Text("José Gabriel Arantes", style: TextStyle(fontSize: 20)),
            SizedBox(height: 125),
          ],
        )));
  }
}
