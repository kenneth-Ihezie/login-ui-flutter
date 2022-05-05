import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/views/HomeScreen.dart';
import 'package:login_ui/views/UpdateNoteScreen.dart';
import 'Theme.dart';
import '../views/ForgotPassword.dart';
import '../views/LoginScreen.dart';
import '../views/NoteScreen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LoginUI",
      theme: defaultTargetPlatform == TargetPlatform.iOS ? KIOSTheme : KDefaultTheme,
      routes: <String, WidgetBuilder>{
        '/homeScreen' : (BuildContext context) => HomeScreen(),
        '/forgotPassword' : (BuildContext context) => ForgotPassword(),
        '/noteScreen': (BuildContext context) => NoteScreen(),
        '/updateNoteScreen':(BuildContext context) => UpdateNoteScreen()
      },
      home: LoginScreen(),
    );
  }
}