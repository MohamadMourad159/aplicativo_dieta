import 'package:flutter/material.dart';
import '../modelos/botao.dart';

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrar"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            const Text("Escolha o que deseja cadastrar:",
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 50),
            Botao(
                texto: 'Usuário',
                aoClicar: () => Navigator.pushNamed(context, '/novo_usuario')),
            const SizedBox(height: 50),
            Botao(
                texto: 'Alimento',
                aoClicar: () => Navigator.pushNamed(context, '/novo_alimento')),
            const SizedBox(height: 50),
            Botao(
                texto: 'Cardápio',
                aoClicar: () => Navigator.pushNamed(context, '/novo_cardapio')),
            const SizedBox(height: 50),
          ],
        ));
  }
}
