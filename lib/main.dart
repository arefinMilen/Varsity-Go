import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/bus_detail_screen.dart';
import 'screens/map_screen.dart';
import 'screens/user_selection_screen.dart';
import 'screens/login_student.dart';
import 'screens/login_driver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase Initialization
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB31rW8OZ8uLkwdAjUteuNuSD2csAwZ8rM",
      authDomain: "varsitygo-a7c39.firebaseapp.com",
      projectId: "varsitygo-a7c39",
      storageBucket: "varsitygo-a7c39.firebasestorage.app",
      messagingSenderId: "636852455225",
      appId: "1:636852455225:web:735f100c53acc3336c0ae8",
    ),
  );

  runApp(const VarsityGoApp());
}

class VarsityGoApp extends StatelessWidget {
  const VarsityGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VarsityGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => HomeScreen(),
        '/bus': (context) => BusDetailScreen(),
        '/map': (context) => MapScreen(),
        '/selectUser': (context) => UserSelectionScreen(),
        '/loginStudent': (context) => LoginStudentScreen(),
        '/loginDriver': (context) => LoginDriverScreen(),
      },
    );
  }
}
