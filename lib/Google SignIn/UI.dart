import 'package:flutter/material.dart';
import '../mainScreen.dart';
import 'Auth.dart';

class GoogleUI extends StatelessWidget {
  final TextStyle col = new TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      letterSpacing: 4);

  final TextStyle eP = new TextStyle(
      color: Colors.blueAccent, fontSize: 25, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.red, Colors.white])),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  height: 40,
                ),
                new Text('NAME', style: col),
                new Text(name, style: eP),
                SizedBox(
                  height: 20,
                ),
                new Text(
                  'EMAIL',
                  style: col,
                ),
                new Text(
                  email,
                  style: eP,
                ),
                SizedBox(
                  height: 50,
                ),
                signOutButton(context)
              ],
            ),
          )),
    );
  }
}

Widget signOutButton(BuildContext context) {
  return new Container(
    child: new RaisedButton(
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: new Text(
        'Sign Out',
        style: TextStyle(fontSize: 15, color: Colors.white70),
      ),
      onPressed: () {
        CircularProgressIndicator(
          backgroundColor: Colors.white,
        );
        googleSignOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return Auth();
        }), ModalRoute.withName('/'));
      },
    ),
  );
}
