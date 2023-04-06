import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdgp/screens/cost_estimation.dart';
import 'package:sdgp/screens/home_screen.dart';
import 'package:sdgp/screens/login_screen.dart';
import 'package:sdgp/screens/home_screen_new.dart';
import 'package:sdgp/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdgp/utils/config.dart';
import 'package:sdgp/utils/next_screen.dart';
import 'package:sdgp/api/apiForNgrok.dart';
//import 'package:object_detection/tflite/classifier.dart';

import 'dart:io';
import 'dart:typed_data';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? pickedImage;
  late dynamic obj;

  @override
  void initState() {
    super.initState();
  }

  _setPicture(XFile photo) {
    setState(() {
      pickedImage = File(photo.path);
    });
  }

  Future<void> _getImgFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (photo != null) {
      _setPicture(photo);
    }
  }

  _getResult() async {
    obj = await Api.getPredict(pickedImage!);
    _nextScreen();
  }

  _nextScreen() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CostEstimation(value: obj)));
  }

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
                        //back button
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
                          "Upload Image",
                          style: kPageTitleStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _getImgFromGallery();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kIconColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(8.0),
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 80,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _getImgFromGallery();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kIconColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(8.0),
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera_enhance,
                                  size: 80,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        pickedImage != null
                            ? Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 300,
                                      width: 300,
                                      child: Image.file(pickedImage!),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 300,
                                      width: 300,
                                      child: Image(
                                        image:
                                            AssetImage(Config.upload_page_car),
                                        height: 300,
                                        width: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Spacer()
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _getResult();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kIconColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(8.0),
                            height: 120,
                            width: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.change_circle_outlined,
                                  size: 80,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Estimate",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      nextScreen(context, HomeScreenNew());
                    },
                    child: Text(
                      "       Cancel       ",
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
                  //proceed
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
