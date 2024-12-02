import 'package:flutter/material.dart';
import 'package:login_app_bd/modelos/botao.dart';
import 'dart:io';
import '../telas/tela_ver_cardapio.dart';
import '../funções/compartilhar.dart';

class CaixaAlimento extends StatelessWidget{
  final Map<String, dynamic> item;
  final String texto;
  final Function funcao;
  const CaixaAlimento({super.key, required this.item,this.texto='-->', this.funcao = Compartilhar.compartilharAlimento});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: const Color.fromARGB(255, 75, 225, 10),
          body: Row(
          children: [
            Image.file(File(item['caminhoImagem']), width: 110, height: 110),
             Column(
              children: [
                Text(
                  item['nome'],
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  item['categoria'],
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  item['tipo'],
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ), 
            const SizedBox(width: 10),
            Botao(texto: texto, aoClicar: () => funcao(context, item['nome']), tamanho: const Size(130, 50)), 
          ],
        ),);
  }
}

class CaixaDeCardapio extends StatelessWidget{
  final Map<String, dynamic> usuario;
  const CaixaDeCardapio({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return CaixaDeUsuario(usuario: usuario, texto: 'Ver cardápio', funcao: (context, nomeUsuario)=> Navigator.push(context, MaterialPageRoute(builder: (context) => TelaVerCardapio(nomeUsuario: nomeUsuario))));
   }
  }

class CaixaDeUsuario extends StatelessWidget{
  final Map<String, dynamic> usuario;
  final String texto;
  final Function funcao;
  const CaixaDeUsuario({super.key,required this.usuario,this.texto='-->',this.funcao= Compartilhar.compartilharUsuario});

  String _calcularIdade(String dataNascimento) {
    final datanasc = dataNascimento.split('/');
    final data = DateTime.now();
    final diferenca = data.difference(DateTime(int.parse(datanasc[2]), int.parse(datanasc[1]), int.parse(datanasc[0])));
    return ('${(diferenca.inDays~/365).toString()} anos');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: const Color.fromARGB(255, 75, 225, 10),
          body: Row(
          children: [
            Image.file(File(usuario['caminhoImagem']), width: 110, height: 110),
            const SizedBox(width: 20),
             Column(
              children: [
                Text(
                  usuario['nome'],
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  usuario['datadenascimento'],
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  _calcularIdade(usuario['datadenascimento']),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ), 
            const SizedBox(width: 20),
            Botao(texto: texto, aoClicar: () => funcao(context, usuario['nome']), tamanho: const Size(130, 50))
          ],
        ),);
  }

}