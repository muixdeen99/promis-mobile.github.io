import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/daftargelanggang_page.dart';
import 'package:promis/features/tempahan/tempahandewan/daftardewan_confirmation_page.dart';
import 'package:promis/features/tempahan/tempahandewan/daftardewan_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang_details_page.dart';
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

class TempahanGelanggangPage extends ConsumerStatefulWidget {
  const TempahanGelanggangPage({super.key});

  @override
  ConsumerState<TempahanGelanggangPage> createState() => _TempahanGelanggangPageState();
}

class _TempahanGelanggangPageState extends ConsumerState<TempahanGelanggangPage> {
  
  String _range = '';
  String? userId;
  List<dynamic> TempahanGelanggangData = [];
  bool isLoading = true;

  bool UTLUser = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _fetchUserData(String userId) async {
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
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/permohonan/pemohon/$userId/gelanggang',
      );

      if (UTLUser) {
        response = await apiService.makeRequest(
          RequestMethod.get,
          'mobile/permohonan/gelanggang',
        );
      }
      print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          TempahanGelanggangData = response.data['data'];
        });
        print('Data: $TempahanGelanggangData');
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

  TextEditingController _tarikhMulaController = TextEditingController();
  TextEditingController _tarikhHinggaController = TextEditingController();

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
          pageName1: 'Tempahan Gelanggang',
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
        body: Container(
          color: Color.fromARGB(255, 235, 241, 253),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.orange),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return DaftarGelanggangPage(); // Target page
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Create a fade-in effect
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: 0.0, end: 1.0)
                                  .chain(CurveTween(curve: curve));
                              var opacityAnimation = animation.drive(tween);

                              // Apply the FadeTransition
                              return FadeTransition(
                                opacity:
                                    opacityAnimation, // Apply the fade effect
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                                milliseconds: 500), // Adjust duration as needed
                          ),
                        );
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text('Daftar',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.blue, // Background color
                      // ),
                    ),
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
                                  TextField(
                                    controller: _tarikhMulaController,
                                    decoration: InputDecoration(
                                      labelText: 'Tarikh Dari',
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
                                  TextField(
                                    controller: _tarikhHinggaController,
                                    decoration: InputDecoration(
                                      labelText: 'Tarikh Hingga',
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
                                          _tarikhHinggaController.text =
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
                                              WidgetStateProperty.all<Color>(
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
                  child: Center(
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
                              if (isLoading)
                                Center(child: CircularProgressIndicator())
                              else
                                Column(
                                  children: [
                                    TempahanGelanggangData.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                TempahanGelanggangData.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                surfaceTintColor: Colors.white,
                                                elevation: 5,
                                                shadowColor: Colors.black,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${TempahanGelanggangData[index]['namaDewan']}',
                                                            style: TextStyle(
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
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'ID Pemohon ',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      'Tarikh Permohonan ',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      'Catatan',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      'Status Bayaran',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      'Status',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      16), // Adds some spacing between the columns
                                                              Flexible(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${TempahanGelanggangData[index]['idPemohon']}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      '${TempahanGelanggangData[index]['tarikhTempahan']}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      '${TempahanGelanggangData[index]['catatanPermohonan']}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      '${TempahanGelanggangData[index]['statusBayaran']}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      '${TempahanGelanggangData[index]['keteranganStatus']}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                        ],
                                                      ),
                                                      const Divider(
                                                          thickness: 2),
                                                      Column(
                                                        children: [
                                                          TextButton(
                                                            child: const Text(
                                                                'Semak Tempahan'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                PageRouteBuilder(
                                                                  pageBuilder: (context,
                                                                      animation,
                                                                      secondaryAnimation) {
                                                                    return MytempahanGelanggangDetailsPage(
                                                                      id: TempahanGelanggangData[
                                                                              index]
                                                                          [
                                                                          'id'],
                                                                    ); // Target page
                                                                  },
                                                                  transitionsBuilder: (context,
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
                                                                            end:
                                                                                1.0)
                                                                        .chain(CurveTween(
                                                                            curve:
                                                                                curve));
                                                                    var opacityAnimation =
                                                                        animation
                                                                            .drive(tween);

                                                                    // Apply the FadeTransition
                                                                    return FadeTransition(
                                                                      opacity:
                                                                          opacityAnimation, // Apply the fade effect
                                                                      child:
                                                                          child,
                                                                    );
                                                                  },
                                                                  transitionDuration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500), // Adjust duration as needed
                                                                ),
                                                              );
                                                            },
                                                            // onPressed: () {
                                                            //   showModalBottomSheet<
                                                            //       void>(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (BuildContext
                                                            //             context) {
                                                            //       return Center(
                                                            //         child: Wrap(
                                                            //           children: <Widget>[
                                                            //             Padding(
                                                            //               padding: const EdgeInsets
                                                            //                   .all(
                                                            //                   16.0),
                                                            //               child:
                                                            //                   Column(
                                                            //                 mainAxisAlignment:
                                                            //                     MainAxisAlignment.center,
                                                            //                 mainAxisSize:
                                                            //                     MainAxisSize.min,
                                                            //                 children: <Widget>[
                                                            //                   Padding(
                                                            //                     padding: const EdgeInsets.only(bottom: 16.0), // Adjust the value as needed
                                                            //                     child: const Text(
                                                            //                       'MAKLUMAT PERMOHONAN',
                                                            //                       style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                     ),
                                                            //                   ),
                                                            //                   Text(
                                                            //                     'ID PEMOHON:',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['idPemohon']}'),
                                                            //                   Text(
                                                            //                     'NAMA PEMOHON:',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['namaPemohon']}'),
                                                            //                   Text(
                                                            //                     'DEWAN:',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['namaDewan']}'),
                                                            //                   Text(
                                                            //                     'TUJUAN:',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['catatanPermohonan']}'),
                                                            //                   Text(
                                                            //                     'TARIKH MULA:',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['tarikhMulaStr']}'),
                                                            //                   Text(
                                                            //                     'TARIKH TAMAT:',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['tarikhTamatStr']}'),
                                                            //                   Text(
                                                            //                     'BILANGAN HARI:',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['bilHari']}'),
                                                            //                   Text(
                                                            //                     'HARGA (RM):',
                                                            //                     style: TextStyle(fontWeight: FontWeight.bold),
                                                            //                   ),
                                                            //                   Text('${tempahanDewanData[index]['amaunPerluBayar']}'),
                                                            //                   Row(
                                                            //                     children: [
                                                            //                       if (isUTLUser)
                                                            //                         if (tempahanDewanData[index]['keteranganStatus'] != 'SELESAI')
                                                            //                           TextButton(
                                                            //                             child: const Text('Lulus Tempahan'),
                                                            //                             onPressed: () => Navigator.pop(context),
                                                            //                           )
                                                            //                         else
                                                            //                           Container(), // Placeholder for else block
                                                            //                       if (!isUTLUser)
                                                            //                         if (tempahanDewanData[index]['keteranganStatus'] != 'SELESAI')
                                                            //                           TextButton(
                                                            //                             child: const Text('Pinda Tempahan'),
                                                            //                             onPressed: () => Navigator.pop(context),
                                                            //                           )
                                                            //                         else
                                                            //                           Container(), // Placeholder for else block
                                                            //                       if (tempahanDewanData[index]['keteranganStatus'] != 'SELESAI')
                                                            //                         TextButton(
                                                            //                           child: const Text('Batal Tempahan'),
                                                            //                           onPressed: () => showDialog<String>(
                                                            //                             context: context,
                                                            //                             builder: (BuildContext context) => AlertDialog(
                                                            //                               title: const Text('Adakah Anda Pasti?'),
                                                            //                               actions: <Widget>[
                                                            //                                 TextButton(
                                                            //                                   onPressed: () => Navigator.pop(context, 'Ya'),
                                                            //                                   child: const Text('Ya'),
                                                            //                                 ),
                                                            //                                 TextButton(
                                                            //                                   onPressed: () => Navigator.pop(context, 'Tidak'),
                                                            //                                   child: const Text('Tidak'),
                                                            //                                 ),
                                                            //                               ],
                                                            //                             ),
                                                            //                           ),
                                                            //                         ),
                                                            //                       TextButton(
                                                            //                         child: const Text('Tutup'),
                                                            //                         onPressed: () => Navigator.pop(context),
                                                            //                       ),
                                                            //                     ],
                                                            //                   ),
                                                            //                 ],
                                                            //               ),
                                                            //             ),
                                                            //           ],
                                                            //         ),
                                                            //       );
                                                            //     },
                                                            //   );
                                                            // },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
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
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => DaftarGelanggangPage(),
        //       ),
        //     );
        //   },
        //   backgroundColor: Colors.green,
        //   child: const Icon(Icons.add, color: Colors.white),
        // ),
      );
    } else if (state is TempahanGelanggangStateLoading) {
      return const Center(child: Text('Loading'));
    } else {
      return const Center(child: Text('Failed'));
    }
  }
}
