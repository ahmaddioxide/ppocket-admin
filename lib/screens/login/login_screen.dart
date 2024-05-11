import 'package:flutter/material.dart';
import 'package:ppocket_admin/controllers/auth_controller.dart';
import 'package:ppocket_admin/screens/admin/bug_reports_screen.dart';
import 'package:ppocket_admin/screens/qr_genration_screen.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (_loginController.login(username, password)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (username == 'admin') {
              return BugReportScreen();
            } else {
              return const QrGenerationScreen();
            }
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_loginController.errorMessage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: _login,
              child: const Text('Login', 
              style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}