import 'package:build_anything/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Anonymous SignIn/auth_service.dart';
import 'mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        )
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Auth(),
      ),
    );
  }
}
