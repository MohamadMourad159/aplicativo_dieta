import 'package:flutter/material.dart';
import '../modelos/botao.dart';
import '../database_helper.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});
  void logout(context){
    Database.updateUsuarioLogado('');
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Tela principal'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Nutribom",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Botao(texto: 'Cadastrar', aoClicar: () => Navigator.pushNamed(context, '/cadastrar')),
            const SizedBox(height: 40),
            Botao(texto: 'Consultar', aoClicar: () => Navigator.pushNamed(context, '/consultar')),
            const SizedBox(height: 40),
            Botao(texto: 'Créditos', aoClicar: () => Navigator.pushNamed(context, '/creditos')),
            const SizedBox(height: 40),
            Botao(texto: 'Logout', aoClicar: () => logout(context)),
          ],
        ));
  }
}
