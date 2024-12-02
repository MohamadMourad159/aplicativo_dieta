import 'package:flutter/material.dart';
import 'package:login_app_bd/telas/tela_consulta_alimento.dart';
import 'package:login_app_bd/telas/tela_consulta_usuario.dart';
import '../modelos/botao.dart';
import '../modelos/caixa_de_consulta.dart';
import '../modelos/caixa.dart';
import '../database_helper.dart';
class TelaCadastroCardapio extends StatefulWidget {
  const TelaCadastroCardapio({super.key});
  @override
  State<TelaCadastroCardapio> createState() => _TelaCadastroCardapioState();
}

class _TelaCadastroCardapioState extends State<TelaCadastroCardapio> {
  String nomeUsuario = '';
  List<String?> nomeAlimentos = List<String?>.filled(12, null);
  String? resultado;
  String filtro = '';
   static void _retornar(context, nome){
    Navigator.pop(context, nome);
  }
  void _pegarUsuario(context, nome)async{
    resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TelaConsultaUsuario(texto: 'Selecionar', funcao: _retornar,),
      ),
    );
    setState(() {
      if(resultado!=null){
        nomeUsuario = resultado!;
      }   
    });
  }
  void _pegarAlimento(context,i)async{
    if(i<=2){
      filtro = 'cafe da manha';
    }else if(i<=7){
      filtro = 'almoço';
    }else{
      filtro = 'jantar';
    }
    resultado = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  TelaConsultaAlimento(texto: 'Selecionar', funcao: _retornar,filtro: filtro,lista: nomeAlimentos),
              ),
    );
    setState(() {
      if(resultado!=null){
        nomeAlimentos[i] = resultado;
      }
    });
  }
  Widget buildCaixaAlimento(int index) {
    return SizedBox(
      height: 120,
      child: FutureBuilder(
        future: Database.retornaAlimento(nomeAlimentos[index]!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CaixaAlimento(
              item: snapshot.data!,
              texto: 'Trocar',
              funcao: (context, nome) => _pegarAlimento(context, index),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
  void _salvarCardapio(){
    for (int i = 0; i < 12; i++) {
      if (nomeAlimentos[i] == null) {
        return;
      }
    }
    String listaAlimentos = '';
    for (int i = 0; i < 12; i++) {
      listaAlimentos +=  '${nomeAlimentos[i]};';  
    }
    Database.insereCardapio(nomeUsuario,listaAlimentos);
    Navigator.pop(context);
  }

  BotaoOuCaixa(int index){
    if (nomeAlimentos[index] == null) {
      return Botao(texto: 'Selecionar alimento', aoClicar: () =>_pegarAlimento(context, index));
    } else {
      return buildCaixaAlimento(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar cardapio"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Text("Selecione o usuario:", style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
          nomeUsuario == ''
              ? Botao(texto: 'Selecionar usuário', aoClicar: () =>_pegarUsuario(context, nomeUsuario))
              : CaixaDeConsultaUsuario(nome: nomeUsuario, context: context, size: 140, texto: 'Trocar', funcao:_pegarUsuario ,apenas1: true,),
          const SizedBox(height: 20),
          const Text("Selecione o café da manhã:", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
          BotaoOuCaixa(0),
          BotaoOuCaixa(1),
          BotaoOuCaixa(2),
          const Text("Selecione o almoço:", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
          BotaoOuCaixa(3),
          BotaoOuCaixa(4),
          BotaoOuCaixa(5),
          BotaoOuCaixa(6),
          BotaoOuCaixa(7),
          const Text("Selecione o jantar:", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
          BotaoOuCaixa(8),
          BotaoOuCaixa(9),
          BotaoOuCaixa(10),
          BotaoOuCaixa(11), 
          const SizedBox(height: 20),
          Botao(texto: 'Cadastrar', aoClicar: () => _salvarCardapio()),
        ],
      )
    );
  }
}
