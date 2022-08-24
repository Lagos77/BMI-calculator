// ignore_for_file: unused_element
import 'dart:math';
import 'package:bmi_uppgift/counter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BmiApp());
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? result;
  _RootPageState({this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
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
                child: Text("Calculate"),
              ),
            ),
          ],
        ),
      ),
    );
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: RootPage(),
    );
  }
}
