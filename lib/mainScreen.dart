import 'package:build_anything/Anonymous%20Sign%20In/authService.dart';
// import 'package:build_anything/Anonymous%20Sign%20In/ui.dart';
import 'package:build_anything/Anonymous%20Sign%20In/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Anonymous Sign In/anonyScreen.dart';
import 'Google SignIn/auth.dart';
import 'Google SignIn/ui.dart';

List<String> methods = ["Google Sign-In", "Facebook Sign-In", "Anonymously"];

List<Color> clr = [Colors.red, Colors.blue, Colors.white];

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text(
          'Authentication',
          style: TextStyle(color: Colors.cyanAccent, fontSize: 27),
        ),
        backgroundColor: Colors.black,
      ),
      body: new Center(
          child: new ListView.builder(
              itemCount: 3,
              itemBuilder: (context, int i) {
                return button(context, i);
              })),
    );
  }
}

void callAuthMethods(BuildContext context, int i) {
  if (i == 0) {
    try {
      if (googleSignIn() != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return GoogleUI();
        }));
      }
    } catch (e) {
      throw (e);
    }
  } else if (i == 1)
    print('Facebook Sign-In');
  else if (i == 2) {
    print('Anonymous Sign-in');
    _anonymousSignIn(context).whenComplete(() => Navigator.push(
        context, MaterialPageRoute(builder: (_) => AnonymousSignIn())));
  }
}

Widget button(BuildContext context, int i) {
  return new Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
    padding: EdgeInsets.only(top: 100, left: 50, right: 50),
    child: new OutlineButton(
      onPressed: () {
        callAuthMethods(context, i);
      },
      child: new Text(
        methods[i],
        style: TextStyle(
          color: clr[i],
          fontSize: 25,
        ),
      ),
    ),
  );
}

Future<User> _anonymousSignIn(BuildContext context) async {
  final _auth = Provider.of<AuthService>(context, listen: false);
  // return await _auth.signInAnon(name, address, phn);
}
