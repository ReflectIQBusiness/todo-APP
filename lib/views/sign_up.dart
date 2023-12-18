import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/colors.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  static const routeName = '/sign-up';
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: const Color.fromARGB(255, 111, 108, 108),
      fontWeight: FontWeight.w600,
      fontSize: Get.width / 30,
    );
    UnderlineInputBorder underlineInputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(
          color: Color.fromARGB(
        255,
        111,
        108,
        108,
      )),
    );
    var edgeInsets = EdgeInsets.only(
      left: Get.width * 0.1,
      right: Get.width * 0.1,
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: edgeInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createTitleSignUp(),
              createHeightSpacer(),
              createFirstLastNameRow(textStyle, underlineInputBorder),
              createHeightSpacer(),
              createEmail(textStyle, underlineInputBorder),
              createHeightSpacer(),
              createPassword(textStyle, underlineInputBorder),
              createHeightSpacer(),
              createConfirmPassword(textStyle, underlineInputBorder),
              createHeightSpacer(),
              createSignUpRow(),
              createHeightSpacer(),
              createBackToSignInRow(textStyle)
            ],
          ),
        ),
      ),
    );
  }

  Row createBackToSignInRow(TextStyle textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: textStyle,
        ),
        SizedBox(width: Get.width * 0.02),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: Get.width / 30,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Row createSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Sign Up",
          style: TextStyle(
            fontSize: Get.width / 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: Get.width * 0.16,
          width: Get.width * 0.16,
          decoration: BoxDecoration(
            color: purple,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  TextFormField createConfirmPassword(TextStyle textStyle, UnderlineInputBorder underlineInputBorder) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm password",
        labelStyle: textStyle,
        border: underlineInputBorder,
      ),
    );
  }

  TextFormField createPassword(TextStyle textStyle, UnderlineInputBorder underlineInputBorder) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: textStyle,
        border: underlineInputBorder,
      ),
    );
  }

  TextFormField createEmail(TextStyle textStyle, UnderlineInputBorder underlineInputBorder) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: textStyle,
        border: underlineInputBorder,
      ),
    );
  }

  Row createFirstLastNameRow(TextStyle textStyle, UnderlineInputBorder underlineInputBorder) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "First Name",
              labelStyle: textStyle,
              border: underlineInputBorder,
            ),
          ),
        ),
        SizedBox(width: Get.width * 0.05),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Last Name",
              labelStyle: textStyle,
              border: underlineInputBorder,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox createHeightSpacer() => SizedBox(height: Get.height * 0.05);

  Text createTitleSignUp() {
    return Text(
      "Sign Up Page",
      style: TextStyle(
        fontSize: Get.width * 0.09,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
