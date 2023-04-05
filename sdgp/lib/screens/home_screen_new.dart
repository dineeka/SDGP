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

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    _controller = VideoPlayerController.asset('assets/VideoTutorial.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey _scaffoldKey1 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey1,
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
                            setState(() {});
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
                          "Instructions",
                          style: kPageTitleStyle,
                        ),
                      ],
                    ),
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return VideoPlayer(_controller);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    /*Image(
                      image: AssetImage("assets/car1.png"),
                      height: 350,
                      width: 400,
                      fit: BoxFit.cover,
                    ),*/
                    Row(
                      children: const [
                        Icon(
                          Icons.circle_outlined,
                          color: kIconColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Adjust focus and exposure for the perfect photos",
                          style: TextStyle(color: kIconColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.circle_outlined,
                          color: kIconColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Use gridlines to balance your shot.",
                          style: TextStyle(color: kIconColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.circle_outlined,
                          color: kIconColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Take photos with steady hands or make use of tripods.",
                          style: TextStyle(color: kIconColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.circle_outlined,
                          color: kIconColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Take photos of the car symmetrically.",
                          style: TextStyle(color: kIconColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Logout button
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      sp.userSignOut();
                      nextScreen(context, LoginScreen());
                    },
                    child: Text(
                      "   Logout   ",
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
                  TextButton(
                    onPressed: () {
                      nextScreen(context, UploadImageScreen());

                      nextScreen(context, CameraPage());

                    },
                    child: Text(
                      "   Proceed   ",
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
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
