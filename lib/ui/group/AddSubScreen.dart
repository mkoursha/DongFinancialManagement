import 'package:dong/data/entities.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../di.dart';

class AddSubScreen extends StatefulWidget {
  @override
  _AddSubScreenState createState() => _AddSubScreenState();
  Group group;

  AddSubScreen(this.group);
}

class _AddSubScreenState extends State<AddSubScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Subscriber"),
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
              decoration: InputDecoration(labelText: "User Id:"),
            ),
          ),
          FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Injection.addSubscriber
                    .addSubscriber(controller.text, widget.group.id)
                    .then((value) {
                  if (value == null) {
                    Navigator.pop(context);
                  } else {
                    Toast.show(
                      value.message,
                      context,
                      gravity: Toast.CENTER,
                    );
                  }
                });
              },
              child: Text("Add"))
        ],
      ),
    );
  }
}
