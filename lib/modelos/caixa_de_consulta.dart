import 'package:flutter/material.dart';
import 'caixa.dart';
import '../database_helper.dart';
class CaixaDeConsultaAlimento extends StatelessWidget {
  final String nome;
  final String texto;
  final Function funcao;
  final double size;
  final BuildContext context;
  final String? filtro;
  final List<String?>? lista;

  const CaixaDeConsultaAlimento({Key? key, required this.nome, this.size = 600, required this.texto, required this.funcao, required this.context, this.filtro, this.lista})
      : super(key: key);

  bool possui(List<String?> lista, String item){
    for (var i = 0; i < lista.length; i++) {
      if (lista[i] == item) {
        return true;
      }
    }       
    return false;
  }
  Future<List<Widget>> alimento(nome)async{
    final List<Map<String, dynamic>> alimentos = await Database.retornaAlimentos(nome); 
    List<Widget> caixasDeConsulta = [];
    for (var item in alimentos) {
      if(filtro != null){
        if(item['categoria'].contains(filtro!)){
          if(!possui(lista!,item['nome'])){
            caixasDeConsulta.add(const SizedBox(height: 20));
            caixasDeConsulta.add(SizedBox(
            height: 110,
            child: CaixaAlimento(item: item, texto: texto, funcao: funcao),
            ));
          }
        }
      }else{
      caixasDeConsulta.add(const SizedBox(height: 20));
      caixasDeConsulta.add(SizedBox(
        height: 110,
        child: CaixaAlimento(item: item, texto: texto, funcao: funcao),
      ));
      }
    }
    return caixasDeConsulta;
  }
 @override
 Widget build(BuildContext context) {
  return FutureBuilder(
    future: alimento(nome),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: size,
          child: ListView(
            children: snapshot.data!,
          ),
        );
      } else {
    return const SizedBox(
      child: CircularProgressIndicator(),
    );
  
  }
  }
  );
 }
} 

class CaixaDeConsultaUsuario extends StatelessWidget {
  final String nome;
  final String texto;
  final BuildContext context;
  final double size;
  final Function funcao;
  final bool apenas1;
  const CaixaDeConsultaUsuario({Key? key, required this.nome,required this.texto, required this.context, this.size = 600, required this.funcao , this.apenas1 = false})
      : super(key: key);

      static String calcularIdade(String dataNascimento) {
        final datanasc = dataNascimento.split('/');
        final data = DateTime.now();
        final diferenca = data.difference(DateTime(int.parse(datanasc[2]), int.parse(datanasc[1]), int.parse(datanasc[0])));
        return ('${(diferenca.inDays~/365).toString()} anos');
      }
  Future<List<Widget>> usuario(nome)async{
    final List<Map<String, dynamic>> clientes;
    if (apenas1 == false){
      clientes = await Database.retornaClientes(nome);
    }else{
      clientes = [await Database.retornaCliente(nome)];
    }
    
    List<Widget> caixasDeConsulta = [];
    for (var item in clientes) {
      caixasDeConsulta.add(const SizedBox(height: 20));
      caixasDeConsulta.add(SizedBox(
        height: 100,
        child: CaixaDeUsuario(usuario: item, texto: texto, funcao: funcao),
      ));
    }
    return caixasDeConsulta;
  }
 @override
 Widget build(BuildContext context) {
  return FutureBuilder(
    future: usuario(nome),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: size,
          child: ListView(
            children: snapshot.data!,
          ),
        );
      } else {
    return const SizedBox(
      child: CircularProgressIndicator(),
    );
  
  }
  }
  );
 }
}

class CaixaDeConsultaCardapio extends StatelessWidget {
  final String nome;
  final BuildContext context;
  const CaixaDeConsultaCardapio({Key? key, required this.nome, required this.context}) : super(key: key);

  Future<List<Widget>> cardapio(nome)async{
    final cardapios = await Database.retornaCardapios(nome);
    List<Widget> caixasDeConsulta = [];
    for (var item in cardapios) {
      final nomeUsuario = item['nomeusuario'];
      final usuario= await Database.retornaCliente(nomeUsuario);
      caixasDeConsulta.add(const SizedBox(height: 20));
      caixasDeConsulta.add(SizedBox(
        height: 100,
        child: CaixaDeCardapio(usuario: usuario)
      ));
    }
    return caixasDeConsulta;
  }
 @override
Widget build(BuildContext context) {
  return FutureBuilder(
    future: cardapio(nome),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: 400,
          child: ListView(
            children: snapshot.data!,
          ),
        );
      } else {
    return const SizedBox(
      child: CircularProgressIndicator(),
    );
  
  }
  }
  );
}
}