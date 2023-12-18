import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/views/sign_up.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

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
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: returnPadding(),
        child: Column(children: [
          createTitle(),
          createSpacerTitleAndInput(),
          createTextFormEmail(textStyle, underlineInputBorder),
          smallSpacer(),
          createTextFormPassword(textStyle, underlineInputBorder),
          smallSpacer(),
          createSigninRow(),
          createSpacerRows(),
          createSignupAndForgot(),
        ]),
      )),
    );
  }

  SizedBox createSpacerRows() => SizedBox(height: Get.height * 0.1);

  Row createSignupAndForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.toNamed(SignUp.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: Get.width / 30,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: Get.width / 30,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Row createSigninRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Sign In",
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

  TextFormField createTextFormPassword(TextStyle textStyle, UnderlineInputBorder underlineInputBorder) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: textStyle,
        border: underlineInputBorder,
      ),
    );
  }

  SizedBox smallSpacer() => SizedBox(height: Get.height * 0.04);

  TextFormField createTextFormEmail(TextStyle textStyle, UnderlineInputBorder underlineInputBorder) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: textStyle,
        border: underlineInputBorder,
      ),
    );
  }

  Text createTitle() {
    return Text("Here To Get Welcomed !",
        style: TextStyle(
          fontSize: Get.width * 0.09,
          fontWeight: FontWeight.bold,
        ));
  }

  EdgeInsets returnPadding() {
    return EdgeInsets.only(
      top: Get.height * 0.15,
      left: Get.width * 0.1,
      right: Get.width * 0.1,
    );
  }
}

Widget createSpacerTitleAndInput() {
  return SizedBox(height: Get.height * 0.1);
}
// GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: returnPadding(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 createTitle(),
//                 createSpacerTitleAndInput(),
//                 createTextFormEmail(textStyle, underlineInputBorder),
//                 smallSpacer(),
//                 createTextFormPassword(textStyle, underlineInputBorder),
//                 smallSpacer(),
//                 createSigninRow(),
//                 createSpacerRows(),
//                 createSignupAndForgot(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );