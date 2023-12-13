import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../Users/Userc.dart';
import '../../databases/database_manager.dart';
import '../../pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool _showSpinner = false;
  bool _wrongEmail = false;
  bool _wrongPassword = false;
  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';

  @override
  Widget build(BuildContext context) {

    Userc user = Userc(fullName: "aymane", email:"aymaneaitmansour@gmail.com", password: "aymane", role: Role.student);
    DatabaseManager().insertUser(user);


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: Colors.blueAccent,
        child: Padding(
          padding: EdgeInsets.only(
              top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 50.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: _wrongEmail ? emailText : null,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _wrongPassword ? passwordText : null,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff447def),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onPressed: () async {
                    setState(() {
                      _showSpinner = true;
                      _wrongEmail = false;
                      _wrongPassword = false;
                    });
                    try {
                      bool isAuthenticated = await DatabaseManager().authenticateUser(email!, password!);

                      if (isAuthenticated) {
                        Navigator.pushReplacementNamed(context, HomePage.id);
                      } else {
                        setState(() {
                          _showSpinner = false;
                          _wrongEmail = true;
                          _wrongPassword = true;
                          emailText = 'Invalid credentials';
                          passwordText = 'Invalid credentials';
                        });
                      }
                    } catch (e) {
                      setState(() {
                        _showSpinner = false;
                        if (e is FirebaseAuthException && e.code == 'user-not-found') {
                          _wrongEmail = true;
                          emailText = 'User not found';
                        } else if (e is FirebaseAuthException && e.code == 'wrong-password') {
                          _wrongPassword = true;
                          passwordText = 'Wrong password';
                        }
                      });
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
