// ignore_for_file: unused_element
import 'dart:math';
import 'package:bmi_uppgift/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/services.dart';

void main() {
  runApp(BmiApp());
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  double? result;
  _RootPageState({this.result});
  int? selectedValue;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your weight here (kg)",
                  labelText: "Weight",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: weightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 3,
                maxLines: 1,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your height here (cm)",
                  labelText: "Height",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: heightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 3,
                maxLines: 1,
              ),
              Container(
                height: 50,
                width: 270,
                child: ElevatedButton(
                  onPressed: () {
                    if (heightController.text.isNotEmpty &&
                        weightController.text.isNotEmpty) {
                      calculateBMI();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Counter(values: result),
                        ),
                      );
                    }
                  },
                  child: const Text("Calculate"),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text("BMI Calculator"),
            trailing: GestureDetector(
                child: Icon(Icons.settings),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text("Gender"),
                      message: const Text("Select gender"),
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          child: const Text("Male"),
                          onPressed: () {
                            setState(() {
                              selectedGender = "Male";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text("Female"),
                          onPressed: () {
                            setState(() {
                              selectedGender = "Female";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGender = null;
                            });
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                }),
          ),
          child: SafeArea(
            child: Container(
                padding: EdgeInsets.all(40.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CupertinoTextField(
                      placeholder: "Enter your weight here (kg)",
                      textAlign: TextAlign.center,
                      controller: weightController,
                      keyboardType: TextInputType.number,
                    ),
                    CupertinoTextField(
                      placeholder: "Enter your height here (cm)",
                      textAlign: TextAlign.center,
                      controller: heightController,
                      keyboardType: TextInputType.number,
                    ),
                    Text(
                      selectedGender == null
                          ? "Gender not selected"
                          : "${selectedGender} selected",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    CupertinoButton(
                      child: const Text("Calculate"),
                      onPressed: () {
                        if (heightController.text.isEmpty &&
                            weightController.text.isEmpty) {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text("Alert"),
                              content: const Text(
                                  "Textfields can't be empty ! Insert numbers."),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: Text("Got it!"),
                                  isDestructiveAction: false,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        } else {
                          calculateBMI();
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (BuildContext context) {
                                return Counter(
                                    values: result, selected: selectedGender);
                              },
                            ),
                          );
                        }
                      },
                    )
                  ],
                )),
          ));
    }
  }

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    double heightSquare = height * height;
    double finalresult = weight / heightSquare;
    result = finalresult;
    setState(() {});
  }
}

class BmiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.red),
            home: const RootPage(),
          )
        : const CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme:
                CupertinoThemeData(primaryColor: CupertinoColors.systemOrange),
            home: RootPage(),
          );
  }
}
