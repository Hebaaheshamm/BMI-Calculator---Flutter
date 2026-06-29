import 'package:flutter/material.dart';

import '../data/history_data.dart';
import '../models/bmi_model.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  final String result;
  final double weight;

  const ResultPage({
    super.key,
    required this.bmi,
    required this.result,
    required this.weight,
  });

  Color getColor() {
    if (result == "Healthy") {
      return Colors.green;
    } else if (result == "Underweight") {
      return Colors.blue;
    } else if (result == "Overweight") {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void saveResult() {
    historyList.add(
      BMIModel(
        bmi: bmi,
        result: result,
        weight: weight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Result"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 30),

            const Text(
              "Your Current BMI",
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              bmi.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: getColor(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                result,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            const SizedBox(height: 40),

            Text(
              "Your BMI is ${bmi.toStringAsFixed(1)}",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              result,
              style: TextStyle(
                fontSize: 28,
                color: getColor(),
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  saveResult();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Saved Successfully"),
                    ),
                  );
                },
                child: const Text(
                  "Save Result",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}