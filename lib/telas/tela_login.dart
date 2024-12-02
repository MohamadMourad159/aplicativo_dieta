import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // usuário que foi retornado pelo banco de dados
  List<Map<String, dynamic>> _usuario = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Mostra a janela modal que permite a criação de um novo usuário
  void _showForm() async {
    _emailController.text = '';
    _passwordController.text = '';

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // Isso impedirá que o teclado programável cubra os campos de texto
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Salva o registro
                      await _insereRegistro();

                      // Limpa os campos
                      _emailController.text = '';
                      _passwordController.text = '';

                      // Fecha o modal de inserção/alteração
                      Navigator.of(context).pop();
                    },
                    child: const Text('Novo Usuário'),
                  )
                ],
              ),
            ));
  }

  // Calcula um hash da senha digitada pelo usuário
  String _calcularHash(String password) {
    var passwordInBytes = utf8.encode(password);
    return sha256.convert(passwordInBytes).toString();
  }

  // Busca um usuário com base no e-mail no banco de dados
  Future<void> _buscaUsuario(String email) async {
    final data = await Database.retornaRegistro(email);
    _usuario = data;
  }

  // Insere um novo registro
  Future<void> _insereRegistro() async {
    String passwordHash = _calcularHash(_passwordController.text);
    await Database.insereRegistro(_emailController.text, passwordHash);
  }

  // Função chamada para realizar o processo de login
  void _login() {
    if (_formKey.currentState!.validate()) {
      _buscaUsuario(_emailController.text).then((success) {
        // escrevo o que fazer em caso de sucesso
      }).onError((error, stack) {
        // escrevo o que fazer em caso de erro
      }).whenComplete(() {
        // escrevo o que fazer independente de erro ou sucesso
        final registro = _usuario
            .where((element) => element['email'] == _emailController.text);
        if (registro.isNotEmpty) {
          String passwordHash = _calcularHash(_passwordController.text);
          var user = registro.elementAt(0);
          if (_emailController.text == user['email'] && passwordHash == user['senha']) {
              if (mounted){
                Database.updateUsuarioLogado(_emailController.text);
                Navigator.pushNamed(context, "/principal");
              }
          } else {
            if (mounted){
               ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Credenciais Inválidas')),
            );  
            }
          }
        } else {
          if (mounted){
             ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário Inexistente')),
          );
          }
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha as informações')),
      );
    }
  }
  void verificarUsuarioLogado(context)async{
    final data = await Database.retornaUsuarioLogado();
    if(data['email']!= ''){
      Navigator.pushNamed(context, "/principal");
    }
  }
  @override
  void initState() {
    super.initState();
     verificarUsuarioLogado(context);
  }

  // Interface gráfica
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nutribom"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha a senha';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                    child: Center(
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Entrar'),
                    ),
                  ),
                ),
                Padding(
                  padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                    child: Center(
                    child: ElevatedButton(
                      onPressed: _showForm,
                      child: const Text('Cadastre-se'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
