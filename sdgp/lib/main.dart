import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sdgp/provider/internet_provider.dart';
import 'package:sdgp/provider/sign_in_provider.dart';
import 'package:sdgp/screens/camera_screen.dart';
import 'package:sdgp/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/screens/upload_image_screen.dart';

void main() async {
  //Initialize the application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: const MaterialApp(
        home: UploadImageScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
