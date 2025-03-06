import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/senaraiperanginan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:intl/intl.dart';
import 'package:promis/shared/api.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:promis/shared/api.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:promis/features/rumahperanginan/tempahanlondon_page.dart';

class MaklumatPermohonanPage extends StatefulWidget {
  final String id;

  const MaklumatPermohonanPage({super.key, required this.id});

  @override
  State<MaklumatPermohonanPage> createState() => _MaklumatPermohonanPageState();
}

class _MaklumatPermohonanPageState extends State<MaklumatPermohonanPage> {
  String? userId;
  bool isRPPUser = false;
  bool RPPUser = false;

  Map<String, dynamic>? londonData;

  @override
  void initState() {
    super.initState();
    _fetchUserData(widget.id);
    _loadUserId();
    _loadisRPPUser();
  }

  Future<void> _loadisRPPUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isRPPUser = prefs.getBool('isRPPUser') ?? false;
      });
      print('isRPPUser: $isRPPUser');
    } catch (e) {
      print('Error loading isRPPUser: $e');
    }
  }

  Future<void> _fetchUserData(String id) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.rppApiUrl,
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        RPPUser = prefs.getBool('isRPPUser') ?? false;
      });
      print('RPPUser: $RPPUser');
      print('ID: $id');
    } catch (e) {
      print('Error loading isRPPUser: $e');
    }

    try {
      String url = '/mobile/tempahan/london/$id';

      if (RPPUser) {
        url = '/mobile/tempahan/london/$id';
      }

      print('Request URL: $url');
      var response = await apiService.makeRequest(
        RequestMethod.get,
        url,
      );

      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        setState(() {
          londonData = response.data as Map<String, dynamic>;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
      print('Response Data: $londonData');
    } catch (e) {
      print('Error fetching user data: $e');
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

      // if (userId != null) {
      //   await _fetchUserData(userId);
      // }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: 'Maklumat Permohonan',
        pageName2: '    Semakan Tempahan London',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoText('No Tempahan:', londonData?['noTempahan'] ?? 'N/A'),
                infoText('Tarikh Tempahan:',
                    londonData?['tarikhDaftarRekod'] ?? 'N/A'),
                infoText('Rumah Peranginan:',
                    londonData?['namaPeranginan' ?? 'N/A']),
                infoText('Jenis Unit:',
                    londonData?['keteranganJenisUnitRpp' ?? 'N/A']),
                infoText(
                    'Tarikh Masuk:', londonData?['tarikhMasukRpp' ?? 'N/A']),
                infoText(
                    'Tarikh Keluar:', londonData?['tarikhKeluarRpp' ?? 'N/A']),
                infoText(
                    'Bil Malam Menginap:', londonData?['bilMalam' ?? 'N/A']),
                infoText('Amaun Perlu Dibayar (RM):',
                    londonData?['bilMalam' ?? 'N/A']),
                // infoText('Tarikh Akhir Bayaran:',
                //     londonData?['tarikhAkhirBayaran' ?? 'N/A']),
                infoText('Status Tempahan:',
                    londonData?['keteranganStatus' ?? 'N/A']),
                infoText('Status Bayaran:',
                    londonData?['keteranganFlagStatusBayaran' ?? 'N/A']),
                // infoText('Surat Kelulusan:',
                //     londonData?['dirSuratKelulusan' ?? 'N/A']),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CETAK BORANG TEMPAHAN LONDON',
                    style: TextStyle(
                      color: Colors.indigo,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'Batal Permohonan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 2,
            left: 2,
            child: SizedBox(
              height: 40,
              width: 50,
              child: FloatingActionButton(
                elevation: 0,
                hoverElevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightElevation: 0,
                hoverColor: Colors.transparent,
                mini: true, // Makes the button smaller
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const TempahanLondonPage(); // Target page
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin =
                            Offset(-1.0, 0.0); // Slide in from the left
                        const end = Offset.zero; // Final position at the center
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(
                          milliseconds: 500), // Adjust duration as needed
                    ),
                  );
                },
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }
}
