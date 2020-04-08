import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase/firebase_service.dart';
import '../carro/carro.dart';

class FavoritoService {
  CollectionReference get _users => Firestore.instance.collection('users');
  CollectionReference get _carros =>
      _users.document(firebaseUserUid).collection('carros');

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

  Future<bool> deleteCarros() async {
    final query = await _carros.getDocuments();
    for (DocumentSnapshot document in query.documents) {
      await document.reference.delete();
    }

    _users.document(firebaseUserUid).delete();

    return true;
  }
}
