import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovering/hovering.dart';
import '../controllers/home_controller.dart';

import 'textFieldFeatures.dart';
import 'translateFeatures.dart';

Widget webLayout(HomeController homeController, BuildContext context) {
  return LayoutBuilder(builder: (context, constraints) {
    return Flex(
      direction: constraints.maxWidth <= 800 ? Axis.vertical : Axis.horizontal,
      children: [
        Expanded(
          flex: constraints.maxWidth <= 800 ? 0 : 1,
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
                    controller: homeController.fieldController,
                    autofocus: true,
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
        constraints.maxWidth <= 800
            ? SizedBox(
                height: 20,
              )
            : SizedBox(
                width: 20,
              ),
        Expanded(
          flex: constraints.maxWidth <= 800 ? 0 : 1,
          child: HoverAnimatedContainer(
            width: Get.width,
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
                    homeController.isTyping.value
                        ? homeController.output.value
                        : homeController.typedWords.value.length > 0
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
  });
}
