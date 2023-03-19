import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sdgp/provider/internet_provider.dart';
import 'package:sdgp/screens/cost_estimation.dart';
import 'package:sdgp/screens/home_screen.dart';
import 'package:sdgp/screens/login_screen.dart';
import 'package:sdgp/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdgp/utils/config.dart';
import 'package:sdgp/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:sdgp/provider/sign_in_provider.dart';
import 'package:sdgp/utils/snack_bar.dart';

import 'home_screen_new.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final formKey = GlobalKey<FormState>();
  // contrroller -> phone, email, name,otp code
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            nextScreen(context, LoginScreen());
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
                          "Phone Login",
                          style: kPageTitleStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Image(
                      image: AssetImage(Config.app_logo),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be empty";
                                }
                                return null;
                              },
                              controller: nameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.account_circle),
                                hintText: "Adam Smith",
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email cannot be empty";
                                }
                                return null;
                              },
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                hintText: "abc@gmail.com",
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Phone number cannot be empty";
                                }
                                return null;
                              },
                              controller: phoneController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                hintText: "+94-701122333",
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // register button
                            ElevatedButton(
                                onPressed: () {
                                  login(context, phoneController.text.trim());
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.brown),
                                child: const Text("Register"))
                          ],
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(Config.bottom_logo),
                    height: 100,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image(
                    image: AssetImage(Config.app_logo),
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage(Config.name_logo),
                    height: 80,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future login(BuildContext context, String mobile) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connnection", Colors.red);
    } else {
      if (formKey.currentState!.validate()) {
        FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: mobile,
            verificationCompleted: (AuthCredential credential) async {
              await FirebaseAuth.instance.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              openSnackbar(context, e.toString(), Colors.red);
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Enter Code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: otpCodeController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.code),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final code = otpCodeController.text.trim();
                                AuthCredential authCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: code);
                                User user = (await FirebaseAuth.instance
                                        .signInWithCredential(authCredential))
                                    .user!;
                                // save the values - sign in provider
                                sp.phoneNumberUsers(user, emailController.text,
                                    nameController.text);
                                //check whether user exist or not
                                sp.checkUserExists().then((value) async {
                                  if (value == true) {
                                    // user exists
                                    await sp
                                        .getUserDataFromFirestore(sp.uid)
                                        .then((value) => sp
                                            .saveDataToSharedPreferences()
                                            .then((value) =>
                                                sp.setSignIn().then((value) {
                                                  nextScreenReplace(context,
                                                      const HomeScreenNew());
                                                })));
                                  } else {
                                    // user does not exist
                                    sp.saveDataToFirestore().then((value) => sp
                                        .saveDataToSharedPreferences()
                                        .then((value) =>
                                            sp.setSignIn().then((value) {
                                              nextScreenReplace(context,
                                                  const HomeScreenNew());
                                            })));
                                  }
                                });
                              },
                              child: const Text("Confirm"))
                        ],
                      ),
                    );
                  });
            },
            codeAutoRetrievalTimeout: (String verification) {});
      }
    }
  }
}
