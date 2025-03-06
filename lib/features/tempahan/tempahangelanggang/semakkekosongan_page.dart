import 'package:flutter/material.dart';

class SemakKekosonganPage extends StatelessWidget {
  const SemakKekosonganPage({Key? key}) : super(key: key);

  final List<String> timeSlots = const [
    '8:00 am - 9:00 am',
    '9:00 am - 10:00 am',
    '10:00 am - 11:00 am',
    '11:00 am - 12:00 pm',
    '12:00 pm - 1:00 pm',
    '1:00 pm - 2:00 pm',
    '2:00 pm - 3:00 pm',
    '3:00 pm - 4:00 pm',
    '4:00 pm - 5:00 pm',
    '5:00 pm - 6:00 pm',
    '6:00 pm - 7:00 pm',
    '7:00 pm - 8:00 pm',
    '8:00 pm - 9:00 pm',
    '9:00 pm - 10:00 pm',
    '10:00 pm - 11:00 pm'
  ];

  final List<String> courts = const ['Court 1', 'Court 2', 'Court 3'];

  // Hardcoded booked slots for demonstration
  final Map<String, List<String>> bookedSlots = const {
    'Court 1': ['9:00 am - 10:00 am', '1:00 pm - 2:00 pm', '6:00 pm - 7:00 pm', '7:00 pm - 8:00 pm'],
    'Court 2': ['9:00 am - 10:00 am', '1:00 pm - 2:00 pm', '8:00 pm - 9:00 pm', '9:00 pm - 10:00 pm'],
    'Court 3': ['11:00 am - 12:00 pm']
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text('Semak Kekosongan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          _buildLegend(),
          const SizedBox(height: 8),
          Expanded(child: _buildAvailabilityTable()),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _buildLegendItem(Colors.white, 'Tersedia'),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.blue, 'Ditempah'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: color, child: color == Colors.white ? null : const Icon(Icons.circle, color: Colors.white, size: 8)),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget _buildAvailabilityTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20, // Reduce column spacing to make them closer
        dataRowHeight: 50, // Adjust row height if needed
        headingRowHeight: 40, // Adjust the header row height
        columns: [
          const DataColumn(label: Text('')),
          ...courts.map((court) => DataColumn(label: Text(court))),
        ],
        rows: timeSlots.map((slot) {
          return DataRow(
            cells: [
              DataCell(Text(slot)),
              ...courts.map((court) => DataCell(Container(
                color: bookedSlots[court]?.contains(slot) == true ? Colors.blue : Colors.white,
                height: 20,
                width: 50, // Reduce width if you want even tighter spacing
              ))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
