import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartie/bank_terms_cond_screen.dart';
import 'package:smartie/verification_id_back.dart';
import 'package:smartie/verification_start_page.dart';
import 'package:smartie/set_pwd_screen.dart';
import 'login_screen.dart';
import 'package:file_picker/file_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Galano', // Use your font family name here
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LoginScreen(),
    );
  }
}
