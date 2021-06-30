import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovering/hovering.dart';
import '../controllers/home_controller.dart';

import 'textFieldFeatures.dart';
import 'translateFeatures.dart';

Widget webLayout(HomeController homeController, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: HoverAnimatedContainer(
          height: Get.height * 0.35,
          hoverHeight: Get.height * 0.37,
          padding: const EdgeInsets.only(top: 20, left: 30),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 3),
              ]),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1.color,
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
                homeController.isTyping.value &&
                        homeController.typedWords.value.toString().length > 0
                    ? TextFieldFeatures(
                        controller: homeController,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: HoverAnimatedContainer(
          height: Get.height * 0.35,
          hoverHeight: Get.height * 0.37,
          padding: const EdgeInsets.only(top: 30, left: 30),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: Colors.black38, blurRadius: 3),
              ]),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  homeController.typedWords.value.length > 0
                      ? homeController.output.value
                      : 'Translation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
          ),
        ),
      ),
    ],
  );
}
