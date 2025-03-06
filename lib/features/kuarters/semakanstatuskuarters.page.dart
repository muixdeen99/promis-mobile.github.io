import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/kuarters/permohonanKuartersDetails.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class SemakanStatusKuartersPage extends StatefulWidget {
  const SemakanStatusKuartersPage({super.key});

  @override
  State<SemakanStatusKuartersPage> createState() =>
      _SemakanStatusKuartersPageState();
}

class _SemakanStatusKuartersPageState extends State<SemakanStatusKuartersPage> {
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
  bool isQtrUser = false;
  bool QtrUser = false;
  List<dynamic> permohonanKuarters = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadIsQtrUser();
  }

  // Future<void> _fetchUserRole() async {
  //   final apiUrl =
  //       'https://gerbang.lokal.my/api/pentadbiran/v1/mobile/pengguna/${userId}/peranan';
  //   try {
  //     final response = await Dio().get(apiUrl);
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       for (var role in data) {
  //         print('keterangan: ${role['keterangan']}');
  //         if (role['keterangan'].contains('(QTR)')) {
  //           setState(() {
  //             isQtrUser = true;
  //             print('isQtrUser: $isQtrUser');
  //           });
  //           break;
  //         }
  //       }
  //     } else {
  //       print('Failed to load user role: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching user role: $e');
  //   }
  // }

  Future<void> _loadIsQtrUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isQtrUser = prefs.getBool('isQtrUser') ?? false;
      });
      print('isQtrUser: $isQtrUser');
    } catch (e) {
      print('Error loading isQtrUser: $e');
    }
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
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        QtrUser = prefs.getBool('isQtrUser') ?? false;
      });
      print('QtrUser: $QtrUser');
    } catch (e) {
      print('Error loading QtrUser: $e');
    }

    const currentUser = "000119130962";
    Response response;

    try {
      response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/pemohon/$userId/permohonan',
      );

      if (QtrUser) {
        response = await apiService.makeRequest(
          RequestMethod.get,
          'mobile/permohonan',
        );
      }
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

  TextEditingController _tarikhMulaController = TextEditingController();
  TextEditingController _tarikhAkhirController = TextEditingController();

  List<Map<String, dynamic>> statusBayaranData = [
    {'id': '1', 'keterangan': 'TELAH BAYAR'},
    {'id': '2', 'keterangan': 'BELUM BAYAR'},
    {'id': '3', 'keterangan': 'PENGECUALIAN BAYAR'},
  ];

  List<Map<String, dynamic>> statusPermohonanData = [
    {'id': '69744426891031', 'keterangan': 'MENUNGGU KELULUSAN'},
    {'id': '69744426891044', 'keterangan': 'TEMPAHAN DILULUSKAN'},
    {'id': '69744426891057', 'keterangan': 'TEMPAHAN DITOLAK'},
    {'id': '69744426891083', 'keterangan': 'TEMPAHAN DIBATALKAN'},
    {'id': '144316890293492', 'keterangan': 'TEMPAHAN DIPINDA'},
    {'id': '697444268910311', 'keterangan': 'BARU'},
    {'id': '697444268910441', 'keterangan': 'DALAM TINDAKAN'},
    {'id': '697444268910571', 'keterangan': 'SELESAI'},
    {'id': '697444268910751', 'keterangan': 'BATAL'},
  ];

  String? _selectedStatusBayaran;
  String? _selectedStatusPermohonan;

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String selectedValue = "Option 1"; // Default selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: 'Senarai Permohonan ',
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
                                  'Tapis',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Status Bayaran',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedStatusBayaran,
                                  items: statusBayaranData
                                      .map((Map<String, dynamic> item) {
                                    return DropdownMenuItem<String>(
                                      value: item['id'],
                                      child: Text(item['keterangan']),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedStatusBayaran = newValue;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Status Permohonan',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedStatusPermohonan,
                                  items: statusPermohonanData
                                      .map((Map<String, dynamic> item) {
                                    return DropdownMenuItem<String>(
                                      value: item['id'],
                                      child: Text(item['keterangan']),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedStatusPermohonan = newValue;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _tarikhMulaController,
                                  decoration: InputDecoration(
                                    labelText: 'Tarikh Mula',
                                    border: OutlineInputBorder(),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
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
                                TextField(
                                  controller: _tarikhAkhirController,
                                  decoration: InputDecoration(
                                    labelText: 'Tarikh Akhir',
                                    border: OutlineInputBorder(),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        _tarikhAkhirController.text =
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
                                      child: const Text('Tapis'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Tapis',
                      style: TextStyle(color: Colors.white),
                    ),
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
                                        return Column(children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return PermohonanKuartersDetails(
                                                      id: permohonanKuarters[
                                                          index]['id'],
                                                    ); // Target page
                                                  },
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    // Create a fade-in effect
                                                    const curve =
                                                        Curves.easeInOut;
                                                    var tween = Tween(
                                                            begin: 0.0,
                                                            end: 1.0)
                                                        .chain(CurveTween(
                                                            curve: curve));
                                                    var opacityAnimation =
                                                        animation.drive(tween);

                                                    // Apply the FadeTransition
                                                    return FadeTransition(
                                                      opacity:
                                                          opacityAnimation, // Apply the fade effect
                                                      child: child,
                                                    );
                                                  },
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds:
                                                              500), // Adjust duration as needed
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width:
                                                        0.5), // Black border with 2px width
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ), // Rounded corners

                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${permohonanKuarters[index]['noPermohonan']}',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                    const Divider(thickness: 1),
                                                    Table(
                                                      columnWidths: const {
                                                        0: FlexColumnWidth(3),
                                                        1: FlexColumnWidth(3),
                                                      },
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .badge_outlined),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                const Text(
                                                                  'No Pengenalan ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['idPemohon']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .location_on_outlined),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                const Text(
                                                                  'Lokasi Kuarters ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['keteranganLokasiKuarters']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .calendar_today_outlined),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                const Text(
                                                                  'Tarikh Permohonan ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['tarikhPermohonan']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            Wrap(
                                                              children: [
                                                                Icon(Icons
                                                                    .assignment_turned_in_outlined),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                const Text(
                                                                  'Status Agihan ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              '${permohonanKuarters[index]['statusAgihanHakiki'] ?? '-'}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .info_outlined,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                const Text(
                                                                  'Status ',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
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
                                                                  '${permohonanKuarters[index]['keteranganStatus'] ?? '-'}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
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
                                                    const Divider(thickness: 1),
                                                    if (isQtrUser)
                                                      Stack(
                                                        children: [
                                                          const SizedBox(
                                                            height: 40,
                                                            width: 450,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'SEMAK',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned.fill(
                                                            child: TextButton(
                                                              style:
                                                                  const ButtonStyle(
                                                                foregroundColor:
                                                                    WidgetStatePropertyAll(
                                                                        Colors
                                                                            .transparent),
                                                                overlayColor:
                                                                    WidgetStatePropertyAll(
                                                                        Colors
                                                                            .transparent),
                                                                backgroundColor:
                                                                    WidgetStatePropertyAll(
                                                                        Colors
                                                                            .transparent),
                                                                surfaceTintColor:
                                                                    WidgetStatePropertyAll(
                                                                        Colors
                                                                            .transparent),
                                                              ),
                                                              onPressed: () {},
                                                              child: const Text(
                                                                  ''),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ]);
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
    );
  }
}
