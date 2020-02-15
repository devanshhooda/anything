import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
class User {
  final String uid;
  User({@required this.uid});
}

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user == null ? null : User(uid: user.uid);
  }

  Future<User> anonymousSignIn() async {
    final authResult = await _auth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Stream<User> get onAuthStateChng {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }
}
