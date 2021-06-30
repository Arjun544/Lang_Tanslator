import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'utils/themes_util.dart';

import 'screens/home_screen.dart';
import 'utils/themeService_util.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Translator',
      theme: MyThemes.light,
      darkTheme: MyThemes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      
      home: HomeScreen(),
    );
  }
}
