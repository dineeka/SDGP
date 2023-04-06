// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sdgp/screens/camera_screen.dart';
import 'package:sdgp/screens/cost_estimation.dart';
import 'package:sdgp/screens/home_screen.dart';
import 'package:sdgp/screens/login_screen.dart';
import 'package:sdgp/screens/upload_image_screen.dart';
import 'package:sdgp/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdgp/utils/config.dart';
import 'package:sdgp/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/provider/sign_in_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:sdgp/utils/next_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePage> {
  Widget appBarTitle = new Text("Main Page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: appBarTitle,
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.orangeAccent,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Choose your requirments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 63, 63, 63),
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Image.asset('assets/damagedetectionpic.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Detect Damage',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Image.asset('assets/repairshop.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nearby Shops',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Image.asset('assets/repairshop.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
