import 'dart:async';
import 'package:art_community/auth/provider/sign_in_provider.dart';
import 'package:art_community/constants/constants.dart';
import 'package:art_community/constants/routes.dart';
import 'package:art_community/utils/next_screen.dart';
import 'package:art_community/views/galleryView.dart';
import 'package:art_community/views/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      sp.isSignedIn == false
          ? nextScreen(context, loginRoute)
          : nextScreen(context, GalleryView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.redColor,
        body: Center(
            child: Image.asset(
          'assets/images/splash.png',
        )));
  }
}
