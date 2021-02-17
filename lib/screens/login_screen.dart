import 'package:flutter/material.dart';
import 'package:flutter_chat_app/components/rounded_button.dart';
import 'package:flutter_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_chat_app/components/build_popup.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showProgress,
        opacity: 0.3,
        // color: Colors.grey,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Color(0xFF9575CD),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.blueGrey),
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                style: TextStyle(color: Colors.blueGrey),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                onPressed: () async {
                  setState(() {
                    showProgress = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
                      Navigator.pushNamed((context), ChatScreen.id);
                      //print(user.email);
                    }
                    setState(() {
                      showProgress = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      showProgress = false;
                    });
                    if (e.code == 'user-not-found') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => BuildPopUp(
                          title: "User Not Found",
                          description: 'pahle register to karle bhai',
                        ),
                      );
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => BuildPopUp(
                          title: "User Not Found",
                          description: 'You have entered wrong password',
                        ),
                      );
                      print('Wrong password provided for that user.');
                    }
                  } catch (e) {
                    setState(() {
                      showProgress = false;
                    });
                    print(e);
                  }
                },
                color: Colors.deepPurpleAccent,
                text: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
