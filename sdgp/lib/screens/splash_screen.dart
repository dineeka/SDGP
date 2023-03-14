import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sdgp/provider/sign_in_provider.dart';
import 'package:sdgp/screens/home_screen.dart';
import 'package:sdgp/screens/login_screen.dart';
import 'package:sdgp/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/next_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();

    //create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSingedIn == false
          ? nextScreen(context, const LoginScreen())
          : nextScreen(context, const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Config.splash_background), fit: BoxFit.cover),
      ),
      child: Column(
        children: const [
          SizedBox(
            height: 550,
          ),
          SpinKitWave(
            color: Colors.white,
            size: 30,
          )
        ],
      ),
    );
  }
}
