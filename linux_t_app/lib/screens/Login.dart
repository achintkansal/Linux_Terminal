import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

var email, pswd;
var signIn;
bool sspin = false;

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var authc = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ModalProgressHUD(
        inAsyncCall: sspin,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.black,
          body: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: Image.asset('images/images.png'),
              ),
              Center(
                child: Container(
                  width: width * 0.75,
                  height: height * 0.50,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: width * 0.70,
                        child: TextField(
                          onChanged: (val) {
                            email = val;
                          },
                          decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.70,
                        child: TextField(
                          onChanged: (val) {
                            pswd = val;
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width * 0.50,
                        child: Material(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          elevation: 10,
                          child: MaterialButton(
                            onPressed: () async {
                              try {
                                setState(() {
                                  sspin = true;
                                });
                                signIn = await authc.signInWithEmailAndPassword(
                                    email: email, password: pswd);
                                print(signIn);
                              } catch (e) {
                                print(e);
                              }
                              if (signIn != null) {
                                Navigator.pushNamed(context, 'home');
                                setState(() {
                                  sspin = false;
                                });
                              } else {
                                setState(() {
                                  sspin = false;
                                });

                                print('invalid input');
                                Fluttertoast.showToast(
                                  msg: "Invalid username or password",
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              }
                            },
                            child: Text('Login'),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: Text(
                          "Don't have an account? Register here",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
