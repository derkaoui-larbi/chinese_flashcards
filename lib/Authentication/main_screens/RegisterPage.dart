import 'package:flutter/material.dart';
import '../../Authentication/results_screen/Done.dart';
import '../../Authentication/results_screen/GoogleDone.dart';
import '../../Authentication/main_screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:validators/validators.dart' as validator;

import '../../Users/Userc.dart';
import '../../databases/database_manager.dart';
import '../../pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name;
  String? email;
  String? password;

  bool _showSpinner = false;

  bool _wrongEmail = false;
  bool _wrongPassword = false;

  String _emailText = 'Please use a valid email';
  String _passwordText = 'Please use a strong password';

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _handleSignIn() async {
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      return _auth.currentUser;
    } else {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleAuth == null) return null;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      return (await _auth.signInWithCredential(credential)).user;
    }
  }

  void onGoogleSignIn(BuildContext context) async {
    User? user = await _handleSignIn();
    if (user != null) {
      Navigator.pushNamed(context, GoogleDone.id, arguments: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: Colors.blueAccent,
        child: Padding(
          padding: EdgeInsets.only(
              top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Register',
                style: TextStyle(fontSize: 50.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lets get',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text(
                    'you on board',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
              Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      labelText: 'Full Name',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _wrongEmail ? _emailText : null,
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
                      errorText: _wrongPassword ? _passwordText : null,
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


                    if (validator.isEmail(email ?? '') && validator.isLength(password ?? '', 6)) {

                      Userc user = Userc(fullName: name!, email: email!, password: password!, role: Role.student);
                      DatabaseManager().insertUser(user);


                      Navigator.pushReplacementNamed(context, LoginPage.id);


                    } else {
                      setState(() {
                        _wrongEmail = !validator.isEmail(email ?? '');
                        _wrongPassword = !validator.isLength(password ?? '', 6);
                      });
                    }
                  } catch (e) {
                    setState(() {
                      _showSpinner = false;
                      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
                        _wrongEmail = true;
                        _emailText = 'The email address is already in use by another account';
                      }
                    });
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
              // ... Rest of the widgets like Google and Facebook sign-in buttons
              // ...
            ],
          ),
        ),
      ),
    );
  }
}
