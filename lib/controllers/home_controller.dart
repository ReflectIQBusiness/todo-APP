import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/models/task.dart';

class HomeController extends GetxController {
  Rx<PersistentTabController> controller = PersistentTabController(initialIndex: 1).obs;
  RxList<Task> tasks = <Task>[].obs;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskPointsController = TextEditingController();
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/user.svg",
          color: controller.value.index == 0 ? purple : CupertinoColors.systemGrey,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/home.svg",
          color: controller.value.index == 1 ? purple : CupertinoColors.systemGrey,
        ),
      ),
      PersistentBottomNavBarItem(
        onPressed: (p0) {
          taskNameController.clear();
          taskPointsController.clear();
          Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.1,
              vertical: Get.height * 0.025,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.075,
            ),
            title: "Add Task",
            titleStyle: TextStyle(
              color: purple,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            content: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "Please enter a task name" : null,
                    controller: taskNameController,
                    decoration: getDecoration("Task Name"),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "Please enter a task points" : null,
                    controller: taskPointsController,
                    decoration: getDecoration("Points"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),
                  ElevatedButton(
                    onPressed: () => addTask(),
                    child: const Text("Add"),
                  ),
                ],
              ),
            ),
          );
        },
        activeColorPrimary: purple,
        icon: SvgPicture.asset(
          "assets/add.svg",
          color: Colors.white,
          width: 50,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/chart.svg",
          color: controller.value.index == 3 ? purple : CupertinoColors.systemGrey,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/more.svg",
          color: controller.value.index == 4 ? purple : CupertinoColors.systemGrey,
        ),
      ),
    ];
  }

  InputDecoration getDecoration(name) {
    return InputDecoration(
      hintText: name,
      labelStyle: TextStyle(
        color: purple,
        fontSize: Get.width * 0.05,
      ),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  addTask() {
    if (formkey.currentState!.validate()) {
      tasks.add(
        Task(
          id: DateTime.now().toString(),
          name: taskNameController.text,
          points: int.parse(taskPointsController.text),
        ),
      );
      Get.back();
      taskNameController.clear();
      taskPointsController.clear();
    }
  }

  void completeTask(String id) {
    tasks.firstWhere((element) => element.id == id).toggleDone();
    tasks.refresh();
  }

  delete(String id) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.1,
        vertical: Get.height * 0.025,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.075,
      ),
      title: "Delete Task",
      titleStyle: TextStyle(
        color: purple,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        children: [
          Text(
            "Are you sure you want to delete this task?",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Get.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  onPrimary: Colors.black,
                ),
                onPressed: () => Get.back(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  onPrimary: purple,
                ),
                onPressed: () {
                  tasks.removeWhere((element) => element.id == id);
                  tasks.refresh();
                  Get.back();
                },
                child: const Text("Delete"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  edit(Task task) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.1,
        vertical: Get.height * 0.025,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.075,
      ),
      title: "Edit Task",
      titleStyle: TextStyle(
        color: purple,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      content: Form(
        key: formkey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) => value!.isEmpty ? "Please enter a task name" : null,
              controller: taskNameController..text = task.name,
              decoration: getDecoration("Task Name"),
            ),
            SizedBox(height: Get.height * 0.01),
            TextFormField(
              validator: (value) => value!.isEmpty ? "Please enter a task points" : null,
              controller: taskPointsController..text = task.points.toString(),
              decoration: getDecoration("Points"),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            SizedBox(height: Get.height * 0.01),
            ElevatedButton(
              onPressed: () => editTask(task.id),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  editTask(String id) {
    if (formkey.currentState!.validate()) {
      tasks.firstWhere((element) => element.id == id).name = taskNameController.text;
      tasks.firstWhere((element) => element.id == id).points = int.parse(taskPointsController.text);
      tasks.refresh();
      Get.back();
      taskNameController.clear();
      taskPointsController.clear();
    }
  }
}
