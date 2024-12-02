import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final Function aoClicar;
  final Size tamanho;
  const Botao({Key? key, required this.texto, required this.aoClicar, this.tamanho = const Size(250,60)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          fixedSize: tamanho,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          aoClicar();
        },
        child: Text(texto, style: const TextStyle(fontSize: 17, color: Colors.black), textAlign: TextAlign.center),
      ),
    );
  }
}
