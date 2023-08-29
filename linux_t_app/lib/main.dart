import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linux_terminal/screens/Login.dart';
import 'package:linux_terminal/screens/home.dart';

import 'screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'home': (context) => MyHome(),
        'login': (context) => MyLogin(),
        'register': (context) => MyRegister(),
      },
    );
  }
}
