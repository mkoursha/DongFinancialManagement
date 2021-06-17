import 'package:dong/backend/exposed/calculate/calculate_dong.dart';
import 'package:dong/data/entities.dart';
import 'package:dong/ui/common/cadu_screen.dart';
import 'package:flutter/material.dart';

class CalculationScreen extends StatefulWidget {
  final Group group;

  CalculationScreen({this.group});
  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  @override
  Widget build(BuildContext context) {
    return CaduScreen(
      cadu: CalculateDong().calculateInGroup(widget.group),
    );
  }
}
