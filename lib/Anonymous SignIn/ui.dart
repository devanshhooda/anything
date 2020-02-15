import 'package:build_anything/Anonymous%20SignIn/avatar.dart';
import 'package:build_anything/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../avatar_reference.dart';
import '../firebase_storage_sevice.dart';
import '../firestore_service.dart';
import '../image_picker.dart';
import 'auth_service.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<User>(
        stream: authService.onAuthStateChng,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            return user != null ? HomePage() : Auth();
          }
          return new Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

class HomePage extends StatelessWidget {
  Future<void> _onLogOut(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // Get the image file from gallery
      final imagePicker =
          Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);

      // Uploading it to storage
      final storage =
          Provider.of<FirebaseStorageService>(context, listen: false);
      final downloadUrl = await storage.uploadAvatar(file: file);

      // Save url to firestore
      final database = Provider.of<FirestoreService>(context);
      await database.setAvatarRefence(AvatarReference(downloadUrl));

      await file.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: new Text(
          'Home',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        leading: new IconButton(
            icon: Icon(Icons.help), onPressed: () => print('About button')),
        actions: <Widget>[
          new FlatButton(
              onPressed: () => _onLogOut(context),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: _buildUserAvatar(context)),
      ),
      body: Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Welcome',
            style: TextStyle(fontSize: 30),
          ),
        ],
      )),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    final database = Provider.of<FirestoreService>(context, listen: false);
    return StreamBuilder<AvatarReference>(
        stream: database.avatarReferenceStream(),
        builder: (context, snapshot) {
          final avatarReference = snapshot.data;
          return Avatar(
            photoUrl: avatarReference?.downloadUrl,
            radius: 50,
            borderClr: Colors.black54,
            borderWidth: 2.0,
            onPressed: () => _chooseAvatar(context),
          );
        });
  }
}
