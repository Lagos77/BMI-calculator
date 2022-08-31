import 'dart:ffi';
import 'package:bmi_uppgift/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Counter extends StatelessWidget {
  double? values;
  String? bmiStatus;
  String? bmiMessage;
  String? selected;

  Counter({this.values, this.selected});
  @override
  Widget build(BuildContext context) {
    setBmiStatus();
    return Platform.isAndroid
        ? Scaffold(
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
          )
        : CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text("Result"),
              automaticallyImplyLeading: false,
            ),
            child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      selected == null ? "No gender selected" : "$selected",
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      "$bmiStatus",
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      values == null
                          ? "Enter a value"
                          : "${values?.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                      ),
                    ),
                    CupertinoButton.filled(
                      child: Text("Re-calculate"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
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
