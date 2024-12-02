import 'package:flutter/material.dart';
import '../modelos/caixa_de_consulta.dart';
import '../funções/compartilhar.dart';
class TelaConsultaUsuario extends StatefulWidget {
  final String texto;
  final Function funcao;
  const TelaConsultaUsuario({super.key, this.texto = '-->', this.funcao = Compartilhar.compartilharUsuario});
  @override
  State<TelaConsultaUsuario> createState() => _TelaConsultaUsuarioState();
}
class _TelaConsultaUsuarioState extends State<TelaConsultaUsuario> {
  final TextEditingController _nomeController = TextEditingController();
  late CaixaDeConsultaUsuario caixa;
  @override
  void initState() {
    super.initState();
    caixa = CaixaDeConsultaUsuario(nome: '', texto: widget.texto, context: context,funcao: widget.funcao,);
  }
  
  void _buscarUsuario(nome) {
    setState(() {
      caixa = CaixaDeConsultaUsuario(nome: nome, texto: widget.texto,context: context,funcao: widget.funcao,);   
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Consulta de usuarios'),
        ),
        body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              decoration:const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite o nome do usuário',
              ),
              onChanged: _buscarUsuario,
              controller: _nomeController,
            ),
            const SizedBox(height: 20),
            caixa.build(context),
          ],
        )));
  }
}
