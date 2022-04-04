import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/splach_screen.dart';
import './screens/chat_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialize = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialize,
      builder: (ctx, snapshot) => MaterialApp(
          title: 'Flutter Chat',
          theme: ThemeData(
              primarySwatch: Colors.pink,
              backgroundColor: Colors.pink,
              accentColor: Colors.deepPurple,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
          home: snapshot.connectionState == ConnectionState.done
              ? StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.hasData) {
                      return ChatScreen();
                    }
                    return AuthScreen();
                  })
              : SplashScreen()),
    );
  }
}
