import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
String name, email, imageUrl;

Future<String> googleSignIn() async {
  final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication _googleAuthentication =
      await _googleSignInAccount.authentication;

  final AuthCredential _credential = GoogleAuthProvider.getCredential(
      idToken: _googleAuthentication.idToken,
      accessToken: _googleAuthentication.accessToken);

  final AuthResult _result = await _auth.signInWithCredential(_credential);

  final FirebaseUser _user = _result.user;

  assert(!_user.isAnonymous);
  assert(_user.getIdToken() != null);

  // final FirebaseUser currentUser = await _auth.currentUser();

  // assert(currentUser == _user);
  assert(_user.email != null);
  assert(_user.displayName != null);
  assert(_user.photoUrl != null);

  email = _user.email;
  name = _user.displayName;
  imageUrl = _user.photoUrl;

  return _user == null ? null : _user.uid;
}

Future googleSignOut() async {
  await _googleSignIn.signOut();
  print('User Signed Out !!!');
}
