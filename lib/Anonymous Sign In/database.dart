import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference _userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String name, String address, String phn) async {
    return await _userCollection.document(uid).setData({
      'name': name,
      'address': address,
      'phone nmbr': phn
      // 'imageUrl': imageUrl
    });
  }

  Future<Stream<QuerySnapshot>> get users async {
    return _userCollection.snapshots();
  }
}
