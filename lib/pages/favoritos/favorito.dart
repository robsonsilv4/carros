import '../../utils/sql/entity.dart';
import '../carro/carro.dart';

class Favorito extends Entity {
  int id;
  String nome;

  Favorito.fromCarro({Carro carro}) {
    id = carro.id;
    nome = carro.nome;
  }

  Favorito.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
