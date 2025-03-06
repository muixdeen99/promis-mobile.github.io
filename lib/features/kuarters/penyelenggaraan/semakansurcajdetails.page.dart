import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/kuarters/permohonanKuartersDetails.dart';
import 'package:promis/features/kuarters/penyelenggaraan/tambahsurcaj.page.dart';
import 'package:promis/features/kuarters/penyelenggaraan/surcajDetails.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang_details_page.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

// import 'package:file_picker/file_picker.dart'; // Import file_picker package

class SemakanSurcajDetailsPage extends StatefulWidget {
  final String id;

  const SemakanSurcajDetailsPage({super.key, required this.id});

  @override
  State<SemakanSurcajDetailsPage> createState() =>
      _SemakanSurcajDetailsPageState();
}

class _SemakanSurcajDetailsPageState extends State<SemakanSurcajDetailsPage> {
  String? userId;
  bool isSgrUser = false;
  bool sgrUser = false;
  List<dynamic> senggara = [];
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    // _loadUserId();
    _fetchAgihan();
    _loadIsSgrUser();
    _fetchSurcaj(widget.id);
  }

  List<Map<String, dynamic>> _agihan = [];
  String? _selectedAgihan;

  Future<void> _fetchAgihan() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userId = prefs.getString('user_id');
      });
    } catch (e) {
      print('Error loading SgrUser: $e');
    }

    final String apiUrl =
        'https://gerbang.lokal.my/api/pentadbiran/v1/peranan/ids/pengguna/feign?listIdPeranan=cc9aea4b3ae24c87ab8dc396b04b9587&authId=$userId';
    try {
      final response = await Dio().get(apiUrl);
      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          _agihan = List<Map<String, dynamic>>.from(response.data['data']);
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadIsSgrUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isSgrUser = prefs.getBool('isSgrUser') ?? false;
      });
      print('isSgrUser: $isSgrUser');
    } catch (e) {
      print('Error loading isSgrUser: $e');
    }
  }

  // Future<void> _loadUserId() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final userId = prefs.getString('user_id');
  //     print('User ID: $userId');
  //     setState(() {
  //       this.userId = userId;
  //     });

  //     if (userId != null) {
  //       await _fetchSurcaj(userId, widget.id);
  //     }
  //   } catch (e) {
  //     print('Error loading user ID: $e');
  //   }
  // }
  TextEditingController _jumlahSurcajController =
      TextEditingController(text: "0.00");
  TextEditingController _jumlahTiadaSurcajController =
      TextEditingController(text: "0.00");

  bool isLoading = true;

  Future<void> _fetchSurcaj(String id) async {
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
        sgrUser = prefs.getBool('isSgrUser') ?? false;
        userId = prefs.getString('user_id');
      });
      print('SgrUser: $sgrUser');
    } catch (e) {
      print('Error loading SgrUser: $e');
    }

    // const currentUser = "000119130962";
    print('User ID: $userId');
    print('ID: $id');
    Response response;
    try {
      response = await apiService.makeRequest(
        RequestMethod.get,
        'lawatan-tapak/$id/lawatan-tapak-surcaj?idStatus=762326425830&pageNo=1&pageSize=10&authId=$userId',
      );

      // if (sgrUser) {
      //   response = await apiService.makeRequest(
      //     RequestMethod.get,
      //     'lawatan-tapak?flagAktif=true&pageNo=1&pageSize=10&authId=$userId',
      //   );
      // }
      // print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          senggara = response.data['data'];
          if (senggara.isNotEmpty) {
            _jumlahSurcajController.text = senggara[0]['jumlahKerosakan']
                .toString(); // Assign the value to the variable
          }
        });
        print('Data: $_jumlahSurcajController');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _lokasiKuarters = [];
  String? _selectedLokasiKuarters;

  Future<void> _fetchLokasiKuarters() async {
    final String apiUrl =
        'https://gerbang.lokal.my/api/kod/v1/lokasi-kuarters?authId=970520385221';
    try {
      final response = await Dio().get(apiUrl);
      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          _lokasiKuarters =
              List<Map<String, dynamic>>.from(response.data['data']);
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  TextEditingController _tarikhMulaController = TextEditingController();
  TextEditingController _tarikhAkhirController = TextEditingController();

  List<Map<String, dynamic>> jenisSenggara = [
    {'id': 'K', 'keterangan': 'KUARTERS'},
    {'id': 'RS', 'keterangan': 'RUANG SERBAGUNA'},
  ];

  List<Map<String, dynamic>> bidangSenggara = [
    {'id': 'AWAM', 'keterangan': 'AWAM'},
    {'id': 'ELEKTRIK', 'keterangan': 'ELEKTRIK'},
  ];

  String? _selectedJenisSenggara;
  String? _selectedBidangSenggara;

  String? _selectedOption;
  final List<String> _options = ['PEMULANGAN TUGAS', 'SEMAKAN KUARTERS'];
  TextEditingController _ulasanController = TextEditingController();

  List<Map<String, dynamic>> jenisPembaikan = [
    {'id': '1', 'keterangan': 'TIADA PEMBAIKAN / SEDIA DIDUDUKI'},
    {'id': '2', 'keterangan': 'PEMBAIKAN MELALUI INDEN KERJA'},
    {'id': '3', 'keterangan': 'PEMBAIKAN OLEH AGENSI PELAKSANA/PEMAJU'}
  ];

  List<Map<String, dynamic>> pelaksana = [
    {'id': '1', 'keterangan': 'JKR'},
    {'id': '2', 'keterangan': 'PJH'},
    {'id': '3', 'keterangan': 'PPJ'},
    {'id': '4', 'keterangan': 'BAHAGIAN PEMBANGUNAN JPM'},
    {'id': '5', 'keterangan': 'LAIN-LAIN'}
  ];
  String? _selectedJenisPembaikan;
  String? _selectedpelaksana;
  String? _selectedSurcajOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: 'Maklumat ',
        pageName2: 'Senarai Permohonan',
      ),
      drawer: const CustomDrawer(),
      body: Container(
        color: Color.fromARGB(255, 235, 241, 253),
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pilih Tindakan',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: _selectedOption,
                    items: _options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                  ),
                const SizedBox(height: 16),
                if (_selectedOption == 'PEMULANGAN TUGAS') ...[
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'CATATAN',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 17, 54, 107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text('HANTAR'),
                      ),
                    ],
                  ),
                ] else if (_selectedOption == 'SEMAKAN KUARTERS') ...[
                  TextFormField(
                    controller: _tarikhMulaController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tarikh',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _tarikhMulaController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'Jenis Pembaikan',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: _selectedJenisPembaikan,
                    items: jenisPembaikan.map((Map<String, dynamic> item) {
                      return DropdownMenuItem<String>(
                        value: item['id'],
                        child: Text(item['keterangan']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedJenisPembaikan = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ulasanController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Ulasan Lawatan',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_selectedJenisPembaikan == '3') ...[
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Agensi Pelaksana/Pemaju',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: _selectedpelaksana,
                      items: pelaksana.map((Map<String, dynamic> item) {
                        return DropdownMenuItem<String>(
                          value: item['id'],
                          child: Text(item['keterangan']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedpelaksana = newValue;
                        });
                      },
                    ),
                  ],
                  const SizedBox(height: 16),
                  if (_selectedJenisPembaikan == '2' ||
                      _selectedJenisPembaikan == '3') ...[
                    Text(
                      'Ada Surcaj?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: _selectedSurcajOption == 'ADA'
                                  ? Colors.blue
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedSurcajOption = 'ADA';
                              });
                            },
                            child: Text('ADA'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: _selectedSurcajOption == 'TIADA'
                                  ? Colors.blue
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedSurcajOption = 'TIADA';
                              });
                            },
                            child: Text('TIADA'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (_selectedSurcajOption == 'ADA') ...[
                    TextFormField(
                      controller: _jumlahSurcajController,
                      decoration: InputDecoration(
                        labelText: 'Jumlah Surcaj (RM)',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      enabled: false,
                    ),
                  ],
                  if (_selectedSurcajOption != 'ADA') ...[
                    TextFormField(
                      controller: _jumlahTiadaSurcajController,
                      decoration: InputDecoration(
                        labelText: 'Jumlah Surcaj',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      enabled: false,
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          _selectedFile = File(result.files.single.path!);
                        });
                      }
                    },
                    child: const Text(
                      'Muat Naik Fail',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Text('(Saiz Fail Hendaklah Tidak Melebihi 5MB)'),
                  if (_selectedFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Selected File: ${_selectedFile!.path}'),
                    ),
                  const SizedBox(height: 16),
                  if (_selectedJenisPembaikan == '3') ...[
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Agih Kepada',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: _selectedAgihan,
                      items: _agihan.map((Map<String, dynamic> item) {
                        return DropdownMenuItem<String>(
                          value: item['id'],
                          child: Text(item['nama']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAgihan = newValue;
                        });
                      },
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 1,
                  ),
                  if (_selectedSurcajOption == 'ADA') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(255, 17, 54, 107),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return const TambahSurcajpage(); // Target page
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    // Create a fade-in effect
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: 0.0, end: 1.0)
                                        .chain(CurveTween(curve: curve));
                                    var opacityAnimation =
                                        animation.drive(tween);

                                    // Apply the FadeTransition
                                    return FadeTransition(
                                      opacity:
                                          opacityAnimation, // Apply the fade effect
                                      child: child,
                                    );
                                  },
                                  transitionDuration: const Duration(
                                      milliseconds:
                                          500), // Adjust duration as needed
                                ),
                              );
                            },
                            child: Text('TAMBAH SURCAJ'),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Laporan Kerosakan/Surcaj',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            senggara.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: senggara.length,
                                    itemBuilder: (context, index) {
                                      return Column(children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return SemakanSurcajDetailsPage(
                                                    id: senggara[index]
                                                        ['idSurcaj'],
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
                                                          begin: 0.0, end: 1.0)
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
                                                transitionDuration: const Duration(
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
                                                  color: Colors.black,
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
                                                        '${senggara[index]['rujukanJadual']}',
                                                        style: const TextStyle(
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
                                                              const Text(
                                                                'Seksyen/Ruang',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '${senggara[index]['keteranganSeksyenRuang']}',
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
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                'Unit ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '${senggara[index]['unit']}',
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
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                'Kuantiti ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '${senggara[index]['kuantiti']}',
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
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              const Text(
                                                                'Harga',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '${senggara[index]['harga']}',
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
                                                          Wrap(
                                                            children: [
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              const Text(
                                                                'Peratusan Lokasi ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '${senggara[index]['peratusanLokasi'] ?? '-'}',
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
                                                          Wrap(
                                                            children: [
                                                              const Text(
                                                                'Peratusan Halangan ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '${senggara[index]['peratusanHalangan']}',
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
                                                          Wrap(
                                                            children: [
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              const Text(
                                                                'Jumlah ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '${senggara[index]['jumlah'] ?? '-'}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  const Divider(thickness: 1),
                                                  Column(
                                                    children: [
                                                      // const SizedBox(
                                                      //   height: 10,
                                                      //   width: 450,
                                                      //   child: Align(
                                                      //     alignment:
                                                      //         Alignment.center,
                                                      //     child: Text(
                                                      //       'PAPAR',
                                                      //       style: TextStyle(
                                                      //         fontWeight:
                                                      //             FontWeight
                                                      //                 .bold,
                                                      //         color:
                                                      //             Colors.blue,
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
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
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MySurcajDetailsPage(
                                                                  id: senggara[
                                                                          index]
                                                                      ['id'],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: const Text(
                                                              'PAPAR',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blueAccent,
                                                              )),
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
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 17, 54, 107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text('HANTAR'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
