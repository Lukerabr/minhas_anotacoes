
class Anotacao{

  int? id;
  String titulo;
  String desccricao;
  String data;

  Anotacao(this.titulo, this.desccricao, this.data);

  Map toMap(){
    Map<String, dynamic> map = {
      "titulo" : this.titulo,
      "descricao" : this.desccricao,
      "data" : this.data
    };

    if(this.id != null){
      map["id"] = this.id;
    }

    return map;
  }

}