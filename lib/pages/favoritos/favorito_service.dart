import 'package:cloud_firestore/cloud_firestore.dart';

import '../carro/carro.dart';

class FavoritoService {
  CollectionReference get _carros => Firestore.instance.collection('carros');
  Stream<QuerySnapshot> get stream => _carros.snapshots();

  Future<bool> favoritar(Carro carro) async {
    DocumentReference documentReference = _carros.document('${carro.id}');
    DocumentSnapshot document = await documentReference.get();
    bool exists = document.exists;

    if (exists) {
      documentReference.delete();
      return false;
    } else {
      documentReference.setData(carro.toJson());
      return true;
    }
  }

  Future<bool> isFavorito(Carro carro) async {
    DocumentReference documentReference = _carros.document('${carro.id}');
    DocumentSnapshot document = await documentReference.get();
    bool exists = document.exists;
    return exists;
  }
}
