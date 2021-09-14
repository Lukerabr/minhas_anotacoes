import 'package:minhas_anotacoes/model/Anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//padrão SINGLETOM
class AnotacaoHelper {

  static final String nomeTabela = "anotacao";
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();

  //adicionado ? pois estava dizendo que uma instancia não nula precisava ser instanciada.
  //se colocar late ele da ruim.
  Database? _db;

  factory AnotacaoHelper(){
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal(){
  }

  get db async{

    if(_db != null){
      return _db;
    }else{
      _db = await inicializarDB();
      return _db;
    }

  }

  _onCreate(Database db, int version) async {

    String sql = "CREATE TABLE anotacao (id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "titulo VARCHAR, "
        "descricao TEXT, "
        "data DATETIME)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco_minhas_anotacoes.db");

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {

    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, anotacao.toMap());
    return resultado;

  }
  
  

}

