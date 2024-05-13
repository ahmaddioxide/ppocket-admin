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
        backgroundColor: const Color(0xff098670),
        title: const Text('POS Integration', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: double.infinity,),
            Image.asset('assets/ppocket_land.png', width: 250, height: 100,),
            SizedBox(
              width: 500.0,
              child: TextFormField(

                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),

                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 500,
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),

                ),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff098670),
                minimumSize: const Size(500, 55),


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