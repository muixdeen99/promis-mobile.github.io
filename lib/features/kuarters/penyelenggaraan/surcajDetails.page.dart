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

class SurcajDetailsPage extends StatefulWidget {
  final String id;

  const SurcajDetailsPage({super.key, required this.id});

  @override
  State<SurcajDetailsPage> createState() => _SurcajDetailsPageState();
}

class _SurcajDetailsPageState extends State<SurcajDetailsPage> {
  String? userId;
  bool isSGRUser = false;
  List<dynamic> SurcajData = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadisSGRUser();
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
          SurcajData = response.data['data'];
        });
        // print('Data: $SurcajData');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _loadisSGRUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isSGRUser = prefs.getBool('isSGRUser') ?? false;
      });
      print('isSGRUser: $isSGRUser');
    } catch (e) {
      print('Error loading isSGRUser: $e');
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
      // home: const MySurcajDetailsPage(title: ''),
    );
  }
}

class MySurcajDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const MySurcajDetailsPage({super.key, required this.id});

  // final String title;

  @override
  ConsumerState<MySurcajDetailsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MySurcajDetailsPage> {
  String _range = '';
  String? userId;
  bool isSGRUser = false;
  bool SGRUser = false;

  Map<String, dynamic> SurcajData = {};
  TextEditingController _tarikhMulaController = TextEditingController();
  TextEditingController _tarikhHinggaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadisSGRUser();
    _fetchUserData(widget.id);
  }

  Future<void> _loadisSGRUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isSGRUser = prefs.getBool('isSGRUser') ?? false;
      });
      print('isSGRUser: $isSGRUser');
    } catch (e) {
      print('Error loading isSGRUser: $e');
    }
  }

  bool isLoading = true;

  Future<void> _fetchUserData(String id) async {
    setState(() {
      isLoading = true;
    });
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.senggaraApiUrl,
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        SGRUser = prefs.getBool('isSGRUser') ?? false;
        userId = prefs.getString('user_id');
      });
      print('SGRUser: $SGRUser');
    } catch (e) {
      print('Error loading isSGRUser: $e');
    }

    try {
      String url = 'lawatan-tapak-surcaj/$id?authId=$userId';
      // print('url: $url');

      var response = await apiService.makeRequest(
        RequestMethod.get,
        url,
      );

      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          SurcajData = response.data;
        });
        // print(SurcajData);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          SurcajData.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      SurcajData[
                                                              'rujukanJadual'] ??
                                                          'Unknown Dewan',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Jenis Kadar: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Buku JKK: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Bahagian: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Sub Bahagian: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Kategori: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Sub Kategori: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Unit: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Harga (RM): Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Ruang: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Kuantiti: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Tambahan Peratus Lokasi: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Halangan: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Catatan: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Pilihan JKK: Test',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    
                                                    SizedBox(height: 10),
                                                    
                                        
                                                  ],
                                                )
                                              : const Center(
                                                  child:
                                                      Text('No data available'),
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
