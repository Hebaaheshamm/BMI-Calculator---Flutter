import 'package:flutter/material.dart';
import '../data/history_data.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI History"),
        centerTitle: true,
      ),
      body: historyList.isEmpty
          ? const Center(
              child: Text(
                "No History Yet",
                style: TextStyle(fontSize: 22),
              ),
            )
          : ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        historyList[index].bmi.toStringAsFixed(1),
                      ),
                    ),
                    title: Text(historyList[index].result),
                    subtitle: Text(
                      "Weight : ${historyList[index].weight} kg",
                    ),
                  ),
                );
              },
            ),
    );
  }
}