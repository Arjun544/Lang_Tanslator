import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  GoogleTranslator translator = GoogleTranslator();
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

  void saveToSF(List<String> savedWords) {
    RxSharedPreferences sharedPreferences = RxSharedPreferences.getInstance();
    sharedPreferences.setStringList('words', savedWords);
  }

  void clearSF() {
    RxSharedPreferences sharedPreferences = RxSharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  void saveSwitchState() {
    getStorage.write('stateValue', isDarkMode.value);
  }
}
