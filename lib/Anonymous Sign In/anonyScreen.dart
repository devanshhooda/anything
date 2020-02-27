import 'package:build_anything/Anonymous%20Sign%20In/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authService.dart';

class AnonymousSignIn extends StatelessWidget {
  // final String uid;
  // AnonymousSignIn({this.uid});
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _address = new TextEditingController();
  final TextEditingController _phn = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anonymous Signed In Page'),
        backgroundColor: Colors.brown,
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10),
            width: 400,
            child: new TextField(
              controller: _name,
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(10),
            width: 400,
            child: new TextField(
              controller: _address,
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(10),
            width: 400,
            child: new TextField(
              controller: _phn,
              style: TextStyle(fontSize: 25),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Phone no.',
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.blue,
            ),
            child: new MaterialButton(
              padding: EdgeInsets.all(20),
              onPressed: () {
                print('Anonymous Sign In');
                // print(_name.toString());
                // print(_address.toString());
                // print(_phn.toString());
                print(_name.text);
                print(_address.text);
                print(_phn.text);
                _anonymousSignIn(context, _name.text, _address.text, _phn.text);
              },
              child: new Text(
                'Sign In Anonymously',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.blue,
            ),
            child: new MaterialButton(
              padding: EdgeInsets.all(20),
              onPressed: () {
                print('Sign Out');
                _anonmousSignOut(context);
              },
              child: new Text(
                'Sign Out',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _anonymousSignIn(
      BuildContext context, String name, String address, String phn) async {
    final _auth = Provider.of<AuthService>(context, listen: false);
    return await _auth.signInAnon(name, address, phn);
  }

  Future _anonmousSignOut(BuildContext context) async {
    _name.clear();
    _phn.clear();
    _address.clear();
    final _auth = Provider.of<AuthService>(context, listen: false);
    return await _auth.signout();
  }
}
