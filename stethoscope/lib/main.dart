import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stethoscope/controller/appDirectorySingleton.dart';
import 'package:stethoscope/utils/localization.dart';
import 'package:stethoscope/views/LoginPage.dart';
import 'package:stethoscope/views/RolePage.dart';
import 'package:stethoscope/views/StartPage.dart';
import 'package:stethoscope/views/homePage.dart';
import 'package:stethoscope/views/widgets/result.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart' as provider;

import 'models/User.dart';

void main() async {
  ///
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppDirectorySingleton().getAppDirectory();
  await AppDirectorySingleton().fetchRecordings();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalizationService.initLanguages();

  runApp(provider.MultiProvider(
    providers: [
      provider.ChangeNotifierProvider<AppDirectorySingleton>(
          create: (_) => AppDirectorySingleton()),
    ],
    child: GetMaterialApp(
      //locale: Locale('fr', 'FR'),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '': (context) => const StartPage(),
        /* '/rolepage': (context) => RolePage(
              user: CustomUser(
                  uid: '',
                  fullName: "",
                  phoneNumber: '',
                  age: '',
                  gender: '',
                  email: ''),
            ),
        '/login': (context) => const LoginPage(),*/
        '/homepage': (context) => HomePage(
          user: CustomUser(
              uid: '',
              fullName: "",
              phoneNumber: '',
              age: '',
              gender: '',
              email: ''),
        ),
      },
    ),
  ));
}
