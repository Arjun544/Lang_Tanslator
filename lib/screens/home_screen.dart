import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleTranslator translator = GoogleTranslator();

  String chosenValue = 'en';
  String typedWords;
  String output = 'Translation';
  bool isTyping = false;
  bool isCopied = false;

  FlutterTts flutterTts = FlutterTts();

  static const Map<String, String> lang = {
    "Afrikaans": "af",
    "Albanian": "sq",
    "Amharic": "am",
    "Arabic": "ar",
    "Armenian": "hy",
    "Azerbaijani": "az",
    "Basque": "eu",
    "Belarusian": "be",
    "Bengali": "bn",
    'Bosnian': "bs",
    "Bulgarian": "bg",
    "Catalan": "ca",
    "Cebuano": "ceb",
    "Chinese": "CN",
    "Corsican": "co",
    "Croatian": "hr",
    "Czech": "cs",
    "Danish": "da",
    "Dutch": "nl",
    "English": "en",
    "Esperanto": "eo",
    "Estonian": "et",
    "Finnish": "fi",
    "French": "fr",
    "Frisian": "fy",
    "Galician": "gl",
    "Georgian": "ka",
    "German": "de",
    "Greek": "el",
    "Gujarati": "gu",
    "Haitian": "ht",
    "Hausa": "ha",
    "Hawaiian": "haw",
    "Hebrew": "he",
    "Hindi": "hi",
    "Hmong": "hmn",
    "Hungarian": "hu",
    "Icelandic": "is",
    "Igbo": "ig",
    "Indonesian": "id",
    "Irish": "ga",
    "Italian": "it",
    "Japanese": "ja",
    "Javanese": "jv",
    "Kannada": "kn",
    "Kazakh": "kk",
    "Khmer": "km",
    "Kinyarwanda": "rw",
    "Korean": "ko",
    "Kurdish": "ku",
    "Kyrgyz": "ky",
    "Lao": "lo",
    "Latin": "la",
    "Latvian": "lv",
    "Lithuanian": "lt",
    "Luxembourgish": "lb",
    "Macedonian": "mk",
    "Malagasy": "mg",
    "Malay": "ms",
    "Malayalam": "ml",
    "Maltese": "mt",
    "Maori": "mi",
    "Marathi": "mr",
    "Mongolian": "mn",
    "Myanmar": "my",
    "Nepali": "ne",
    "Norwegian": "no",
    "Nyanja": "ny",
    "Odia": "or",
    "Pashto": "ps",
    "Persian": "fa",
    "Polish": "pl",
    "Portuguese": "pt",
    "Punjabi": "pa",
    "Romanian": "ro",
    "Russian": "ru",
    "Samoan": "sm",
    "Scots Gaelic": "gd",
    "Serbian": "sr",
    "Sesotho": "st",
    "Shona": "sn",
    "Sindhi": "sd",
    "Sinhala": "si",
    "Slovak": "sk",
    "Slovenian": "sl",
    "Somali": "so",
    "Spanish": "es",
    "Sundanese": "su",
    "Swahili": "sw",
    "Swedish": "sv",
    "Tagalog": "tl",
    "Tajik": "tg",
    "Tamil": "ta",
    "Tatar": "tt",
    "Telugu": "te",
    "Thai": "th",
    "Turkish": "tr",
    "Turkmen": "tk",
    "Ukrainian": "uk",
    "Urdu": "ur",
    "Uyghur": "ug",
    "Uzbek": "uz",
    "Vietnamese": "vi",
    "Welsh": "cy",
    "Xhosa": "xh",
    "Yiddish": "yi",
    "Yoruba": "yo",
    "Zulu": "zu",
  };

  void trans(String query) {
    translator.translate(query ?? '', to: "$chosenValue" ?? 'en').then((value) {
      setState(() {
        output = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.2,
            padding:
                const EdgeInsets.only(right: 50, top: 30, left: 50, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xFF3F72AF),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: screenHeight * 0.05,
                    ),
                    FlutterLogo(
                      size: screenHeight * 0.05,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(''),
                    Container(
                      height: 40,
                      width: 170,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: chosenValue,
                          elevation: 5,
                          style: TextStyle(color: Colors.black),
                          iconEnabledColor: Colors.black,
                          items: lang
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
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              chosenValue = value;
                              trans(output);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    height: screenHeight * 0.35,
                    padding: const EdgeInsets.only(top: 20, left: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 3),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (val) {
                            if (val.length > 0) trans(val);
                            setState(() {
                              typedWords = val;
                              isTyping = true;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter word',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        isTyping && typedWords.toString().length > 0
                            ? Features(output: typedWords, isCopied: isCopied)
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: screenHeight * 0.35,
                    padding: const EdgeInsets.only(top: 20, left: 30),
                    decoration: BoxDecoration(
                        color: Color(0xFFBBE1FA),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 3),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          typedWords != '' ? output : 'Translation',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        isTyping && typedWords.toString().length > 0
                            ? Features(output: output, isCopied: isCopied)
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Features extends StatefulWidget {
  Features({
    Key key,
    @required this.output,
    @required this.isCopied,
  }) : super(key: key);

  final String output;
  bool isCopied;

  @override
  _FeaturesState createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  FlutterTts flutterTts = FlutterTts();
  Future speak(String text) async {
    return await flutterTts.speak(text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.volume_up_rounded,
                color: Colors.black,
                size: 25.0,
              ),
              onPressed: () {
                speak(widget.output);
              }),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Row(
                children: [
                  widget.isCopied
                      ? Text(
                          'Copied',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(''),
                  IconButton(
                    icon: Icon(
                      Icons.copy_rounded,
                      color: Colors.grey,
                      size: 25.0,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: widget.output.toString(),
                      ));
                      setState(() {
                        widget.isCopied = true;
                      });
                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          widget.isCopied = false;
                        });
                      });
                    },
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.share_rounded,
                  color: Colors.grey,
                  size: 25.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
