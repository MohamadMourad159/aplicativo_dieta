import 'package:flutter/material.dart';
import '../modelos/botao.dart';
import '../modelos/caixa_de_texto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../database_helper.dart';
class TelaCadastroAlimento extends StatefulWidget {
  const TelaCadastroAlimento({super.key,});
  @override
  State<TelaCadastroAlimento> createState() => _TelaCadastroAlimentoState();
}

class _TelaCadastroAlimentoState extends State<TelaCadastroAlimento> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  File? _imagem;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagem = File(pickedFile.path);
      });
    }
  }

  Future<void> _salvar(File? image) async {
    if (image == null|| _nomeController.text.isEmpty|| _categoriaController.text.isEmpty|| _tipoController.text.isEmpty) return;
    final directory = await getApplicationDocumentsDirectory();
    final String caminho = '${directory.path}/${_nomeController.text}.png';
    await image.copy(caminho);
    await Database.insereAlimento(_nomeController.text, _categoriaController.text, _tipoController.text, caminho);
    if(mounted){
      Navigator.pop(context);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrar itens"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Insira os dados:", style: TextStyle(fontSize: 20)),
            CaixaDeTexto(texto: 'Nome', controller: _nomeController),
            CaixaDeTexto(texto: 'Categoria', controller: _categoriaController),
            CaixaDeTexto(texto: 'Tipo', controller: _tipoController),
            _imagem == null
                ? const Text("Nenhuma imagem selecionada")
                : Image.file(_imagem!, width: 250,height: 250),
            const SizedBox(height: 20),
            Botao(texto: "Selecionar imagem", aoClicar: _pickImage),
            const SizedBox(height: 20),
            Botao(texto: 'Cadastrar', aoClicar: () => _salvar(_imagem!)),
            const SizedBox(height: 10),
          ],
        ));
  }
}
