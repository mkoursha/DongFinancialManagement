import 'package:dong/backend/exposed/calculate/cadu.dart';
import 'package:dong/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CaduScreen extends StatelessWidget {
  final List<CADU> cadu;

  const CaduScreen({
    this.cadu,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: cadu.isEmpty
          ? Center(
              child: Text("EMPTY NO DEBTS!"),
            )
          : ListView.builder(
              itemBuilder: (_, i) => _CaduItemWidget(
                cadu: cadu[i],
              ),
              itemCount: cadu.length,
            ),
    );
  }
}

class _CaduItemWidget extends StatelessWidget {
  final CADU cadu;

  const _CaduItemWidget({
    this.cadu,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (_, s) {
        if (s.connectionState != ConnectionState.done) return Container();
        return Container(
          height: MediaQuery.of(context).size.width * 0.15,
          width: MediaQuery.of(context).size.width,
          color: cadu.debtorName == Injection.localDataSource.userId
              ? Colors.red
              : Colors.green,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Creditor : ${Injection.getUser.userByIdSync(cadu.creditorName).name}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Debtor : ${Injection.getUser.userByIdSync(cadu.debtorName).name}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Amount : ${cadu.number * cadu.unitPrice}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
      future: Injection.getUser
          .userById(cadu.creditorName)
          .then((value) => Injection.getUser.userById(cadu.debtorName)),
    );
  }
}
