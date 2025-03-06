import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/infoCard.dart';
import 'package:promis/features/rumahperanginan/sejarahpermohonan_details_page.dart';
import 'package:promis/features/rumahperanginan/tempahaneksekutif.page.dart';
import 'package:promis/features/rumahperanginan/terimaankelompok_details_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';

class SejarahPermohonanPage extends StatefulWidget {
  const SejarahPermohonanPage({super.key});

  @override
  State<SejarahPermohonanPage> createState() => _SejarahPermohonanPageState();
}

class _SejarahPermohonanPageState extends State<SejarahPermohonanPage> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  List<Map<String, String>> status = [
    {'status': 'berjaya'},
    {'status': 'gagal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Sejarah Permohonan',
        pageName2: '    ',
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0), // Adjust padding as needed
                child: Column(
                  children: <Widget>[
                    Text(
                      'Sejarah Permohonan',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Carian',
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            onPressed: _selectDate,
                            icon:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            label: Text('Tarikh Masuk',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                            width: 10), // Add some space between the buttons
                        Expanded(
                          child: TextButton.icon(
                            style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            onPressed: _selectDate,
                            icon:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            label: Text('Tarikh Keluar',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Infocard(
                      title: 'Maklumat Permohonan',
                      data: [
                        {'Nama Pemohon': 'test'},
                        {'No. Kad Pengenalan': 'test'},
                        {'Gred': 'test'},
                        {'Tarikh Mohon': 'test'},
                        {'Status': 'test'},
                        // {'Negeri': '${permohonanKuarters['namaPemohon']}'},
                        // {'Tarikh Permohonan': '${permohonanKuarters['namaPemohon']}'},
                        // {'Jenis Perumahan': '${permohonanKuarters['namaPemohon']}'},
                      ],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                  builder: (context) => SejarahpermohonanDetailsPage(),
                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
