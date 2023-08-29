import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyTerminal extends StatefulWidget {
  @override
  _MyTerminalState createState() => _MyTerminalState();
}

List<Widget> y = [];
List<Widget> z = [];

class _MyTerminalState extends State<MyTerminal> {
  var cmd;
  var out;
  var fs = FirebaseFirestore.instance;
  web(command) async {
    var url = "http://192.168.1.20/cgi-bin/term.py?x=${command}";
    var r = await http.get(url);
    out = r.body;
    print(out);

    await fs.collection('hello').add({
      'cmd': cmd,
      'output': out,
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var msgtextController = TextEditingController();

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                width: width * 0.95,
                child: TextField(
                  controller: msgtextController,
                  onChanged: (val) {
                    cmd = val;
                  },
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    prefix: Text('[root@localhost]'),
                    suffix: Container(
                      child: FlatButton(
                        onPressed: () async {
                          web(cmd);
                          print(cmd);
                          msgtextController.clear();
                        },
                        child: Icon(Icons.send_sharp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            builder: (context, snapshot) {
              print('new data comes');
              y = [];
              z = [];
              var command = snapshot.data.docs;

              for (var d in command) {
                var cmd = d.data()['cmd'];
                var out = d.data()['output'];

                var msgWidget_cmd = Text('[root@localhost]$cmd');
                var msgWidget_out = Text('$out');

                y.add(msgWidget_cmd);
                z.add(msgWidget_out);

                print(y);
              }
              return Container(
                width: width,
                height: height * 0.55,
                child: List_terminal(),
              );
            },
            stream: fs.collection("hello").snapshots(),
          ),
        ],
      ),
    );
  }
}

class List_terminal extends StatefulWidget {
  @override
  _List_terminalState createState() => _List_terminalState();
}

class _List_terminalState extends State<List_terminal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: y.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: y[index],
              subtitle: z[index],
            );
          },
        ),
      ),
    );
  }
}
