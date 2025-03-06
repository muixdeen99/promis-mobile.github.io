import 'package:flutter/material.dart';

class Infocard extends StatelessWidget {
  final List<Map<String, String>> data;
  final bool showLine;
  final bool showSemakButton;
  final String title;
  final VoidCallback? onPressed;

  const Infocard({
    Key? key,
    required this.data,
    this.showLine = true,
    this.showSemakButton = true,
    this.title = "",
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
              Text(
                title,
                style: const TextStyle(
                fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ],
            ),
            if (showLine) const Divider(thickness: 1),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: data.map((row) {
                return TableRow(
                  children: [
                    Text(
                      row.keys.first,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      row.values.first,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            if (showLine) const SizedBox(height: 20),
            if (showLine) const Divider(thickness: 1),
            if (showSemakButton)
              Stack(
                children: [
                  SizedBox(
                    height: 40,
                    width: 450,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(onPressed: onPressed, child: const Text('Semak', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),)),
                    ),
                  ),
                  
                ],
              ),
          ],
        ),
      ),
    );
  }
}