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
  final dynamic value;
  const CostEstimation({super.key, required this.value});

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
                            nextScreen(context, const HomeScreenNew());
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
                      ],
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   height: 400,
                    //   width: 400,
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Severity : " + _costInput(),
                      style: kTesxtStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Estimation Range : " + _cost(),
                      style: kTesxtStyle,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage(Config.bottom_logo),
                          height: 180,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(Config.name_logo),
                          height: 120,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Cancel button
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

  String getSubstringBetweenChars(
      String str, String startChar, String endChar) {
    int startIndex = str.indexOf(startChar);
    int endIndex = str.indexOf(endChar, startIndex + 1);
    if (startIndex != -1 && endIndex != -1) {
      return str.substring(startIndex + 1, endIndex);
    } else {
      return " "; // or an empty string, or throw an exception, depending on your use case
    }
  }

  _cost() {
    String price = value.toString();
    String input = getSubstringBetweenChars(price, "{", ":");
    String output;
    String damageInText;
    switch (input) {
      case 'crack_and_hole':
        damageInText = "crack and hole";
        output = '2000 - 3000';
        break;
      case 'medium_deformation':
        damageInText = "medium_deformation";
        output = '5000 - 7000';
        break;
      case 'severe_deformation':
        output = '3000 - 4000';
        break;
      case 'severe_scratch':
        output = '7000 - 8000';
        break;
      case 'slight_deformation':
        output = '4000 - 6000';
        break;
      case 'slight_scratch':
        output = '2000 - 3000';
        break;
      case 'windshield_damage':
        output = '8000 - 9000';
        break;
      default:
        output = 'Invalid input';
    }
    return output;
  }

  _costInput() {
    String price = value.toString();
    String input = getSubstringBetweenChars(price, "{", ":");
    String output;
    String damageInText;
    switch (input) {
      case 'crack_and_hole':
        damageInText = "crack and hole";
        output = '2000 - 3000';
        damageInText = "crack and hole";
        break;
      case 'medium_deformation':
        damageInText = "medium_deformation";
        output = '5000 - 7000';
        damageInText = "medium deformation";
        break;
      case 'severe_deformation':
        output = '3000 - 4000';
        damageInText = "severe deformation";
        break;
      case 'severe_scratch':
        output = '7000 - 8000';
        damageInText = "severe scratch";
        break;
      case 'slight_deformation':
        output = '4000 - 6000';
        damageInText = "slight deformation";
        break;
      case 'slight_scratch':
        output = '2000 - 3000';
        damageInText = "slight scratch";
        break;
      case 'windshield_damage':
        output = '8000 - 9000';
        damageInText = "windshield damage";
        break;
      default:
        output = 'Invalid input';
        damageInText = "";
    }
    return damageInText;
  }
}
