import 'package:flutter/material.dart';

class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  TextEditingController phoneCon;

  @override
  Widget build(BuildContext context) {
    phoneCon = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invitation",
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 75,
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Text(
                "Enter phone number of the person you want to invite him. ",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: TextFormField(
                controller: phoneCon,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                  child: Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    //here we send a sms to phone number inserted
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
