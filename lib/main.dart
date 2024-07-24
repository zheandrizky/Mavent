import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mavent/firebase_options.dart';
import 'package:mavent/ui/pages/homepage/home_page.dart';
import 'package:mavent/ui/pages/sign_in_up/login_page.dart';
import 'package:mavent/ui/pages/sign_in_up/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mavent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'PlusJakartaSans',
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/event_homepage': (context) => HomePage(),
      },
    );
  }
}
