import 'package:dong/di.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String perModSel = "Simple";
  bool colVisibility = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creating Group"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextFormField(
              controller: controller,
              maxLength: 20,
              decoration: InputDecoration(labelText: "Group Name:"),
            ),
          ),
          FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Injection.createGroup
                    .createGroup(name: controller.text)
                    .then((value) {
                  if (value == null)
                    Navigator.of(context).pop();
                  else {
                    Toast.show(value.message, context);
                  }
                });
              },
              child: Text("Create"))
        ],
      ),
    );
  }
}
