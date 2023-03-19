import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInProvider extends ChangeNotifier {
  //instance of firebaseauth, facbook and google
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool _isSingedIn = false;
  bool get isSingedIn => _isSingedIn;

  //hasError, errorCode, provider, uid, email, name, imageUrl
  bool _hashError = false;
  bool get hashError => _hashError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _name;
  String? get name => _name;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSingedIn = s.getBool("singed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("singed_in", true);
    _isSingedIn = true;
    notifyListeners();
  }

  // sign in with google
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      //executing our authentication
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        // signing to firebase user instance
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;
        //now save all user details
        _name = userDetails.displayName;
        _email = userDetails.email;
        _imageUrl = userDetails.photoURL;
        _provider = "GOOGLE";
        _uid = userDetails.uid;
        notifyListeners();
      } on FirebaseException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
                "You already have an account with us. Use correct provider";
            _hashError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hashError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hashError = true;
            notifyListeners();
            break;
        }
      }
    } else {
      _hashError = true;
      notifyListeners();
    }
  }

  //sign in with facebook
  Future signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();
    //getting the profile
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken!.token}'));
    final profile = jsonDecode(graphResponse.body);

    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await firebaseAuth.signInWithCredential(credential);
        //saving the values
        _name = profile['name'];
        _email = profile['email'];
        _imageUrl = profile['picture']['data']['url'];
        _uid = profile['id'];
        _hashError = false;
        _provider = "FACEBOOK";
        notifyListeners();
      } on FirebaseException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
                "You already have an account with us. Use correct provider";
            _hashError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hashError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hashError = true;
            notifyListeners();
            break;
        }
      }
    } else {
      _hashError = true;
      notifyListeners();
    }
  }

  //Entry for cloudfirestore
  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot['uid'],
              _name = snapshot['name'],
              _email = snapshot['email'],
              _imageUrl = snapshot['image_url'],
              _provider = snapshot['provider'],
            });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "uid": _uid,
      "image_url": _imageUrl,
      "provider": _provider
    });
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name!);
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    await s.setString('imageUrl', _imageUrl!);
    await s.setString('provider', _provider!);
    notifyListeners();
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('imageUrl');
    _uid = s.getString('uid');
    _provider = s.getString('provider');
    notifyListeners();
  }

  //check user exists or not in cloudfirestore
  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      print("EXSITING USER");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  //Sign out
  Future userSignOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    _isSingedIn = false;
    notifyListeners();
    //clear all storage data
    clearStorageDara();
  }

  Future clearStorageDara() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  void phoneNumberUsers(User user, email, name) {
    _name = name;
    _email = email;
    _imageUrl =
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwinaero.com%2Fdefault-user-account-picture-windows-10%2F&psig=AOvVaw1dZjaJx39tUer-5ZO9wUCh&ust=1679299124865000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCJjek_DC5_0CFQAAAAAdAAAAABAE";
    _uid = user.phoneNumber;
    _provider = "PHONE";
    notifyListeners();
  }
}
