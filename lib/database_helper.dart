
import 'package:sqflite/sqflite.dart' as sql;

class Database {
  // id: Chave primária do registro
  // email, senha: email e senha em sha-256 do registro
  // created_at: Data e hora da criação do registro.
static Future<void> createTables(sql.Database database) async {
  final tables = await database.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
  final tableNames = tables.map((table) => table['name'] as String).toSet();
  if (!tableNames.contains('alimentos')) {
    await database.execute("""CREATE TABLE alimentos (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nome TEXT UNIQUE,
      categoria TEXT,
      tipo TEXT,
      caminhoImagem TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }
  if (!tableNames.contains('usuarios')) {
    await database.execute("""CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      email TEXT,
      senha TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  if (!tableNames.contains('clientes')) {
    await database.execute("""CREATE TABLE clientes (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nome TEXT,
      datadenascimento TEXT,
      caminhoImagem TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
    }
    
  if (!tableNames.contains('cardapio')) {
    await database.execute("""CREATE TABLE cardapio (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nomeusuario TEXT,
      alimentos TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }
    if (!tableNames.contains('usuariologado')) {
    await database.execute("""CREATE TABLE usuariologado (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      email TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
    
  }
  
}
  // Cria e/ou conecta no Banco de Dados
static Future<sql.Database> database() async {
  final database = await sql.openDatabase(
    'banco_app.db',
    version: 1,
    onCreate: (sql.Database database, int version) async {
      await createTables(database);
    },
    onOpen: (database) async {
      await createTables(database);
    },
  );
  return database;
}
  // Insere um novo registro
  static Future<int> insereRegistro(String email, String senha) async {
    final database = await Database.database();
    final data = {'email': email, 'senha': senha};
    final id = await database.insert('usuarios', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Retorna um único registro através do e-mail
  static Future<List<Map<String, dynamic>>> retornaRegistro(
      String email) async {
    final database = await Database.database();
    return database.query('usuarios',
        where: "email = ?", whereArgs: [email], limit: 1);
  }

  static Future<int> insereAlimento(
      String nome, String categoria, String tipo, String caminho) async {
    final database = await Database.database();
    final data = {
      'nome': nome,
      'categoria': categoria,
      'tipo': tipo,
      'caminhoImagem': caminho
    };
    final id = await database.insert('alimentos', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Map<String, dynamic>>> retornaAlimentos(String nome) async {
    final database = await Database.database();
    return  await database.query("alimentos", where: "nome LIKE ?", whereArgs: ['%$nome%'],limit: 30);
  }
  static Future<Map<String, dynamic>> retornaAlimento(String nome) async {
    final database = await Database.database();
    final alimento = await database.query("alimentos", where: "nome = ?", whereArgs: [nome],limit: 1);
    return  alimento.first;
  }
  static Future<int> insereCliente(String nome, String datadenascimento,String caminho) async {
    final database = await Database.database();
    final data = {'nome': nome, 'datadenascimento': datadenascimento, 'caminhoImagem': caminho};
    final id = await database.insert('clientes', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> retornaClientes(String nome) async {
    final database = await Database.database();
    return await database.query('clientes', where: "nome LIKE ?", whereArgs: ['%$nome%'], limit: 30);
  }

  static Future<Map<String, dynamic>> retornaCliente(String nome) async {
    final database = await Database.database();
    final cliente = await database.query('clientes', where: "nome = ?", whereArgs: [nome], limit: 1);
    return cliente.first;

  }
  static Future<int> insereCardapio(String nomeDoUsuario, String listaAlimentos) async {
    final database = await Database.database();
    final data = {'nomeusuario': nomeDoUsuario, 'alimentos': listaAlimentos};
    final id = await database.insert('cardapio', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> retornaCardapios(String nome) async {
    final database = await Database.database();
    return await database.query('cardapio', where: "nomeusuario LIKE ?", whereArgs: ['%$nome%'], limit: 10);
  }

  static Future<Map<String, dynamic>> retornaCardapio(String nome) async {
    final database = await Database.database();
    final cardapio = await database.query('cardapio', where: "nomeusuario = ?", whereArgs: [nome], limit: 1);
    return cardapio.first;
  }

  static Future<int> updateUsuarioLogado(String email) async {
    final database = await Database.database();
    final data = {'email': email};
    final id = await database.update('usuariologado', data,where: "id = ?", whereArgs: [1],  conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  
  static Future<Map<String,dynamic>> retornaUsuarioLogado() async {
    final database = await Database.database();
    final usuario = await database.query('usuariologado', where: "id = ?", whereArgs: [1], limit: 1);
    final  email = usuario.first;
    return email;
  }
}
