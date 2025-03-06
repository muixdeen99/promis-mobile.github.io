import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/kuarters/permohonanKuartersDetails.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class SemakanJadualBertugasPage extends StatefulWidget {
  const SemakanJadualBertugasPage({super.key});

  @override
  State<SemakanJadualBertugasPage> createState() =>
      _SemakanJadualBertugasPageState();
}

class _SemakanJadualBertugasPageState extends State<SemakanJadualBertugasPage> {
  TextEditingController _tarikhMulaController = TextEditingController();

  String? userId;
  bool isQtrUser = false;
  List<dynamic> jadualTugas = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    final apiUrl =
        'https://gerbang.lokal.my/api/pentadbiran/v1/mobile/pengguna/$userId/peranan';
    try {
      final response = await Dio().get(apiUrl);
      if (response.statusCode == 200) {
        final data = response.data;
        for (var role in data) {
          print('keterangan: ${role['keterangan']}');
          if (role['keterangan'].contains('(QTR)')) {
            setState(() {
              isQtrUser = true;
              print('isQtrUser: $isQtrUser');
            });
            break;
          }
        }
      } else {
        print('Failed to load user role: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user role: $e');
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
        await _fetchJadualTugas(userId);
      }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  bool isLoading = true; 

  Future<void> _fetchJadualTugas(String userId) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.penguatkuasaanApiUrl,
    );

    const currentUser = "000119130962";

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/jadual-tugasan-janjitemu',
      );
      print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          jadualTugas = response.data['data'];
        });
        print('Data: $jadualTugas');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }

    setState(() {
      isLoading = false; // Hide loading indicator
    });
  }

  TextEditingController _tarikhTugasController = TextEditingController();

  List<Map<String, dynamic>> kawasanData = [
    {'id': '1', 'keterangan': 'TELAH BAYAR'},
    {'id': '2', 'keterangan': 'BELUM BAYAR'},
    {'id': '3', 'keterangan': 'PENGECUALIAN BAYAR'},
  ];

  List<Map<String, dynamic>> jenisJadualData = [
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

  // Initial Selected Value
  String? _selectedJenisJadual;
  String? _selectedKawasan; // Default selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: 'Senarai Jadual Bertugas',
        pageName2: 'Senarai Jadual Bertugas',
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
                          return SingleChildScrollView(
                            child: Padding(
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
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Status Bayaran',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedKawasan,
                                    items: kawasanData
                                        .map((Map<String, dynamic> item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'],
                                        child: Text(item['keterangan']),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedKawasan = newValue;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Jenis Jadual',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedJenisJadual,
                                    items: jenisJadualData
                                        .map((Map<String, dynamic> item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'],
                                        child: Text(item['keterangan']),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedJenisJadual = newValue;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _tarikhTugasController,
                                    decoration: InputDecoration(
                                      labelText: 'Tarikh',
                                      border: OutlineInputBorder(),
                                    ),
                                    // readOnly: true,
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
                                          _tarikhTugasController.text =
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
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll<Color>(
                                                  Color.fromARGB(
                                                      255, 17, 54, 107)),
                                        ),
                                        onPressed: () {
                                          // Handle filter action
                                        },
                                        child: const Text(
                                          'Tapis',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
              child: isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator
                  : jadualTugas.isNotEmpty
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        jadualTugas.isNotEmpty
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: jadualTugas.length,
                                                itemBuilder: (context, index) {
                                                  return Column(children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          PageRouteBuilder(
                                                            pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) {
                                                              return PermohonanKuartersDetails(
                                                                id: jadualTugas[
                                                                        index]
                                                                    ['id'],
                                                              ); // Target page
                                                            },
                                                            transitionsBuilder:
                                                                (context,
                                                                    animation,
                                                                    secondaryAnimation,
                                                                    child) {
                                                              // Create a fade-in effect
                                                              const curve =
                                                                  Curves
                                                                      .easeInOut;
                                                              var tween = Tween(
                                                                      begin:
                                                                          0.0,
                                                                      end: 1.0)
                                                                  .chain(CurveTween(
                                                                      curve:
                                                                          curve));
                                                              var opacityAnimation =
                                                                  animation
                                                                      .drive(
                                                                          tween);

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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width:
                                                                  0.5), // Black border with 2px width
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ), // Rounded corners

                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${jadualTugas[index]['tarikhJanjitemu']}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                ],
                                                              ),
                                                              const Divider(
                                                                  thickness: 1),
                                                              Table(
                                                                columnWidths: const {
                                                                  0: FlexColumnWidth(
                                                                      3),
                                                                  1: FlexColumnWidth(
                                                                      3),
                                                                },
                                                                children: [
                                                                  TableRow(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons
                                                                              .home),
                                                                          SizedBox(
                                                                            width:
                                                                                2,
                                                                          ),
                                                                          const Text(
                                                                            'Kawasan ',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        '${jadualTugas[index]['keteranganLokasiKuarters']}',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  TableRow(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons
                                                                              .people),
                                                                          SizedBox(
                                                                            width:
                                                                                2,
                                                                          ),
                                                                          const Text(
                                                                            'Jenis Jadual',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        '${jadualTugas[index]['jenisJadual']}',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w400),
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
                                                                            width:
                                                                                2,
                                                                          ),
                                                                          const Text(
                                                                            'Tarikh Bayaran ',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        '${jadualTugas[index]['tarikhPermohonan']}',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
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
                                                child: Text(
                                                    'Tiada Permohonan Dibuat'),
                                              )
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(child: Text('Tiada Permohonan Dibuat')),
            ),
          ],
        ),
      ),
    );
  }
}
