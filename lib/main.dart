import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ppocket_admin/screens/login/login_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // WidgetsBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPocket POS Integration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
