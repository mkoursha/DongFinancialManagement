import 'package:flutter/material.dart';

class GoodCard extends StatefulWidget {
  @override
  _GoodCardState createState() => _GoodCardState();

  GoodCard(this._goodName);

  Color _color;
  String _goodName;
  DateTime dt = DateTime.now();
}

class _GoodCardState extends State<GoodCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.shopping_bag),
                ),
                title: Text(
                  "${widget._goodName}",
                ),
                subtitle: Text(
                  "${widget.dt.toString().substring(0,19)}",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
