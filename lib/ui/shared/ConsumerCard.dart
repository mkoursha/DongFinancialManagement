import 'package:dong/data/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsumerCard extends StatefulWidget {
  final Consumer consumer;
  @override
  _ConsumerCardState createState() => _ConsumerCardState();

  Color _color;
  bool shared = false;
  String _name;
  TextEditingController numused = TextEditingController();

  ConsumerCard(
    this._name,
    this._color,
    this.consumer,
  );
}

class _ConsumerCardState extends State<ConsumerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                  maxRadius: 15.0,
                  backgroundColor: widget._color,
                ),
                title: Text(
                  "${widget._name}",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 110.0),
            child: TextFormField(
              initialValue: widget.consumer.number.toString(),
              textAlign: TextAlign.center,
              onChanged: (val) =>
                  widget.consumer.number = double.tryParse(val) ?? 0.0,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "NumUsed",
                  hintStyle: TextStyle(fontSize: 10.0),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 2.0)),
            ),
          )),
          Column(
            children: [
              Text(
                "Shared",
                style: TextStyle(fontSize: 10.0),
              ),
              Checkbox(
                activeColor: widget._color,
                value: widget.shared,
                onChanged: (value) {
                  setState(() {
                    widget.shared = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
