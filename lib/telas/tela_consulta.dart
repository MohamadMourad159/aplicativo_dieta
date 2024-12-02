import 'package:flutter/material.dart';
import '../modelos/botao.dart';

class TelaConsulta extends StatelessWidget {
  const TelaConsulta({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Consultar itens"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Botao(texto: 'Usuário', aoClicar: () => Navigator.pushNamed(context, '/consultar_usuario')),
            const SizedBox(height: 40),
            Botao(texto: 'Alimento', aoClicar: () => Navigator.pushNamed(context, '/consultar_alimento')),
            const SizedBox(height: 40),
            Botao(texto: 'Cardápio', aoClicar: () => Navigator.pushNamed(context, '/consultar_cardapio')),
          ],
        ));
  }
}
