import 'package:flutter/material.dart';
import 'package:flutter_flashcards/Authentication/main_screens/LoginPage.dart';
import 'package:flutter_flashcards/Authentication/main_screens/RegisterPage.dart';
import '../Users/Userc.dart';
import '../databases/database_manager.dart';

class LandingPage extends StatelessWidget {
  static const String id = '/LandingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to MyFlashcardsApp',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
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
