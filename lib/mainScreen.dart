import 'package:build_anything/Anonymous%20SignIn/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Anonymous SignIn/auth_service.dart';
import 'Google SignIn/Auth.dart';
import 'Google SignIn/UI.dart';

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
    googleSignIn().whenComplete(() {
      CircularProgressIndicator(
        backgroundColor: Colors.white,
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return GoogleUI();
      }));
    });
  } else if (i == 1)
    print('Facebook Sign-In');
  else if (i == 2) {
    _signInAnonymously(context);
    print('Anonymous Sign-in');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AuthWidget();
    }));
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

Future<void> _signInAnonymously(BuildContext context) async {
  try {
    final auth = Provider.of<FirebaseAuthService>(context, listen: false);
    final user = await auth.anonymousSignIn();
    print('uid: ${user.uid}');
  } catch (e) {
    print(e.toString());
  }
}
