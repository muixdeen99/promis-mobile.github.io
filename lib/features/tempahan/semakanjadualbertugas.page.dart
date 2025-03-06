import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/kuarters/permohonanKuartersDetails.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/tempahan/tempahanDalaman.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class JadualBertugasPage extends StatefulWidget {
  const JadualBertugasPage({super.key});

  @override
  State<JadualBertugasPage> createState() => _JadualBertugasPageState();
}

class _JadualBertugasPageState extends State<JadualBertugasPage> {
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
  List<dynamic> jadualTugas = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    final apiUrl =
        'https://gerbang.lokal.my/api/pentadbiran/v1/mobile/pengguna/${userId}/peranan';
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

  int currentPage = 1;
  int pageSize = 10;
  bool isLoading = false;
  bool hasMoreData = true;

  Future<void> _fetchJadualTugas(String userId) async {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.dewanApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/jadualPegawaiPetugas?pageNo=$currentPage&pageSize=$pageSize',
      );
      print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          jadualTugas.addAll(response.data['data']);
          currentPage++;
          hasMoreData = response.data['data'].length == pageSize;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          hasMoreData = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        hasMoreData = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
        pageName1: 'Jadual Bertugas',
        pageName2: 'Senarai Jadual Bertugas',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
              child: Column(
                children: <Widget>[
                  // const SizedBox(height: 20),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(50.0),
                  //     ),
                  //     labelText: 'Enter your username',
                  //   ),
                  // ),
                  // Column(
                  //   children: [
                  //     Text("Status Permohonan"),
                  //     DropdownButton<String>(
                  //       value: selectedValue, // Current selected item
                  //       onChanged: (newValue) {
                  //         setState(() {
                  //           selectedValue = newValue!;
                  //         });
                  //       },
                  //       items: ["Option 1", "Option 2", "Option 3"]
                  //           .map((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ],
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: [
                          jadualTugas.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: jadualTugas.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == jadualTugas.length) {
                                      if (isLoading) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (!hasMoreData) {
                                        return Center(
                                            child: Text('No more data'));
                                      } else {
                                        return ElevatedButton(
                                          onPressed: () {
                                            _fetchJadualTugas(userId!);
                                          },
                                          child: Text('Load More'),
                                        );
                                      }
                                    }

                                    return GestureDetector(
                                      child: Card(
                                        surfaceTintColor: Colors.white,
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${jadualTugas[index]['namaPetugas']}',
                                                    style: TextStyle(
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
                                                  0: FlexColumnWidth(2),
                                                  1: FlexColumnWidth(3),
                                                },
                                                children: [
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'Lokasi ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        '${jadualTugas[index]['namaDewan']}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'Tarikh Mula ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        '${jadualTugas[index]['tarikhMulaStr']}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'Tarikh Tamat ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        '${jadualTugas[index]['tarikhTamatStr']}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(thickness: 2),
                                              Stack(
                                                children: [
                                                  TextButton(
                                                    child: const Text('Semak'),
                                                    onPressed: () {
                                                      showModalBottomSheet<
                                                          void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                            child: Wrap(
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                16.0), // Adjust the value as needed
                                                                        child:
                                                                            const Text(
                                                                          'MAKLUMAT JADUAL',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        'ID PEGAWAI:',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          '${jadualTugas[index]['idPegawaiPetugas']}'),
                                                                      Text(
                                                                        'NAMA PEGAWAI:',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          '${jadualTugas[index]['namaPetugas']}'),
                                                                      Text(
                                                                        'DEWAN:',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          '${jadualTugas[index]['namaDewan']}'),
                                                                      Text(
                                                                        'TARIKH MULA:',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          '${jadualTugas[index]['tarikhMulaStr']}'),
                                                                      Text(
                                                                        'TARIKH TAMAT:',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          '${jadualTugas[index]['tarikhTamatStr']}'),
                                                                      Text(
                                                                        'EMEL:',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          '${jadualTugas[index]['emel']}'),
                                                                      Text(
                                                                        'NO TELEFON:',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          '${jadualTugas[index]['noTelefon']}'),
                                                                      Row(
                                                                        children: [
                                                                          TextButton(
                                                                            child:
                                                                                const Text('Tutup'),
                                                                            onPressed: () =>
                                                                                Navigator.pop(context),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text('No data available'),
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
          
        ],
      ),
    );
  }
}
