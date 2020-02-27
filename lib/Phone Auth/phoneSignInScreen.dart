import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authService.dart';

class PhoneNumberScreen extends StatelessWidget {
  TextEditingController _phn = new TextEditingController();
  TextEditingController _name = new TextEditingController();

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
          // new Container(
          //   padding: EdgeInsets.all(10),
          //   width: 400,
          //   child: new TextField(
          //     controller: _address,
          //     style: TextStyle(fontSize: 25),
          //     decoration: InputDecoration(
          //       labelText: 'Address',
          //     ),
          //   ),
          // ),
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
                print('Phone Number Sign In');
                print(_name.text);
                print(_phn.text);
                _phoneAuth(context, _phn.text);
              },
              child: new Text(
                'Get OTP',
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
                _signOutPhone(context);
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
}

Future _phoneAuth(BuildContext context, String phnNo) async {
  final _auth = Provider.of<PhoneAuthService>(context, listen: false);
  return await _auth.verifyNumber(phnNo);
}

Future _signOutPhone(BuildContext context) async {
  final _auth = Provider.of<PhoneAuthService>(context, listen: false);
  return await _auth.signOut();
}
