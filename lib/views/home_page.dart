import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.jpeg"),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: Get.width / 10, left: Get.width / 15, right: Get.width / 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createChatButton(),
                createWelcomeTitle(),
                SizedBox(
                  height: Get.height / 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your goal of the day",
                      style: Get.textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                    Container(
                      height: Get.height / 8,
                      margin: EdgeInsets.symmetric(horizontal: Get.width / 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange.withOpacity(0.3),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center createWelcomeTitle() {
    return Center(
      child: Column(
        children: [
          Text(
            'Hi ReflectIqTwin',
            style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            "We are happy to see you again today 😊",
            style: Get.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Align createChatButton() {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50), boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]),
          child: const Icon(CupertinoIcons.chat_bubble),
        ));
  }
}
