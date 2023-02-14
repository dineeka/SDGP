// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  Widget build(Object context) {
    return InitWidget();
  }

  Widget InitWidget() {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.orange,
                Colors.deepOrangeAccent
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset("images/app_logo_mod.png",
                  height: 140,
                  width: 140,
                ),
              ),
              SizedBox(
                height: 200,
              ),
              SpinKitWave(
                color: Colors.white,
                size: 38,
              ),
              SizedBox(
                height: 65,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child:
                    Text("by Nanozillas",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 19,
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
