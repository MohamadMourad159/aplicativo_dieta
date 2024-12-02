import 'package:flutter/material.dart';
import '../modelos/caixa_de_consulta.dart';
import '../funções/compartilhar.dart';

class TelaConsultaAlimento extends StatefulWidget {
  final String texto;
  final Function funcao;
  final String? filtro;
  final List<String?>? lista;
  const TelaConsultaAlimento({super.key, this.texto = '-->', this.funcao = Compartilhar.compartilharAlimento, this.filtro, this.lista});
  @override
  State<TelaConsultaAlimento> createState() => _TelaConsultaAlimentoState();
}
class _TelaConsultaAlimentoState extends State<TelaConsultaAlimento> {
  final TextEditingController _nomeController = TextEditingController();
  late CaixaDeConsultaAlimento caixa;
  @override
    void initState() {
    super.initState();
    caixa = CaixaDeConsultaAlimento(nome: '', context: context,funcao: widget.funcao,texto: widget.texto,filtro: widget.filtro,lista: widget.lista,);
  }
  void _buscarAlimento(texto) {
    setState(() {
      caixa = CaixaDeConsultaAlimento(nome: texto, context: context,funcao: widget.funcao,texto: widget.texto, filtro: widget.filtro,lista: widget.lista,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Consulta de alimentos'),
        ),
        body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              decoration:const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite o nome do alimento',
              ),
              onChanged: _buscarAlimento,
              controller: _nomeController,
            ),
            const SizedBox(height: 20),
            caixa.build(context),
          ],
        )));
  }
}
