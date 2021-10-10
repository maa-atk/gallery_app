import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '/google_sign.dart';
import 'package:gallery_app/pages/gallerytilepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage('assets/start.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GalleryTiles(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
