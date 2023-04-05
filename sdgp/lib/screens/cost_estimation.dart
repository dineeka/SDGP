import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sdgp/screens/home_screen.dart';
import 'package:sdgp/screens/home_screen_new.dart';
import 'package:sdgp/screens/shops_near_me.dart';
import 'package:sdgp/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdgp/utils/config.dart';
import 'package:sdgp/utils/next_screen.dart';

class CostEstimation extends StatelessWidget {

  final Map<String, String> value;
  CostEstimation({super.key, required this.value});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.center,
              scale: 0.5,
              opacity: 0.1,
              image: AssetImage(Config.app_logo),
              fit: BoxFit.cover),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 240, 223, 189),
              Color.fromARGB(255, 217, 202, 106),
              Color.fromARGB(255, 215, 187, 94)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //Back button
                        GestureDetector(
                          onTap: () {
                            nextScreen(context, HomeScreenNew());
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: kIconColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Cost Estimation",
                          style: kPageTitleStyle,
                        ),
                        Text(
                           value.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Cancle button
                  TextButton(
                    onPressed: () {
                      nextScreen(context, HomeScreenNew());
                    },
                    child: Text(
                      "       Cancle       ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 160, 130, 13)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 239, 232, 205)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Color.fromARGB(255, 239, 232, 205),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  //Search for shop button
                  TextButton(
                    onPressed: () {
                      nextScreen(context, Shops());
                    },
                    child: Text(
                      "Search for shops",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 255, 255)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 160, 130, 13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 160, 130, 13))))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
