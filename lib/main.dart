import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:moco_monitor/pages/login2.dart';

void main() {
  EncryptedSharedPreferences credstore = EncryptedSharedPreferences();

  runApp(MyApp(credstore: credstore));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.credstore}) : super(key: key);
  final EncryptedSharedPreferences credstore;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),p
        // home: LoginScreen(credstore: credstore));
        home: const Text("Eeee"));
  }
}
