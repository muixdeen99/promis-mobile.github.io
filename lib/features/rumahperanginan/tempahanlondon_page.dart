import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/senaraiperanginan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:intl/intl.dart';
class TempahanLondonPage extends StatefulWidget {
  const TempahanLondonPage({super.key});

  @override
  State<TempahanLondonPage> createState() => _TempahanLondonPageState();
}

class _TempahanLondonPageState extends State<TempahanLondonPage> {
  final List<Map<String, dynamic>> tempahanList = [
    {
      'noInvois': 'BPH/IR/LN/2025/000012',
      'status': 'Baru',
      'statusColor': Colors.grey,
      'maklumatPeranginan': '',
      'tarikhMohon': '',
      'tarikhMasuk': '',
      'tarikhKeluar': '',
      'statusBayaran': ''
    },
    {
      'noInvois': 'BPH/IR/LN/2025/000011',
      'status': 'Lulus',
      'statusColor': Colors.green,
      'maklumatPeranginan': '',
      'tarikhMohon': '',
      'tarikhMasuk': '',
      'tarikhKeluar': '',
      'statusBayaran': ''
    },
    {
      'noInvois': 'BPH/IR/LN/2025/000013',
      'status': 'Lulus',
      'statusColor': Colors.green,
      'maklumatPeranginan': '',
      'tarikhMohon': '',
      'tarikhMasuk': '',
      'tarikhKeluar': '',
      'statusBayaran': ''
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Peranginan',
        pageName2: '    Tempahan London',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Senarai Tempahan London',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: tempahanList.length,
                    itemBuilder: (context, index) {
                      final tempahan = tempahanList[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tempahan['noInvois'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: tempahan['statusColor'],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      tempahan['status'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Text('Maklumat Peranginan:'),
                              const Text('Tarikh Mohon:'),
                              const Text('Tarikh Masuk:'),
                              const Text('Tarikh Keluar:'),
                              const Text('Status Bayaran:'),
                              const SizedBox(height: 12.0),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MaklumatPermohonanPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: const Text('Semak',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const MohonBaruPage(); // Target page
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Define the slide direction (e.g., from left to right)
                          const begin = Offset(1.0,
                              0.0); // Start position (-1.0, 0.0) is from the left
                          const end =
                              Offset.zero; // End position is the center (0, 0)
                          const curve = Curves.easeInOut;

                          // Create the tween for the sliding animation
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          // Apply the SlideTransition
                          return SlideTransition(
                            position:
                                offsetAnimation, // Slide from the left to the center
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(
                            milliseconds: 500), // Adjust duration as needed
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                  ),
                  child: const Text(
                    'Mohon Baru',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 2,
            left: 2,
            child: SizedBox(
              height: 40,
              width: 50,
              child: FloatingActionButton(
                elevation: 0,
                hoverElevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightElevation: 0,
                hoverColor: Colors.transparent,
                mini: true, // Makes the button smaller
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const RumahPeranginanPage(); // Target page
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin =
                            Offset(-1.0, 0.0); // Slide in from the left
                        const end = Offset.zero; // Final position at the center
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(
                          milliseconds: 500), // Adjust duration as needed
                    ),
                  );
                },
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MaklumatPermohonanPage extends StatelessWidget {
  const MaklumatPermohonanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Peranginan',
        pageName2: '    Semakan Tempahan London',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoText('No Tempahan:', 'BPH/IR/LN/2025/000012'),
                infoText('Tarikh Tempahan:', '01/01/2025'),
                infoText('Rumah Peranginan:', 'London'),
                infoText('Jenis Unit:', 'Deluxe'),
                infoText('Tarikh Masuk:', '05/01/2025'),
                infoText('Tarikh Keluar:', '10/01/2025'),
                infoText('Bil Malam Menginap:', '5'),
                infoText('Amaun Perlu Dibayar (RM):', '1500'),
                infoText('Tarikh Akhir Bayaran:', '03/01/2025'),
                infoText('Status Tempahan:', 'Lulus'),
                infoText('Status Bayaran:', 'Dibayar'),
                infoText('Surat Kelulusan:', 'Ada'),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CETAK BORANG TEMPAHAN LONDON',
                    style: TextStyle(
                      color: Colors.indigo,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'Batal Permohonan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 2,
            left: 2,
            child: SizedBox(
              height: 40,
              width: 50,
              child: FloatingActionButton(
                elevation: 0,
                hoverElevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightElevation: 0,
                hoverColor: Colors.transparent,
                mini: true, // Makes the button smaller
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const TempahanLondonPage(); // Target page
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin =
                            Offset(-1.0, 0.0); // Slide in from the left
                        const end = Offset.zero; // Final position at the center
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(
                          milliseconds: 500), // Adjust duration as needed
                    ),
                  );
                },
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }
}

class MohonBaruPage extends StatefulWidget {
  const MohonBaruPage({super.key});

  @override
  State<MohonBaruPage> createState() => _MohonBaruPageState();
}

class _MohonBaruPageState extends State<MohonBaruPage> {
  final TextEditingController _tarikhTempahanController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController _tarikhMasukController = TextEditingController();
  final TextEditingController _tarikhKeluarController = TextEditingController();

  String? _rumahPeranginan;
  String? _jenisUnit;

  final List<String> rumahPeranginanList = ['London', 'Paris', 'New York'];
  final List<String> jenisUnitList = ['Deluxe', 'Standard', 'Suite'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Peranginan',
        pageName2: '    Tempahan London',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _tarikhTempahanController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Tarikh Tempahan',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _rumahPeranginan,
                  decoration: const InputDecoration(
                    labelText: 'Rumah Peranginan',
                    border: OutlineInputBorder(),
                  ),
                  items: rumahPeranginanList.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      )).toList(),
                  onChanged: (value) => setState(() => _rumahPeranginan = value),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _jenisUnit,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Unit',
                    border: OutlineInputBorder(),
                  ),
                  items: jenisUnitList.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      )).toList(),
                  onChanged: (value) => setState(() => _jenisUnit = value),
                ),
                const SizedBox(height: 12),
                _buildDateInput('Tarikh Masuk', _tarikhMasukController),
                _buildDateInput('Tarikh Keluar', _tarikhKeluarController),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                    
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Simpan',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          readOnly: true,
          controller: controller,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              controller.text = DateFormat('dd/MM/yyyy').format(picked);
            }
          },
          decoration: InputDecoration(
            hintText: 'Pilih Tarikh',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
