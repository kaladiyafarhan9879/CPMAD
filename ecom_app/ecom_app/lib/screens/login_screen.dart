import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController unameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  bool isObscure = true;

  @override
  void dispose() {
    unameController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Username Input Field
            TextField(
              controller: unameController,
              decoration: const InputDecoration(
                hintText: 'Enter username',
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Password Input Field with Visibility Toggle
            TextField(
              controller: pwdController,
              obscureText: isObscure,
              decoration: InputDecoration(
                hintText: 'Enter password',
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Login Action Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                // Video validation logic: checks if username matches password and is not empty
                if (unameController.text.isNotEmpty &&
                    unameController.text == pwdController.text) {
                  // Save user session locally
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('username', unameController.text);

                  if (!mounted) return;

                  // Navigate to Dashboard
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid credentials! (Username and Password must match)'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Login', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}