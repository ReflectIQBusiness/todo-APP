import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/controllers/home_controller.dart';
import 'package:to_do_app/models/task.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.isRegistered<HomeController>() ? Get.find<HomeController>() : Get.put(HomeController());
  HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          height: double.infinity,
          decoration: returnScaffoldDecoration(),
          child: SingleChildScrollView(
              child: Padding(
            padding: returnPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createChatButton(),
                createWelcomeTitle(),
                createVerticalPadding(),
                createTitle(
                  "Your goal of the day",
                ),
                createSmallSpacer(),
                createRecapContainer(),
                createSmallSpacer(),
                createTitle(
                  "To do",
                ),
                createTodoDescription(),
                createSmallSpacer(),
                homeController.tasks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height / 20,
                            ),
                            SvgPicture.asset(
                              "assets/empty.svg",
                              width: Get.width / 4,
                            ),
                            SizedBox(
                              height: Get.height / 100,
                            ),
                            Text("No task for today 🚫",
                                style: TextStyle(
                                  fontSize: Get.width / 25,
                                  color: const Color(0xffa9a9a9),
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                      )
                    : Column(
                        children: homeController.tasks
                            .map((e) => createToDoContainer(
                                  task: e,
                                  color: e.points < 10
                                      ? const Color(0xffa6b8eb)
                                      : e.points < 15
                                          ? const Color(0xffebf5d4)
                                          : e.points < 20
                                              ? const Color(0xffFCB1A6)
                                              : const Color(0xff84596B),
                                ))
                            .toList(),
                      ),
                createSmallSpacer(),
              ],
            ),
          )),
        ),
      ),
    );
  }

  EdgeInsets returnPadding() {
    return EdgeInsets.only(
      top: Get.width / 10,
      left: Get.width / 15,
      right: Get.width / 15,
    );
  }

  SizedBox createTodoDescription() {
    return SizedBox(
      width: Get.width / 1.5,
      child: Text(
        "${homeController.tasks.where((p0) => p0.isDone).length} / ${homeController.tasks.length} exercises are marked as completed successfully",
        style: TextStyle(
          fontSize: Get.width / 27,
          fontWeight: FontWeight.w400,
          color: const Color(0xffa9a9a9),
        ),
      ),
    );
  }

  Text createTitle(text) {
    return Text(
      text,
      style: Get.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  SizedBox createSmallSpacer() {
    return SizedBox(
      height: Get.height / 40,
    );
  }

  SizedBox createVerticalPadding() {
    return SizedBox(
      height: Get.height / 15,
    );
  }

  BoxDecoration returnScaffoldDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        opacity: 0.3,
        image: AssetImage(
          "assets/bg.png",
        ),
      ),
    );
  }

  Container createRecapContainer() {
    double percent = homeController.tasks.isEmpty ? 0 : homeController.tasks.where((p0) => p0.isDone).length / homeController.tasks.length;
    return Container(
      height: Get.height / 11,
      margin: EdgeInsets.symmetric(horizontal: Get.width / 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffa6b8eb).withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffa6b8eb).withOpacity(0.16),
            blurRadius: 15,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width / 20,
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      value: percent,
                      color: const Color(0xffebf5d4),
                      strokeWidth: 2,
                    ),
                  ),
                ),
                Text(
                  "${(percent * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: Get.width / 30,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(
              width: Get.width / 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You already gained",
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                RichText(
                    text: TextSpan(
                        text: homeController.tasks
                            .where((p0) => p0.isDone)
                            .map((e) => e.points)
                            .fold(0, (previousValue, element) => previousValue + element)
                            .toString(),
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width / 19,
                        ),
                        children: [
                      TextSpan(
                          text:
                              " / ${homeController.tasks.map((e) => e.points).fold(0, (previousValue, element) => previousValue + element)} ",
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "pts!",
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          )),
                    ])),
              ],
            )
          ],
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
          SizedBox(
            width: Get.width / 2,
            child: Text(
              "We are happy to see you again today 😊",
              style: Get.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
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
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.16),
                  blurRadius: 15,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/chat.svg",
              ),
            )));
  }

  Widget createToDoContainer({
    required Task task,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey(task.id),

        // The start action pane is the one at the left or the top side.
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            Expanded(
              child: Center(
                child: SizedBox(
                  height: Get.height / 11,
                  child: GestureDetector(
                    onTap: () {
                      homeController.edit(task);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: purple),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/edit.svg",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: Get.height / 11,
                  child: GestureDetector(
                    onTap: () {
                      homeController.delete(task.id);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 46, 5, 2),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/delete.svg",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Row(
          children: [
            SizedBox(
                width: Get.width / 7,
                child: Center(
                  child: task.isDone
                      ? CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 134, 193, 135).withOpacity(0.1),
                          radius: Get.width / 20,
                          child: const Icon(
                            CupertinoIcons.checkmark_alt,
                            color: Color.fromARGB(255, 134, 193, 135),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            homeController.completeTask(task.id);
                          },
                          child: Text("To do",
                              style: Get.textTheme.titleMedium!.copyWith(
                                color: Colors.red,
                              )),
                        ),
                )),
            SizedBox(
              width: Get.width / 20,
            ),
            Expanded(
              child: Container(
                height: Get.height / 11,
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: color.withOpacity(0.5),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width / 3,
                      child: Text(
                        task.name,
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${task.points} pts",
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
