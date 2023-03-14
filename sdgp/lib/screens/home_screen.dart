import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/provider/sign_in_provider.dart';
import 'package:sdgp/screens/login_screen.dart';
import 'package:sdgp/utils/next_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text("SIGNOUT"),
        onPressed: () {
          sp.userSignOut();
          nextScreenReplace(context, const LoginScreen());
        },
      )),
    );
  }
}
