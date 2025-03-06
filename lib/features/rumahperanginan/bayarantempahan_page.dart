import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/rumahperanginan/senaraiperanginan.page.dart';
import 'package:promis/features/rumahperanginan/tempahanrumahperanginan_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';

class BayarantempahanPage extends StatefulWidget {
  const BayarantempahanPage({super.key});

  @override
  State<BayarantempahanPage> createState() => _BayarantempahanPageState();
}

class _BayarantempahanPageState extends State<BayarantempahanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: '    Dewan dan Gelanggang',
          pageName2: '    Tempahan Dewan'),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Maklumat Permohonan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('No. Tempahan :'),
                      Text('Jenis Permohonan :'),
                      Text('Rumah Peranginan :'),
                      Text('Jenis Unit :'),
                      Text('Tarikh Permohonan :'),
                      Text('Tarikh Daftar Masuk :'),
                      Text('Tarikh Daftar Keluar :'),
                      Text('Bil. Unit :'),
                      Text('Bil. Dewasa :'),
                      Text('Bil. Kanak-Kanak :'),
                      Text('Status Tempahan :'),
                      Text('Status Bayaran :'),
                      Text('Tarikh Bayaran :'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Senarai Tempahan & Bayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.black12),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('No.', textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Keterangan', textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Kuantiti', textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Amaun', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('', textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('', textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('', textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.black12),
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Jumlah Keseluruhan', textAlign: TextAlign.left),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.fill,
                          child: Container(
                            color: Colors.black12,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(''),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.fill,
                          child: Container(
                            color: Colors.black12,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(''),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.fill,
                          child: Container(
                            color: Colors.black12,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(''),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: const Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: const Text('Batal Permohonan', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
