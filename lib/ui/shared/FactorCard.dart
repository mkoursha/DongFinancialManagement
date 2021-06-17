import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FactorCard extends StatefulWidget {
  @override
  _FactorCardState createState() => _FactorCardState();

  Factor factor;
  Group group;
  Color color;

  FactorCard(this.factor, this.group, this.color);
}

class _FactorCardState extends State<FactorCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: IconButton(
          icon: Icon(Icons.delete_forever_rounded),
          onPressed: () {
            Toast.show("Please wait ...", context);
            Injection.deleteFactor
                .deleteFactor(widget.factor.id, widget.group.id)
                .then(
              (value) {
                if (value == null) {
                  Toast.show(
                    "Factor deleted. Syncing ...",
                    context,
                    duration: 5,
                  );
                } else {
                  Toast.show(value.message, context);
                }
              },
            );
          },
        ),
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor: widget.color,
        ),
        title: Text(
          "${widget.factor.buyer.name}",
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cost : ${widget.factor.getCost()}",
            ),
            Text(
              "fid : ${widget.factor.id}",
            ),
          ],
        ),
      ),
    );
  }
}
