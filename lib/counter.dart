import 'dart:ffi';
import 'package:bmi_uppgift/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Counter extends StatelessWidget {
  double? values;
  String? bmiStatus;
  String? bmiMessage;

  Counter({this.values});
  @override
  Widget build(BuildContext context) {
    setBmiStatus();
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "$bmiStatus",
              style: const TextStyle(fontSize: 40, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              values == null
                  ? "Enter a value"
                  : "${values?.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 35, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 50,
              width: 270,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Re-calculate"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setBmiStatus() {
    if (values! < 18.5) {
      bmiStatus = "Underweight";
    } else if (values! >= 18.5 && values! <= 24.9) {
      bmiStatus = "Normal weight";
    } else if (values! >= 25 && values! <= 29.9) {
      bmiStatus = "Overweight";
    } else if (values! >= 30 && values! <= 34.9) {
      bmiStatus = "Obese";
    } else if (values! >= 35) {
      bmiStatus = "Extreme obese";
    }
  }
}
