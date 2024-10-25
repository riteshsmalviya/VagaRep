import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vagabondapp/screens/homepage.dart';
import 'package:vagabondapp/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  late NavigatorState _navigator;
  late ScaffoldMessengerState _scaffold;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    _scaffold = ScaffoldMessenger.of(context);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check if the Future is still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()), // Show loading spinner
          );
        }

        // If there was an error initializing Firebase
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
                child: Text('Error initializing Firebase: ${snapshot.error}')),
          );
        }

        // Firebase has been initialized successfully, build the LoginPage UI
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                final BoxConstraints constraints = BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width *
                      0.9, // 90% of screen width
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                );

                return SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: constraints,
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.language, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'Vagabond',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Welcome to Vagabond! Please sign in or create a new account.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                      ),
                                      child: const Text('Login'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // Navigate to the Register Page
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterPage()));
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        foregroundColor: Colors.black,
                                      ),
                                      child: const Text('Register'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _email,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Enter your email or username',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _password,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  // Try-catch block for login logic
                                  final email = _email.text;
                                  final password = _password.text;

                                  if (email.isEmpty || password.isEmpty) {
                                    _scaffold.showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please Enter Email And Password'),
                                      ),
                                    );
                                    return;
                                  }

                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );

                                    _navigator.pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    String errorMessage = 'An error occurred';
                                    if (e.code == 'invalid-credentials') {
                                      errorMessage = 'Invalid Credentials';
                                    } else if (e.code == 'wrong-password') {
                                      errorMessage = 'Incorrect Password';
                                    } else if (e.code == 'user-not-found') {
                                      errorMessage = 'User not Registered';
                                    } else {
                                      errorMessage = 'Try Again';
                                    }

                                    _scaffold.showSnackBar(
                                      SnackBar(
                                        content: Text(errorMessage),
                                      ),
                                    );
                                  }
                                }, // Call the login function
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: const Text('Submit'),
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: Text('Forgot password?'),
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text('Terms & Conditions'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
