import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class TextFieldFeatures extends StatelessWidget {
  final HomeController controller;

  const TextFieldFeatures({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: constraints.maxWidth <= 480
            ? const EdgeInsets.only(bottom: 10)
            : const EdgeInsets.only(bottom: 10, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.volume_up_rounded,
                  color: Theme.of(context).buttonColor,
                  size: 25.0,
                ),
                onPressed: () {
                  controller.speak(controller.typedWords.value);
                }),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Obx(() => Row(
                      children: [
                        controller.isTextFieldCopied.value
                            ? Text(
                                'Copied',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .color,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(''),
                        IconButton(
                          icon: Icon(
                            Icons.copy_rounded,
                            color: Theme.of(context).textTheme.headline3.color,
                            size: constraints.maxWidth <= 480 ? 20 : 25.0,
                          ),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                              text: controller.typedWords.value.toString(),
                            ));

                            controller.isTextFieldCopied.value = true;

                            Future.delayed(Duration(seconds: 1), () {
                              controller.isTextFieldCopied.value = false;
                            });
                          },
                        ),
                      ],
                    )),
                IconButton(
                  icon: Icon(
                    Icons.star_border_rounded,
                    color: Theme.of(context).textTheme.headline3.color,
                    size: 25.0,
                  ),
                  onPressed: () {
                    // controller.savedWords
                    //     .insert(0, controller.typedWords.value);
                    controller.saveToSF(
                        controller.typedWords.value, controller.output.value);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.share_rounded,
                    color: Theme.of(context).textTheme.headline3.color,
                    size: constraints.maxWidth <= 480 ? 20 : 25.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
