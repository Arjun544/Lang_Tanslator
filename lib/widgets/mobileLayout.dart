import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

import 'textFieldFeatures.dart';
import 'translateFeatures.dart';

Widget mobileLayout(HomeController homeController, BuildContext context) {
  return Obx(
    () => Column(
      children: [
        Column(
          children: [
            Container(
              height: Get.height * 0.2,
              width: Get.width,
              padding: const EdgeInsets.only(top: 10, left: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3),
                  ]),
              child: TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (val) {
                  if (val.length > 0) homeController.trans(val);

                  homeController.typedWords.value = val;
                  homeController.isTyping.value = true;
                },
                cursorWidth: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter word',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1.color,
                  ),
                ),
              ),
            ),
            homeController.isTyping.value &&
                    homeController.typedWords.value.toString().length > 0
                ? TextFieldFeatures(
                    controller: homeController,
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Container(
              height: Get.height * 0.2,
              width: Get.width,
              padding: const EdgeInsets.only(top: 20, left: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black38, blurRadius: 3),
                  ]),
              child: SelectableText(
                homeController.typedWords.value.length > 0
                    ? homeController.output.value
                    : 'Translation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            homeController.isTyping.value &&
                    homeController.typedWords.value.toString().length > 0
                ? TranslateFeatures(
                    controller: homeController,
                  )
                : SizedBox(),
          ],
        ),
      ],
    ),
  );
}
