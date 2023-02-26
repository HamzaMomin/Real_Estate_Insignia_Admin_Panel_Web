import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_application/property_check_dbms.dart';
import 'Firebase_auth/mobile_number.dart';
import 'Firebase_auth/verifiy_OTP_mobile_screen.dart';
import 'login.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBzvlZ3oCfm_JUs2ijmxN4nbGMtwA0FAb8",
          authDomain: "realestateinsignia.firebaseapp.com",
          databaseURL: "https://realestateinsignia-default-rtdb.firebaseio.com",
          projectId: "realestateinsignia",
          storageBucket: "realestateinsignia.appspot.com",
          messagingSenderId: "999701990661",
          appId: "1:999701990661:web:1e67307604fd858e7e3b6c",
          measurementId: "G-R2640F8HH5"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Real Estate Insigina'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MobileNumber();
  }
}
