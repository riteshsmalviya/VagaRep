import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vagabondapp/firebase_options.dart';
import 'package:vagabondapp/screens/login.dart';
// import 'package:vagabond/screens/home_page.dart';
import 'package:vagabondapp/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Use the options for the current platform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vagabond',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          ThemeData.light().textTheme,
        ),
      ),
      home: const MainMenuPage(),
      routes: {
        '/home': (context) => const MainMenuPage(),
        '/loginpage': (context) => const LoginPage(),
      },
    );
  }
}
