import 'package:flutter/material.dart';
import 'telas/tela_principal.dart';
import 'telas/tela_login.dart';
import 'telas/tela_creditos.dart';
import 'telas/tela_cadastro.dart';
import 'telas/tela_consulta.dart';
import 'telas/tela_cadastro_alimento.dart';
import 'telas/tela_cadastro_usuário.dart';
import 'telas/tela_cadastro_cardapio.dart';
import 'telas/tela_consulta_alimento.dart';
import 'telas/tela_consulta_usuario.dart';
import 'telas/tela_consulta_cardapio.dart';

class Rotas {
  static Map<String, Widget Function(BuildContext)> carregar() {
    return {
      '/login': (context) => const Login(),
      '/principal': (context) => const TelaPrincipal(),
      '/creditos': (context) => const TelaCreditos(),
      '/cadastrar': (context) => const TelaCadastro(),
      '/consultar': (context) => const TelaConsulta(),
      '/novo_alimento': (context) => const TelaCadastroAlimento(),
      '/novo_usuario': (context) => const TelaCadastroUsuario(),
      '/novo_cardapio': (context) => const TelaCadastroCardapio(),
      '/consultar_alimento': (context) => const TelaConsultaAlimento(),
      '/consultar_usuario': (context) => const TelaConsultaUsuario(),
      '/consultar_cardapio': (context) => const TelaConsultaCardapio(),
    };
  }
}
