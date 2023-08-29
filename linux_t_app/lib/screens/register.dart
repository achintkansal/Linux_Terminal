import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyRegister extends StatefulWidget {
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

var email, pswd;
var user;
bool sspin = false;

class _MyRegisterState extends State<MyRegister> {
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
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: Center(
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
                        hintText: 'Enter new username',
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
                        hintText: 'Enter new password',
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
                            user = await authc.createUserWithEmailAndPassword(
                                email: email, password: pswd);
                            print(user);
                          } catch (e) {
                            print(e);
                          }
                          if (user != null) {
                            Navigator.pushNamed(context, 'home');
                            setState(() {
                              sspin = false;
                            });
                          }
                        },
                        child: Text('Register'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
