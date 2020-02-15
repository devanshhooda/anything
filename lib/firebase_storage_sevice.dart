import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'firestore_path.dart';

class FirebaseStorageService {
  final String uid;
  FirebaseStorageService({@required this.uid}) : assert(uid != null);

  // Upload an avatar from file
  Future<String> uploadAvatar({@required File file}) async => await upload(
      file: file, contentType: 'image/png', path: FirestorePath.avatar(uid));

  // Generic file upload for any [path] and [contentType]
  Future<String> upload(
      {@required File file,
      @required String contentType,
      @required String path}) async {
    print('Uploading data of $uid to $path');
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(
        file, StorageMetadata(contentType: contentType));
    final snapshot = await uploadTask.onComplete;
    if (snapshot.error != null) {
      print('upload error : ${snapshot.error.toString()}');
      throw (snapshot.error);
    }

    // Url used to download file/image
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('Download url: $downloadUrl');
    return downloadUrl;
  }
}
