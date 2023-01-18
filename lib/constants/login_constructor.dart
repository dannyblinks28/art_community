import 'package:art_community/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginConstructor extends StatefulWidget {
  LoginConstructor(
      {required this.iconImage,
      required this.iconColor,
      required this.ontap,
      required this.success,
      super.key, required RoundedLoadingButtonController controller});
  Color success;
  String iconImage;
  Color iconColor;
  VoidCallback ontap;

  @override
  State<LoginConstructor> createState() => _LoginConstructorState();
}

class _LoginConstructorState extends State<LoginConstructor> {
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController appleController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RoundedLoadingButton(
        color: widget.iconColor,
        height: 50,
        width: 1,
        elevation: 0,
        onPressed: widget.ontap,
        controller: googleController,
        successColor: widget.success,
        child: Image.asset(
          widget.iconImage,
        ),
      ),
    );
  }
}
