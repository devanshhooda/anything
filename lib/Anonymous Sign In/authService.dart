import 'package:build_anything/Anonymous%20Sign%20In/database.dart';
import 'package:build_anything/Anonymous%20Sign%20In/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user == null ? null : User(uid: user.uid);
  }

  Stream<User> get users {
    _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future signInAnon(String name, String address, String phn) async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name, address, phn);
      print(user.uid);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signout() async {
    return await _auth.signOut();
  }
}
