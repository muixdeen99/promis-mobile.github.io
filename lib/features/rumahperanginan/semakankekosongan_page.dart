import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';

class SemakankekosonganPage extends StatefulWidget {
  const SemakankekosonganPage({super.key});

  @override
  State<SemakankekosonganPage> createState() => _SemakankekosonganPageState();
}

class _SemakankekosonganPageState extends State<SemakankekosonganPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tarikhMasukController = TextEditingController();
  final TextEditingController _tarikhKeluarController = TextEditingController();

  // Function to show DatePicker and set selected date
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(userName: "userName", pageName1: "Semakan Kekosongan", pageName2: "pageName2"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centered Title
            const Center(
              child: Text(
                'Senarai Semakan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Nama Peranginan
            const Text('Nama Peranginan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan Nama Peranginan',
              ),
            ),
            const SizedBox(height: 16),

            // Tarikh Masuk
            const Text('Tarikh Masuk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _tarikhMasukController,
              readOnly: true, // Prevent manual typing
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih Tarikh Masuk',
                suffixIcon: Icon(Icons.calendar_today), // Calendar icon
              ),
              onTap: () => _selectDate(context, _tarikhMasukController),
            ),
            const SizedBox(height: 16),

            // Tarikh Keluar
            const Text('Tarikh Keluar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _tarikhKeluarController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih Tarikh Keluar',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context, _tarikhKeluarController),
            ),
            const SizedBox(height: 16),

            // Submit Button aligned to the right
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  String name = _nameController.text;
                  String tarikhMasuk = _tarikhMasukController.text;
                  String tarikhKeluar = _tarikhKeluarController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nama: $name\nMasuk: $tarikhMasuk\nKeluar: $tarikhKeluar')),
                  );
                },
                child: const Text('Carian'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
