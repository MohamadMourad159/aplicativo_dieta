import 'package:flutter/material.dart';

class CaixaDeTexto extends StatelessWidget {
  final String texto;
  final TextEditingController controller;

  const CaixaDeTexto({Key? key, required this.texto, required this.controller}) : super(key: key);
@override
  Widget build(BuildContext context) { return 
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(border: const OutlineInputBorder(), labelText: texto),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha o $texto';
          }
          return null;
        },
      ),
    );
  } 
}