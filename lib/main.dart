import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'google_sign.dart';
import 'package:gallery_app/pages/loginpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'G_app';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(primarySwatch: Colors.indigo),
          // home: GalleryTiles(),
          home: Login(),
        ),
      );
}
