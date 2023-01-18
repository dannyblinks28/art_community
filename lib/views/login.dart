import 'package:art_community/auth/provider/internet_provider.dart';
import 'package:art_community/auth/provider/sign_in_provider.dart';
import 'package:art_community/constants/constants.dart';
import 'package:art_community/constants/login_constructor.dart';
import 'package:art_community/utils/next_screen.dart';
import 'package:art_community/utils/snack_bar.dart';
import 'package:art_community/views/galleryView.dart';
import 'package:flutter/material.dart';
import '../auth/provider/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  bool _isObsecure = true;
  final GlobalKey _scaffoldkey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController appleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController twitterController =
      RoundedLoadingButtonController();
  //sign user in method
  void signUserIn() {}
  @override
  Widget build(BuildContext context) {
    key:
    _scaffoldkey;
    return Scaffold(
      backgroundColor: Constants.primaryWhiteColor,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 20, left: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/login-logo.png'),
                  SizedBox(height: 100),
                  Text(
                    'SIGN IN WITH',
                    style: TextStyle(
                      fontSize: 18,
                      color: Constants.veryDarkColor,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //FACEBOOK
                      LoginConstructor(
                        controller: facebookController,
                        success: Colors.blue,
                        iconImage: ('assets/images/facebook.png'),
                        iconColor: Colors.blue,
                        ontap: () {
                          handleFacebookAuth();
                        },
                      ),
                      //APPLE
                      LoginConstructor(
                        controller: appleController,
                        success: Constants.veryDarkColor,
                        iconImage: ('assets/images/apple.png'),
                        iconColor: Constants.primaryWhiteColor,
                        ontap: () {},
                      ),
                      //GOOGLE
                      LoginConstructor(
                        controller: googleController,
                        success: Constants.redColor,
                        iconImage: ('assets/images/google.png'),
                        iconColor: Constants.primaryWhiteColor,
                        ontap: () {
                          handleGoogleSignIn();
                        },
                      ),
                      //TWITTER
                      LoginConstructor(
                        controller: twitterController,
                        success: Colors.blue,
                        iconImage: ('assets/images/twitter.png'),
                        iconColor: Colors.blue,
                        ontap: () {},
                      )
                    ],
                  ),
                  SizedBox(height: 70),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Constants.darkColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Constants.darkColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email'),
                      TextField(
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Constants.veryDarkColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Password'),
                      TextField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _passwordController,
                        obscureText: _isObsecure,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Constants.veryDarkColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObsecure = !_isObsecure;
                              });
                            },
                            icon: Icon(
                              _isObsecure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Constants.darkColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Constants.redColor),
                      ),
                      onPressed: () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        // await FirebaseAuth
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Constants.primaryWhiteColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'DANG,I FORGOT MY PASSWORD',
                        style: TextStyle(color: Constants.redColor),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //handling google sign in
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(
        context,
        "Check your internet connection",
        Colors.red,
      );
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then(
            (value) async {
              if (value == true) {
                // user exists
                await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                    .saveDataToSharedPreferences()
                    .then((value) => sp.setSignIn().then((value) {
                          googleController.success();
                          handleAfterSignIn();
                        })));
              } else {
                //user does not exist
                sp.saveDataToFirestore().then(
                    (value) => sp.saveDataToSharedPreferences().then((value) {
                          googleController.success();
                          handleAfterSignIn();
                        }));
              }
            },
          );
        }
      });
    }
  }

  //handling facebookAuth
  Future handleFacebookAuth() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(
        context,
        "Check your internet connection",
        Colors.red,
      );
      facebookController.reset();
    } else {
      await sp.signInWithFacebook().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          facebookController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then(
            (value) async {
              if (value == true) {
                // user exists
                await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                    .saveDataToSharedPreferences()
                    .then((value) => sp.setSignIn().then((value) {
                          facebookController.success();
                          handleAfterSignIn();
                        })));
              } else {
                //user does not exist
                sp.saveDataToFirestore().then(
                    (value) => sp.saveDataToSharedPreferences().then((value) {
                          facebookController.success();
                          handleAfterSignIn();
                        }));
              }
            },
          );
        }
      });
    }
  }

  //handle after sign in
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, const GalleryView());
    });
  }
}
