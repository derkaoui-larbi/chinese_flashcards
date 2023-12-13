import 'package:flutter/material.dart';
import 'package:flutter_flashcards/Authentication/main_screens/LoginPage.dart';
import 'package:flutter_flashcards/Authentication/main_screens/RegisterPage.dart';

import '../Users/Userc.dart';
import '../databases/database_manager.dart';

class LandingPage extends StatelessWidget {
  static const String id = '/LandingPage';

  @override
  Widget build(BuildContext context) {


    Userc user = Userc(fullName: "aymane", email:"aymaneaitmansour@gmail.com", password: "aymaneaitmansour@gmail.com", role: Role.student);
    DatabaseManager().insertUser(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to MyFlashcardsApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            ElevatedButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.pushNamed(context, RegisterPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
