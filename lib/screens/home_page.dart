import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'result_page.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String gender = "Male";
  String system = "Metric";

  int currentIndex = 0;

  void calculateBMI() {
    if (heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your height"),
        ),
      );
      return;
    }

    if (weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your weight"),
        ),
      );
      return;
    }

    if (ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your age"),
        ),
      );
      return;
    }

    double? height = double.tryParse(heightController.text);
    double? weight = double.tryParse(weightController.text);

    if (height == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid height"),
        ),
      );
      return;
    }

    if (weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid weight"),
        ),
      );
      return;
    }

    double bmi;

    if (system == "Metric") {
      bmi = weight / ((height / 100) * (height / 100));
    } else {
      bmi = (weight * 703) / (height * height);
    }

    String result = "";

    if (bmi < 18.5) {
      result = "Underweight";
    } else if (bmi < 25) {
      result = "Healthy";
    } else if (bmi < 30) {
      result = "Overweight";
    } else {
      result = "Obese";
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          bmi: bmi,
          result: result,
          weight: weight,
        ),
      ),
    );
    if (height < 50 || height > 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid height"),
        ),
      );
      return;
    }

    if (weight < 10 || weight > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid weight"),
        ),
      );
      return;
    }
int? age = int.tryParse(ageController.text);

if (age == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please enter a valid age"),
    ),
  );
  return;
}
    if (age < 1 || age > 120) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid age"),
        ),
      );
      return;
    }
    if (height < 50 || height > 300) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please enter a valid height"),
    ),
  );
  return;
}

if (weight < 10 || weight > 500) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please enter a valid weight"),
    ),
  );
  return;
}

if (age < 1 || age > 120) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please enter a valid age"),
    ),
  );
  return;
}
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      Scaffold(
        appBar: AppBar(
          title: const Text("BMI Tracker"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Calculate BMI",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Provide your details",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: gender,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Gender",
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Male",
                            child: Text("Male"),
                          ),
                          DropdownMenuItem(
                            value: "Female",
                            child: Text("Female"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: system,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "System",
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Metric",
                            child: Text("Metric"),
                          ),
                          DropdownMenuItem(
                            value: "Imperial",
                            child: Text("Imperial"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            system = value!;
                            heightController.clear();
                            weightController.clear();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: heightController,
                  label: system == "Metric"
                      ? "Height (cm)"
                      : "Height (in)",
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: weightController,
                  label: system == "Metric"
                      ? "Weight (kg)"
                      : "Weight (lb)",
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: ageController,
                  label: "Age",
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: "Calculate",
                  onPressed: calculateBMI,
                ),
              ],
            ),
          ),
        ),
      ),
      const HistoryPage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Calculate",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
        ],
      ),
    );
  }
}