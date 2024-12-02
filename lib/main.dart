import 'package:flutter/material.dart';
import 'rotas.dart';
import 'telas/tela_login.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nutribom',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Login(),
        routes: Rotas.carregar());
  }
}
