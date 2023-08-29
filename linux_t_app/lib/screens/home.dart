import 'package:flutter/material.dart';
import 'package:linux_terminal/screens/terminal.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Linux Terminal'),
        ),
        body: Center(
          child: Container(
            width: width * 0.95,
            height: height * 0.75,
            color: Colors.black,
            child: MyTerminal(),
          ),
        ),
      ),
    );
  }
}
