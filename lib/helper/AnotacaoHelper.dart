import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//padrão SINGLETOM
class AnotacaoHelper {

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();

  //adicionado late pois estava dizendo que uma instancia não nula precisava ser instanciada.
  late Database _db;

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
  
  

}

