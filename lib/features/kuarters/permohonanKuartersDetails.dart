import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/infoCard.dart';
import 'package:promis/features/kuarters/semakanstatuskuarters.page.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermohonanKuartersDetails extends StatefulWidget {
  final String id;
  const PermohonanKuartersDetails({super.key, required this.id});

  @override
  State<PermohonanKuartersDetails> createState() =>
      _PermohonanKuartersDetailsState();
}
//   const PermohonanKuartersDetails({super.key});

//   @override
//   State<PermohonanKuartersDetails> createState() =>
//       _PermohonanKuartersDetailsState();
// }

class _PermohonanKuartersDetailsState extends State<PermohonanKuartersDetails> {
  String? userId;
  // List<dynamic> permohonanKuarters = [];
  Map<String, dynamic> permohonanKuarters = {};

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _fetchPermohonanKuarters(widget.id);
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
      //   await _fetchPermohonanKuarters(userId);
      // }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  Future<void> _fetchPermohonanKuarters(String id) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.kuartersApiUrl,
    );
    print('id: $id');

    const currentUser = "000119130962";

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/permohonan/$id',
      );
      // print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          permohonanKuarters = response.data; // Directly assign the object
        });
        print('Data: $permohonanKuarters');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
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
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: const CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Maklumat Permohonan',
          pageName2: 'Senarai Permohonan',
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const TabBar(
              tabs: [
                Tab(text: 'Maklumat Permohonan'),
                Tab(text: 'Kronologi Permohonan'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // First tab content
                  SingleChildScrollView(
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
                                Column(
                                  children: [
                                    permohonanKuarters.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                1, // Since it's a map, we only have one item
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Infocard(
                                                    showSemakButton: false,
                                                    showLine: false,
                                                    data: [
                                                      {
                                                        'Nama Pemohon':
                                                            '${permohonanKuarters['namaPemohon']}'
                                                      },
                                                      {
                                                        'No. Kad Pengenalan':
                                                            '${permohonanKuarters['idPemohon']}'
                                                      },
                                                      {
                                                        'No Telefon Bimbit':
                                                            '${permohonanKuarters['namaPemohon']}'
                                                      },
                                                      {
                                                        'Emel':
                                                            '${permohonanKuarters['idPemohon']}'
                                                      },
                                                      {
                                                        'Alamat Semasa':
                                                            '${permohonanKuarters['namaPemohon']}'
                                                      },
                                                      {
                                                        'Lokasi Kuarters':
                                                            '${permohonanKuarters['keteranganLokasiKuarters']}'
                                                      },
                                                      {
                                                        'Lokasi Pekerjaan':
                                                            '${permohonanKuarters['namaPemohon']}'
                                                      },
                                                      {
                                                        'Kelas Perkhidmatan':
                                                            '${permohonanKuarters['idKelasPerkhidmatan']}'
                                                      },
                                                      {
                                                        'Gred Perkhidmatan':
                                                            '${permohonanKuarters['idGredPerkhidmatan']}'
                                                      },
                                                      {
                                                        'Pinjaman Perumahan':
                                                            '${permohonanKuarters['jenisPinjamanPerumahan']}'
                                                      },
                                                      // {'Negeri': '${permohonanKuarters['namaPemohon']}'},
                                                      // {'Tarikh Permohonan': '${permohonanKuarters['namaPemohon']}'},
                                                      // {'Jenis Perumahan': '${permohonanKuarters['namaPemohon']}'},
                                                    ],
                                                  ),
                                                ],
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
                  // Second tab content
                  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Maklumat Permohonan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Age',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Role',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                              rows: const <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Sarah')),
                                    DataCell(Text('19')),
                                    DataCell(Text('Student')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Janine')),
                                    DataCell(Text('43')),
                                    DataCell(Text('Professor')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('William')),
                                    DataCell(Text('27')),
                                    DataCell(Text('Associate Professor')),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
