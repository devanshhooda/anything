import 'package:build_anything/Anonymous%20Sign%20In/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// enum Status { Authenticated, Authenticating, Unauthenticated, Uninitialiased }

class PhoneAuthService {
  String verificationId, smsCode;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get users {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> verifyNumber(String phoneNo) async {
    try {
      final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout =
          (String verId) {
        this.verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
      };

      final PhoneVerificationCompleted verified =
          (AuthCredential credential) async {
        AuthResult _result = await _auth.signInWithCredential(credential);
        FirebaseUser _user = _result.user;
        return _userFromFirebase(_user);
      };

      final PhoneVerificationFailed failed = (AuthException e) {
        print('phone verification exception: ${e.message}');
      };

      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNo,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verified,
          verificationFailed: failed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: autoRetrievalTimeout);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
