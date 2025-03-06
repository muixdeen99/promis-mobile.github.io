import 'package:flutter/material.dart';
import 'package:promis/components/infoCard.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SemakanStatusJanjitemuPage extends StatefulWidget {
  const SemakanStatusJanjitemuPage({super.key});

  @override
  State<SemakanStatusJanjitemuPage> createState() =>
      _SemakanStatusJanjitemuPageState();
}

class _SemakanStatusJanjitemuPageState
    extends State<SemakanStatusJanjitemuPage> {
  final List<Map<String, dynamic>> permohonanList = [
    {
      'noPermohonan': '11111',
      'lokasiKuarters': 'Kuarters A',
      'tarikhPermohonan': '01/02/2024',
      'statusAgihan': 'Telah Diedarkan',
      'status': 'Lulus',
    },
    {
      'noPermohonan': '2222',
      'lokasiKuarters': 'Kuarters A',
      'tarikhPermohonan': '10/02/2024',
      'statusAgihan': 'Telah Diedarkan',
      'status': 'Lulus',
    },
    {
      'noPermohonan': '3333',
      'lokasiKuarters': 'Kuarters B',
      'tarikhPermohonan': '15/01/2024',
      'statusAgihan': 'Belum Diedarkan',
      'status': 'Deraf',
    },
  ];

  String? userId;
  // List<dynamic> permohonanKuarters = [];
  List<dynamic> permohonanKuarters = [];
  List<dynamic> janjitemuKeluar = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      print('User ID: $userId');
      setState(() {
        this.userId = userId;
      });

      if (userId != null) {
        await _fetchPermohonanKuarters(userId);
        await _fetchJanjitemuKeluar(userId);
      }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  Future<void> _fetchPermohonanKuarters(String userId) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.kuartersApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/janjitemu/ambil-surat-tawaran',
      );
      print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          permohonanKuarters = response.data['data'];
        });
        print('Data: $permohonanKuarters');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _fetchJanjitemuKeluar(String userId) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.kuartersApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/janjitemu/ambil-kunci',
      );
      print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          janjitemuKeluar = response.data['data'];
        });
        print('Data: $janjitemuKeluar');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  TextEditingController _tarikhMulaController = TextEditingController();
  String? _selectedJanjitemu;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<Map<String, dynamic>> janjitemu = [
    {'id': '1', 'keterangan': 'SERAHAN DOKUMEN DAN AMBIL SURAT TAWARAN'},
    {'id': '2', 'keterangan': 'AMBIL KUNCI'},
  ];

  String selectedValue = "Option 1"; // Default selected value

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: const CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Status Janjitemu',
          pageName2: 'Senarai Permohonan',
        ),
        drawer: const CustomDrawer(),
        body: Container(
          color: Color.fromARGB(255, 235, 241, 253),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            Color.fromARGB(255, 17, 54, 107)),
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    'Tapis Carian',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      labelText: 'Janjitemu',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Pill shape
                                        borderSide: BorderSide(
                                            color: Colors.blue), // Border color
                                      ),
                                    ),
                                    value: _selectedJanjitemu,
                                    items: janjitemu
                                        .map((Map<String, dynamic> item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'],
                                        child: Text(item['keterangan']),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedJanjitemu = newValue;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _tarikhMulaController,
                                    decoration: InputDecoration(
                                      labelText: 'Tarikh Janjitemu',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Pill shape
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          _tarikhMulaController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Tutup'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle filter action
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll<Color>(
                                                  Color.fromARGB(
                                                      255, 17, 54, 107)),
                                        ),
                                        child: const Text(
                                          'Tapis',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.filter_list, color: Colors.white),
                      label: Text('Tapis',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.blue, // Background color
                      // ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                permohonanKuarters.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: permohonanKuarters.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            child: Card(
                                              surfaceTintColor: Colors.white,
                                              // elevation: 5,
                                              // shadowColor: Colors.black,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    Table(
                                                      columnWidths: const {
                                                        0: FlexColumnWidth(2),
                                                        1: FlexColumnWidth(3),
                                                      },
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Nama Pemohon ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['namaPemohon']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Tarikh Janjitemu ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['tarikhJanjitemu']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Waktu Janjitemu ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['masaJanjitemu']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Nama Pegawai ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['namaPegawaiJanjitemu']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Tujuan ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['keteranganTujuanJanjitemu']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Status ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Wrap(children: [
                                                              Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .amberAccent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Text(
                                                                  '${permohonanKuarters[index]['keteranganStatusJanjitemu'] ?? '-'}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text('Tiada Permohonan Dibuat'),
                                      )
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
