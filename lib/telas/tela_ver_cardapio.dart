import 'package:flutter/material.dart';
import '../modelos/botao.dart';
import '../modelos/caixa.dart';
import '../database_helper.dart';
import '../funções/compartilhar.dart';
class TelaVerCardapio extends StatelessWidget {
  final String nomeUsuario;
  const TelaVerCardapio({super.key, required this.nomeUsuario});

  Future<List<Widget>> cardapio(String nome)async{
    List<Widget> caixasDeConsulta = [];
    final usuario = await Database.retornaCliente(nome);
    final cardapio = await Database.retornaCardapio(nome);
    final List<String> nomesAlimentos = cardapio['alimentos'].split(';');
    caixasDeConsulta.add(const SizedBox(height: 50, child: Text('usuário',textAlign: TextAlign.center, style:TextStyle(fontSize: 30)),));
    caixasDeConsulta.add(SizedBox(
      height: 100,
      child: CaixaDeUsuario(
        usuario: usuario,
        funcao: (context, nome) => Compartilhar.compartilharUsuario(context, nome),
        ),
    ));

    caixasDeConsulta.add(const SizedBox(height: 50, child: Text('Café da manhã',textAlign: TextAlign.center, style:TextStyle(fontSize: 30)),));
    for(int i = 0; i < 3; i++){
      caixasDeConsulta.add(SizedBox(
        height: 110,
        child: CaixaAlimento(
          item: await Database.retornaAlimento(nomesAlimentos[i]),
          ),
      ));
    }

    caixasDeConsulta.add(const SizedBox(height:50, child: Text('Almoço',textAlign: TextAlign.center, style:TextStyle(fontSize: 30)),));
    for(int i = 3; i < 8; i++){
      caixasDeConsulta.add(SizedBox(
        height: 110,
        child: CaixaAlimento(
          item: await Database.retornaAlimento(nomesAlimentos[i]),
          ),
      ));
    }

    caixasDeConsulta.add(const SizedBox(height: 50, child: Text('Jantar', textAlign: TextAlign.center, style:TextStyle(fontSize: 30)),));
    for(int i = 8; i < 12; i++){
       caixasDeConsulta.add(SizedBox(
        height: 110,
        child: CaixaAlimento(
          item: await Database.retornaAlimento(nomesAlimentos[i]),
          ),
      ));
    }
    caixasDeConsulta.add(SizedBox(height: 100, child:Botao(texto: 'Compartilhar cardápio', aoClicar: () => Compartilhar.compartilharCardapio('context', nome))));
    return caixasDeConsulta;
  }

  @override
   Widget build(BuildContext context) {
    return FutureBuilder(
      future: cardapio(nomeUsuario), 
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
          appBar: AppBar(
            title: Text("Cardapio do $nomeUsuario"),
          ),
          body: ListView(children: snapshot.data!),
          );
       
        }else{
          return const CircularProgressIndicator();
        }
           
      }
    );
  }
}