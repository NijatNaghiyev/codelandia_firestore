import 'package:codelandia_firestore/firebase_options.dart';
import 'package:codelandia_firestore/screens/home_screen.dart';
import 'package:codelandia_firestore/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _screen = const LoginScreen();

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      _screen = const LoginScreen();
    } else {
      _screen = const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _screen,
    );
  }
}
