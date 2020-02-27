import 'package:build_anything/Anonymous%20Sign%20In/anonyScreen.dart';
import 'package:build_anything/Anonymous%20Sign%20In/authService.dart';
import 'package:build_anything/Phone%20Auth/phoneSignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Phone Auth/authService.dart';
import 'mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PhoneAuthService(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PhoneNumberScreen(),
      ),
    );
  }
}
