import 'package:dong/ui/base.dart';
import 'package:dong/ui/home/homescreen.dart';
import 'package:dong/ui/login/loginviewModel.dart';
import 'package:dong/ui/register/registerscreen.dart';
import 'package:dong/values/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  String _title;

  LoginScreen({String title: 'Login'}) {
    this._title = title;
  }

  String getTitle() {
    return _title;
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

var viewmodel = LoginViewModel();
var email = '';
var pasw = '';

bool checkBoxValue = false;

class _LoginScreenState extends State<LoginScreen> {
  final appLogo = Icon(
    appIcon,
    size: 90,
    color: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    return scaffold(
        widget.getTitle(),
        Container(
          child: Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    appLogo,
                    emailInput,
                    passwordInput,
                    CheckboxListTile(
                        title: Text("Remember Me"),
                        value: checkBoxValue,
                        activeColor: Colors.green,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkBoxValue = newValue;
                          });
                        }),
                    RichText(
                        text: new TextSpan(children: [
                      TextSpan(
                        text: 'Do you forget your password? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                          text: "yes",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            })
                    ])),
                    loginButton(() {
                      viewmodel.login(email, pasw, () {}, (message) {
                        Toast.show(message, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      });
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("Or"),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                          color: Colors.red,
                          child: Text("Continue With Google"),
                          onPressed: () {
                            //todo signing with google
                          }),
                    ),
                    signupHintText(context)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  static final textStyle = TextStyle(
    fontFamily: 'Anton',
    fontSize: 20,
  );

  final emailInput = TextField(
    onChanged: (text) => {email = text},
    decoration: InputDecoration(hintText: 'Email or Phone Number'),
    keyboardType: TextInputType.emailAddress,
    style: textStyle,
  );

  final passwordInput = TextField(
      onChanged: (text) => {pasw = text},
      decoration: InputDecoration(hintText: 'Password'),
      obscureText: true,
      style: textStyle);

  Widget loginButton(Function onPressed) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(
        'Login',
      ),
    );
    /* return Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: FlatButton(
          onPressed: onPressed,
          child: Text(

              //style: TextStyle(color: Colors.white),
              ),
          //color: Colors.blue,
        ),
      ),
    ); */
  }

  Widget signupHintText(BuildContext context) {
    return RichText(
        text: new TextSpan(children: [
      TextSpan(
        text: 'New to Dong? ',
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
          text: 'sign up!',
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.underline,
          ),
          recognizer: new TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            })
    ]));
  }
}
