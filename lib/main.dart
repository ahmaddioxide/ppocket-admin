import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ppocket_admin/screens/admin/bug_reports_screen.dart';
import 'package:ppocket_admin/screens/qr_genration_screen.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BugReportsScreen()
    );
  }
}
