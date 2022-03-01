import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:moco_monitor/pages/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

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
      ),
      home: LoginScreen(credstore: credstore),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.credstore})
      : super(key: key);

  final EncryptedSharedPreferences credstore;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // void storage() async {
  //   debugPrint("1");
  //   const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  //   debugPrint("2");

  //   // var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  //   debugPrint("3");
  //   // if (!containsEncryptionKey) {
  //   var key = Hive.generateSecureKey();
  //   // await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  //   // }
  //   debugPrint("4");

  //   // var encryptionKey =
  //   // await base64Url.decode(await secureStorage.read(key: 'key').toString());
  //   // debugPrint('Encryption key: $encryptionKey');
  //   debugPrint('Encryption key: $key');
  //   debugPrint("5");
  //   var encryptedBox = await Hive.openBox('vaultBox',
  //       // encryptionCipher: HiveAesCipher(encryptionKey));
  //       encryptionCipher: HiveAesCipher(key));
  //   encryptedBox.put('secret', 'Hive is cool');
  //   debugPrint("6");
  //   debugPrint(encryptedBox.get('secret'));
  // }

  @override
  Widget build(BuildContext context) {
    // storage();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // LoginScreen(credstore: credstore),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
