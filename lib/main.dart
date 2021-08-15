import 'dart:io';

import 'package:card_walet/Screens/Card%20Details%20Screen/card_details_screen.dart';
import 'package:card_walet/Screens/Home%20Screen/home_screen.dart';
import 'package:card_walet/Screens/Login%20Screen/login_screen.dart';
import 'package:card_walet/Screens/OTP%20Screen/otp_screen.dart';
import 'package:card_walet/Screens/Search%20Result%20Screen/search_result_screen.dart';
import 'package:card_walet/Screens/Signup%20Screen/signup_screen.dart';
import 'package:card_walet/Screens/Splash%20Screen/splash_screen.dart';
import 'package:card_walet/Services/connect_helper.dart';
import 'package:card_walet/Utility/enums.dart';
import 'package:card_walet/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final connectHelper = ConnectHelper();
  int _counter = 0;

  void _incrementCounter() async {
    final res = await connectHelper.makeRequest(
      'url',
      Request.GET,
      '',
      true,
      {
        'Content-Type': 'application/json',
      },
    );
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
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
        child: Icon(Icons.add),
      ),
    );
  }
}
