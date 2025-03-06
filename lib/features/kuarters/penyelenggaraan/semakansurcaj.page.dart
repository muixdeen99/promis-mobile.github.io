import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/kuarters/permohonanKuartersDetails.dart';
import 'package:promis/features/kuarters/penyelenggaraan/semakansurcajdetails.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class SemakanSurcajPage extends StatefulWidget {
  const SemakanSurcajPage({super.key});

  @override
  State<SemakanSurcajPage> createState() => _SemakanSurcajPageState();
}

class _SemakanSurcajPageState extends State<SemakanSurcajPage> {
  String? userId;
  bool isSgrUser = false;
  bool sgrUser = false;
  TextEditingController _idKuartersController = TextEditingController();
  bool isLoading = true;

  List<dynamic> senggara = [];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadIsSgrUser();
    _fetchLokasiKuarters();
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

  Future<void> _loadUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      print('User ID: $userId');
      setState(() {
        this.userId = userId;
      });

      if (userId != null) {
        await _fetchSurcaj(userId);
      }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  Future<void> _fetchSurcaj(
    String userId, {
    String? jenisSenggara,
    String? bidang,
    String? lokasiKuarters,
    String? idKuarters,
  }) async {
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
      });
      print('SgrUser: $sgrUser');
    } catch (e) {
      print('Error loading SgrUser: $e');
    }

    // const currentUser = "000119130962";
    Response response;

    try {
      String url =
          'pegawai-tugasan/$userId/agihan-tugas?idStatus=762326425830&pageNo=1&pageSize=10&authId=$userId';

      if (jenisSenggara != null ||
          bidang != null ||
          lokasiKuarters != null ||
          idKuarters != null) {
        if (jenisSenggara != null) {
          url += '&jenisSenggara=$jenisSenggara';
        }
        if (bidang != null) {
          url += '&bidang=$bidang';
        }

        if (idKuarters != null) {
          url += '&idKuarters=$idKuarters';
        }

        if (lokasiKuarters != null) {
          url += '&lokasiKuarters=$lokasiKuarters';
        }
        url = url.substring(0, url.length - 1); // Remove the trailing '&'
      }
      print('url: $url');

      var response = await apiService.makeRequest(
        RequestMethod.get,
        url,
      );

      // response = await apiService.makeRequest(
      //   RequestMethod.get,
      //   'pegawai-tugasan/$userId/agihan-tugas?idStatus=762326425830&pageNo=1&pageSize=10&authId=$userId',
      // );

      // if (sgrUser) {
      //   response = await apiService.makeRequest(
      //     RequestMethod.get,
      //     'pegawai-tugasan/$userId/agihan-tugas?idStatus=762326425830&pageNo=1&pageSize=10&authId=$userId',
      //   );
      // }
      // print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          senggara = response.data['data'];
        });
        // print('Data: $senggara');
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
        pageName1: 'Senarai Surcaj',
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
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    'Carian',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _idKuartersController,
                                    decoration: InputDecoration(
                                      labelText: 'ID Kuarters',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Jenis Senggara',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedJenisSenggara,
                                    items: jenisSenggara
                                        .map((Map<String, dynamic> item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'],
                                        child: Text(item['keterangan']),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedJenisSenggara = newValue;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Bidang',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedBidangSenggara,
                                    items: bidangSenggara
                                        .map((Map<String, dynamic> item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'],
                                        child: Text(item['keterangan']),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedBidangSenggara = newValue;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      labelText: 'Lokasi Kuarters',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedLokasiKuarters,
                                    items: _lokasiKuarters
                                        .map((Map<String, dynamic> item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'],
                                        child: Text(item['keterangan']),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedLokasiKuarters = newValue;
                                      });
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
                                          backgroundColor: WidgetStatePropertyAll<
                                                  Color>(
                                              Color.fromARGB(255, 17, 54, 107)),
                                        ),
                                        onPressed: () {
                                          _fetchSurcaj(userId!,
                                              jenisSenggara:
                                                  _selectedJenisSenggara,
                                              bidang: _selectedBidangSenggara,
                                              lokasiKuarters:
                                                  _selectedLokasiKuarters,
                                              idKuarters:
                                                  _idKuartersController.text);
                            
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Carian',
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
                      'Carian',
                      style: TextStyle(color: Colors.white),
                    ),
                    // style: ElevatedButton.styleFrom(
                    //   primary: Colors.blue, // Background color
                    // ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else
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
                                                    transitionsBuilder:
                                                        (context,
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
                                                          animation
                                                              .drive(tween);

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
                                                      color: Colors.black,
                                                      width:
                                                          0.5), // Black border with 2px width
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ), // Rounded corners

                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${senggara[index]['noRujukan']}',
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
                                                          0: FlexColumnWidth(3),
                                                          1: FlexColumnWidth(3),
                                                        },
                                                        children: [
                                                          TableRow(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(Icons
                                                                      .door_front_door),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'No Unit ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['noUnitKuarters']}',
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
                                                                  Icon(Icons
                                                                      .location_city_sharp),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'Blok ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['blokKuarters']}',
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
                                                                  Icon(Icons
                                                                      .map),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'Alamat ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['alamatKuarters']}',
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
                                                                  Icon(Icons
                                                                      .pin_drop_outlined),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        const Text(
                                                                      'Lokasi Permohonan',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['lokasiKuarters']}',
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
                                                                  Icon(Icons
                                                                      .assignment_turned_in_outlined),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'Kelas ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['kelasKuarters'] ?? '-'}',
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
                                                                  Icon(Icons
                                                                      .note),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'Jenis Kuarters ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['jenisKuarters'] ?? '-'}',
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
                                                                  Icon(Icons
                                                                      .note),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'Bidang ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['bidang'] ?? '-'}',
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
                                                                  Icon(Icons
                                                                      .calendar_month_rounded),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'Tarikh Laporan ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['tarikhLaporan'] ?? '-'}',
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
                                                                  Icon(Icons
                                                                      .calendar_month_rounded),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Text(
                                                                    'Tarikh Semak Kuarters ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${senggara[index]['tarikhSemakKuarters'] ?? '-'}',
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
                                                      const SizedBox(
                                                          height: 20),
                                                      const Divider(
                                                          thickness: 1),
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
                                                                        SemakanSurcajDetailsPage(
                                                                  id: senggara[
                                                                          index]
                                                                      ['idSurcaj'],
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
