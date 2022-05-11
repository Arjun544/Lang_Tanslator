import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_translator/models/lang_model.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  GoogleTranslator translator = GoogleTranslator();
  TextEditingController fieldController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  GetStorage getStorage = GetStorage();

  var chosenValue = 'en'.obs;
  var typedWords = ''.obs;
  var output = 'Translation'.obs;
  var isTyping = false.obs;
  var isTextFieldCopied = false.obs;
  var isOutputCopied = false.obs;
  var isDarkMode = false.obs;

  List<String> savedWords = [];

  @override
  void onInit() async {
    if (getStorage.read('stateValue') != null) {
      isDarkMode.value = getStorage.read('stateValue');
    }

    super.onInit();
  }

  void trans(String query) {
    translator
        .translate(query ?? '', to: "${chosenValue.value}" ?? 'en')
        .then((value) {
      output.value = value.toString();
      update();
    });
  }

  Future speak(String text) async {
    return await flutterTts.speak(text.toString());
  }

  void saveToSF(String from, String to) {
    RxSharedPreferences sharedPreferences = RxSharedPreferences.getInstance();
    final word = LangModel(from, to);
    String json = jsonEncode(word);
    savedWords.insert(0, json);
    sharedPreferences.setStringList('words', savedWords);
  }

  // void saveToSF(List<String> savedWords) {

  //   sharedPreferences.setStringList('words', savedWords);
  // }

  void clearSF() async {
    RxSharedPreferences sharedPreferences = RxSharedPreferences.getInstance();
    // await sharedPreferences.clear();
    sharedPreferences.setStringList('words', []);
  }

  void saveSwitchState() {
    getStorage.write('stateValue', isDarkMode.value);
  }
}
