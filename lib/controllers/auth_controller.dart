
class LoginController {
  final Map<String, String> _credentials = {
    'admin': 'admin123',
    'user': 'user123',
  };

  String? errorMessage;

  bool login(String username, String password) {
    if (_credentials.containsKey(username) && _credentials[username] == password) {
      errorMessage = null;
      // Do something after successful login
      print('Login successful as $username');
      return true;
    } else {
      errorMessage = 'Invalid username or password';
      return false;
    }
  }
}

void main() {
  LoginController loginController = LoginController();

  // Example usage:
  bool isAdminLoggedIn = loginController.login('admin', 'admin123');
  if (isAdminLoggedIn) {
    // Navigate to admin screen
  } else {
    print(loginController.errorMessage);
  }

  bool isUserLoggedIn = loginController.login('user', 'user123');
  if (isUserLoggedIn) {
    // Navigate to user screen
  } else {
    print(loginController.errorMessage);
  }
}
