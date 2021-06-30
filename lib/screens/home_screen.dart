import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hovering/hovering.dart';
import '../controllers/home_controller.dart';
import '../data/languages.dart';
import '../utils/themeService_util.dart';
import '../widgets/mobileLayout.dart';
import '../widgets/webLayout.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxWidth <= 480
                  ? Get.height * 0.15
                  : Get.height * 0.17,
              padding: constraints.maxWidth <= 480
                  ? const EdgeInsets.only(
                      right: 20,
                      top: 15,
                      left: 20,
                      bottom: 10,
                    )
                  : const EdgeInsets.only(
                      right: 50,
                      top: 30,
                      left: 50,
                      bottom: 10,
                    ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: constraints.maxWidth <= 480
                            ? Get.height * 0.03
                            : Get.height * 0.05,
                      ),
                      SizedBox(
                        width: constraints.maxWidth <= 480 ? 50 : 75,
                        height: constraints.maxWidth <= 480 ? 50 : 60,
                        child: Obx(() => DayNightSwitcher(
                              isDarkModeEnabled:
                                  homeController.isDarkMode.value,
                              onStateChanged: (isDarkModeEnabled) {
                                homeController.isDarkMode.value =
                                    isDarkModeEnabled;
                                ThemeService().switchTheme();
                                homeController.saveSwitchState();
                              },
                            )),
                      ),
                    ],
                  ),
                  HoverAnimatedContainer(
                    height: 40,
                    width: 170,
                    hoverHeight: 45,
                    hoverWidth: 175,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Theme.of(context).popupMenuTheme.color,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton<String>(
                            value: homeController.chosenValue.value,
                            elevation: 5,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline2.color,
                            ),
                            iconEnabledColor: Colors.white,
                            items: languages
                                .map((string, value) {
                                  return MapEntry(
                                    string,
                                    DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        string,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                            hint: Text(
                              "English",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            onChanged: (String value) {
                              homeController.chosenValue.value = value;
                              homeController.trans(homeController.output.value);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: constraints.maxWidth <= 480
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                  : const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: constraints.maxWidth <= 480
                  ? mobileLayout(homeController, context)
                  : webLayout(homeController, context),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: constraints.maxWidth <= 480
                    ? const EdgeInsets.only(left: 25, right: 22)
                    : const EdgeInsets.only(left: 50, right: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saved',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.headline1.color,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        homeController.clearSF();
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<List<String>>(
                stream: RxSharedPreferences.getInstance()
                    .getStringListStream('words'),
                builder: (context, snapshot) {
                  final words = snapshot.data;

                  if (words != null) {
                    homeController.savedWords = words;
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (words == null || words.length == 0) {
                    return Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.15),
                      child: Text(
                        'Nothing saved',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                constraints.maxWidth <= 480 ? 3 : 10,
                            childAspectRatio: 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: words.length,
                        shrinkWrap: true,
                        padding: constraints.maxWidth <= 480
                            ? const EdgeInsets.only(left: 20, right: 22)
                            : const EdgeInsets.only(left: 50, right: 50),
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: constraints.maxWidth <= 480
                                  ? BorderRadius.circular(7)
                                  : BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  words[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .color,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    words.removeAt(index);
                                    homeController.saveToSF(words);
                                  },
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red.withOpacity(0.5),
                                    size: constraints.maxWidth <= 480 ? 18 : 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }),
          ],
        );
      }),
    );
  }
}
