// // import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahandewan/daftardewan_confirmation_page.dart';
import 'package:promis/features/tempahan/tempahandewan/daftardewan_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/features/tempahan/tempahangelanggang/daftargelanggang_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang_notifier.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang_state.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:promis/shared/api.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../components/custom_appbar.dart';

class TempahanDewanDetailsPage extends StatefulWidget {
  final String id;

  const TempahanDewanDetailsPage({super.key, required this.id});

  @override
  State<TempahanDewanDetailsPage> createState() =>
      _TempahanDewanDetailsPageState();
}

class _TempahanDewanDetailsPageState extends State<TempahanDewanDetailsPage> {
  String? userId;
  bool isUTLUser = false;
  List<dynamic> tempahanDewanData = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadIsUTLUser();
    _fetchUserData(widget.id);
  }

  Future<void> _fetchUserData(String id) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.dewanApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        '/mobile/permohonan/$id',
      );
      // print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          tempahanDewanData = response.data['data'];
        });
        // print('Data: $tempahanDewanData');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _loadIsUTLUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isUTLUser = prefs.getBool('isUTLUser') ?? false;
      });
      print('isUTLUser: $isUTLUser');
    } catch (e) {
      print('Error loading isUTLUser: $e');
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
        await _fetchUserData(userId);
      }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProMIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyTempahanDewanDetailsPage(title: ''),
    );
  }
}

class MyTempahanDewanDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const MyTempahanDewanDetailsPage({super.key, required this.id});

  // final String title;

  @override
  ConsumerState<MyTempahanDewanDetailsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyTempahanDewanDetailsPage> {
  String _range = '';
  String? userId;
  bool isUTLUser = false;
  bool UTLUser = false;

  Map<String, dynamic> tempahanDewanData = {};
  TextEditingController _tarikhMulaController = TextEditingController();
  TextEditingController _tarikhHinggaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadIsUTLUser();
    _fetchUserData(widget.id);
  }

  Future<void> _loadIsUTLUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isUTLUser = prefs.getBool('isUTLUser') ?? false;
      });
      print('isUTLUser: $isUTLUser');
    } catch (e) {
      print('Error loading isUTLUser: $e');
    }
  }

  bool isLoading = true;

  Future<void> _fetchUserData(String id) async {
    setState(() {
      isLoading = true;
    });
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.dewanApiUrl,
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        UTLUser = prefs.getBool('isUTLUser') ?? false;
      });
      print('UTLUser: $UTLUser');
    } catch (e) {
      print('Error loading isUTLUser: $e');
    }

    try {
      String url = 'mobile/permohonan/$id';
      print('url: $url');

      // if (UTLUser) {
      //   url = 'mobile/permohonan/dewan';
      // }

      // if (statusBayaran != null ||
      //     statusPermohonan != null ||
      //     tarikhMula != null ||
      //     tarikhTamat != null) {
      //   url += '?';
      //   if (statusBayaran != null) {
      //     url += 'statusBayaran=$statusBayaran&';
      //   }
      //   if (statusPermohonan != null) {
      //     url += 'idStatus=$statusPermohonan&';
      //   }
      //   if (tarikhMula != null) {
      //     url += 'tarikhMula=$tarikhMula&';
      //   }
      //   if (tarikhTamat != null) {
      //     url += 'tarikhTamat=$tarikhTamat&';
      //   }
      //   url = url.substring(0, url.length - 1); // Remove the trailing '&'
      //   print('url: $url');
      // }

      var response = await apiService.makeRequest(
        RequestMethod.get,
        url,
      );

      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          tempahanDewanData = response.data;
        });
        // print(tempahanDewanData);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      print('User ID: $userId');
      setState(() {
        this.userId = userId;
      });

      // if (userId != null) {
      //   await _fetchUserData(userId);
      // }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tempahanGelanggangNotifierProvider);
    if (state is TempahanGelanggangStateLoaded) {
      return Scaffold(
        appBar: CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Maklumat Tempahan',
          pageName2: '    Tempahan Dewan',
          showButton: true,
          buttonAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DaftarDewanPage(),
              ),
            );
          },
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            Container(
              color: Color.fromARGB(255, 235, 241, 253),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if (isLoading)
                                    Center(child: CircularProgressIndicator())
                                  else
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          tempahanDewanData.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      tempahanDewanData[
                                                              'namaDewan'] ??
                                                          'Unknown Dewan',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .calendar_month_outlined,
                                                            color: Color.fromARGB(
                                                                255, 17, 54, 107)),
                                                        SizedBox(
                                                            width:
                                                                4), // Add spacing between icon and text
                                                        Text(
                                                          tempahanDewanData[
                                                                  'tarikhPermohonanStr'] ??
                                                              'Unknown',
                                                          style:
                                                              TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.alarm,
                                                            color: Color.fromARGB(
                                                                255, 17, 54, 107)),
                                                        SizedBox(
                                                            width:
                                                                4), // Add spacing between icon and text
                                                        Text(
                                                          "${tempahanDewanData['masaMula']} - ${tempahanDewanData['masaTamat']}",
                                                          style:
                                                              TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tujuan: ${tempahanDewanData['catatanPermohonan']}" ??
                                                              'Unknown',
                                                          style:
                                                              TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Bilangan Hari: ${tempahanDewanData['bilHari'].toString()}",
                                                          style:
                                                              TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Kadar Sewa (RM): ${tempahanDewanData['kadarSewa'].toString()}",
                                                          style:
                                                              TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Jumlah Bayaran (RM): ${tempahanDewanData['jumlahBayaran'].toString()}",
                                                          style:
                                                              TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tarikh Akhir Bayaran: ${tempahanDewanData['tarikhAkhirBayaran'].toString()}",
                                                          style:
                                                              TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    const Divider(
                                                      thickness: 1,
                                                      indent: 10,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      margin: EdgeInsets.all(15.0),
                                                      child: Card(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(16.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Maklumat Pemohon',
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text('No Pengenalan: ${tempahanDewanData['noPengenalan'] ?? 'Unknown'}'),
                                                              Text('Nama: ${tempahanDewanData['nama'] ?? 'Unknown'}'),
                                                              Text('No Telefon: ${tempahanDewanData['noTelefon'] ?? 'Unknown'}'),
                                                              Text('Emel: ${tempahanDewanData['emel'] ?? 'Unknown'}'),
                                                              Text('Alamat: ${tempahanDewanData['alamat'] ?? 'Unknown'}'),
                                                              Text('Poskod: ${tempahanDewanData['poskod'] ?? 'Unknown'}'),
                                                              Text('Negeri: ${tempahanDewanData['negeri'] ?? 'Unknown'}'),
                                                              Text('Bandar: ${tempahanDewanData['bandar'] ?? 'Unknown'}'),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    const Divider(
                                                      thickness: 1,
                                                      indent: 10,
                                                    ),
                                                  ],
                                                )
                                              : const Center(
                                                  child: Text('No data available'),
                                                ),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle "Lulus Tempahan" action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Lulus Tempahan', style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle "Tolak Tempahan" action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text('Tolak Tempahan', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (state is TempahanGelanggangStateLoading) {
      return const Center(child: Text('Loading'));
    } else {
      return const Center(child: Text('Failed'));
    }
  }
}
