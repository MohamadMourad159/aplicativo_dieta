import 'package:share_plus/share_plus.dart';
import '../database_helper.dart';
import '../modelos/caixa_de_consulta.dart';

class Compartilhar {
  static Future<String> alimentoParaString(nomeAlimento)async{
    final alimento = await Database.retornaAlimento(nomeAlimento);
    String texto = '\nNome: $nomeAlimento\nCategoria: ${alimento['categoria']}\nTipo: ${alimento['tipo']}';
    
    return texto;
  }
  static void compartilharAlimento(context, nome) async {
    final alimento = await Database.retornaAlimento(nome);
    final texto = 'Nome: $nome\nCategoria: ${alimento['categoria']}\nTipo: ${alimento['tipo']}';
    Share.share(texto);
  }
  static void compartilharCardapio(context, nome) async {
    final cardapio = await Database.retornaCardapio(nome);
    final List<String> alimentos = cardapio['alimentos'].split(';');
    for(int i = 0; i < 12; i++){
      alimentos[i] = await alimentoParaString(alimentos[i]);
    }
    final cafeDaManha = alimentos.sublist(0, 3).join('\n');
    final almoco = alimentos.sublist(3, 8).join('\n');
    final jantar= alimentos.sublist(8, 12).join('\n');
    final texto = 'Nome do usuário: $nome\n\nAlimentos:\n\nCafé da manhã:\n$cafeDaManha\n\nAlmoco:\n$almoco\n\nJantar:\n$jantar';
    Share.share(texto);
  }
  static void compartilharUsuario(context, nome) async {
    final cliente = await Database.retornaCliente(nome);
    final texto = 'Nome: $nome\nData de nascimento: ${cliente['datadenascimento']}\nIdade: ${CaixaDeConsultaUsuario.calcularIdade(cliente['datadenascimento'])}';
    Share.share(texto);
  }
}