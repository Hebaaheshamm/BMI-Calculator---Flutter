import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    DateTime now = DateTime.now();

    String date = "${now.day}/${now.month}/${now.year}";

    var box = Hive.box("history");

    box.add({
      "bmi": bmi,
      "result": result,
      "weight": weight,
      "date": date,
    });
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
              style: TextStyle(fontSize: 20),
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

            const SizedBox(height: 40),

            const Text(
              "BMI Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;

                  double position;

                  if (bmi < 18.5) {
                    position = (bmi / 18.5) * (width / 4);
                  } else if (bmi < 25) {
                    position = (width / 4) +
                        ((bmi - 18.5) / (25 - 18.5)) * (width / 4);
                  } else if (bmi < 30) {
                    position = (width / 2) +
                        ((bmi - 25) / (30 - 25)) * (width / 4);
                  } else {
                    double value = bmi;

                    if (value > 40) {
                      value = 40;
                    }

                    position = (width * 3 / 4) +
                        ((value - 30) / 10) * (width / 4);
                  }

                  if (position > width - 24) {
                    position = width - 24;
                  }

                  return Column(
                    children: [
                    Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 12,
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 12,
                              color: Colors.green,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 12,
                              color: Colors.orange,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 12,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        left: position - 17,
                        top: -18,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: getColor(),
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                      const SizedBox(height: 8),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("18.5"),
                          Text("25"),
                          Text("30"),
                          Text("40+"),
                        ],
                      ),

                      const SizedBox(height: 8),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Under",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "Healthy",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            "Over",
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            "Obese",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
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

                        Navigator.pop(context);
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