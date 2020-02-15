import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'avatar_reference.dart';
import 'firestore_path.dart';

class FirestoreService {
  final String uid;
  FirestoreService({@required this.uid}) : assert(uid != null);

  //sets avatar download url
  Future setAvatarRefence(AvatarReference avatarReference) async {
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    await reference.setData(avatarReference.toMap());
  }

  //Reads the current avatar download url
  Stream<AvatarReference> avatarReferenceStream() {
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => AvatarReference.fromMap(snapshot.data));
  }
}
