import 'package:flutter/material.dart';
import '../modelos/caixa_de_consulta.dart';
class TelaConsultaCardapio extends StatefulWidget {
  const TelaConsultaCardapio({super.key});
  @override
  State<TelaConsultaCardapio> createState() => _TelaConsultaCardapioState();
}
class _TelaConsultaCardapioState extends State<TelaConsultaCardapio> {
  final TextEditingController _nomeController = TextEditingController();
  late CaixaDeConsultaCardapio caixa;
  @override
  void initState() {
    super.initState();
    caixa = CaixaDeConsultaCardapio(nome: '', context: context,);
  }
  void _buscarCardapio(texto) {
    setState(() {
      caixa = CaixaDeConsultaCardapio(nome: texto, context: context,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Consulta de cardápios'),
        ),
        body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              decoration:const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite o nome do usuario',
              ),
              onChanged: _buscarCardapio,
              controller: _nomeController,
            ),
            const SizedBox(height: 20),
            caixa.build(context),
          ],
        )));
  }
}
