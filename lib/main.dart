import 'dart:developer';

import 'package:asaan_urdu/screens/login.dart';
import 'package:asaan_urdu/screens/home.dart';
import 'package:asaan_urdu/screens/ruff_work.dart';
import 'package:asaan_urdu/speach.dart';
import 'package:asaan_urdu/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login3 = prefs.getString("email");
    print("Emaill pokaa :" + login3.toString());
    runApp(MyApp(
      home: login3 == null ? MyHomePage() : MyHomePage(),
    ));
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  var home;

  MyApp({Key? key, this.home}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dastoor",
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],

        // // Define the default font family.
        // fontFamily: 'Georgia',
        buttonColor: Colors.blue[800],
        // brightness: Brightness.,
        // primarySwatch: Colors.blue,
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: home,
    );
  }
}
