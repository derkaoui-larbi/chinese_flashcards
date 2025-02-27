import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/Authentication/main_screens/LoginPage.dart';
import 'package:flutter_flashcards/Authentication/main_screens/RegisterPage.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:flutter_flashcards/notifiers/review_notifier.dart';
import 'package:flutter_flashcards/notifiers/settings_notifier.dart';
import 'package:flutter_flashcards/pages/LandingPage.dart';
import 'package:flutter_flashcards/pages/home_page.dart';
import 'package:flutter_flashcards/utils/methods.dart';
import 'package:provider/provider.dart';

import 'Users/Userc.dart';
import 'configs/themes.dart';
import 'Authentication/results_screen/Done.dart';
import 'Authentication/results_screen/ForgotPassword.dart';
import 'firebase_options.dart';

// Add the LandingPage import here
 // Update this path as necessary

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FlashcardsNotifier()),
      ChangeNotifierProvider(create: (_) => SettingsNotifier()),
      ChangeNotifierProvider(create: (_) => ReviewNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    updatePreferencesOnRestart(context: context);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'MyFlashcardsApp',
      theme: appTheme,
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (context) => LandingPage(),
        RegisterPage.id: (context) => RegisterPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => const HomePage(),
        ForgotPassword.id: (context) => ForgotPassword(),
        Done.id: (context) => Done(),
        // Add other routes as needed
      },
    );
  }
}
