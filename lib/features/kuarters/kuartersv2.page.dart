import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/menu_card.dart';
import 'package:promis/features/kuarters/dimerit.page.dart';
import 'package:promis/features/kuarters/janjitemu.page.dart';
import 'package:promis/features/kuarters/penyelenggaraan/semakansurcaj.page.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class KuartersV2Page extends StatefulWidget {
  const KuartersV2Page({super.key});

  @override
  State<KuartersV2Page> createState() => _KuartersV2PageState();
}

class _KuartersV2PageState extends State<KuartersV2Page> {
  String? userId;
  // List<dynamic> peranan = [];
  Map<String, dynamic> peranan = {};
  bool isPGTUser = false;
  bool isSGRUser = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _role(String userId) async {
    setState(() {
      isLoading = true;
    });
    final roleResponse = await Dio().get(
        'https://gerbang.lokal.my/api/pentadbiran/v1/mobile/pengguna/$userId/peranan');
    if (roleResponse.statusCode == 200) {
      final data = roleResponse.data;

      for (var role in data) {
        if (role['id'].contains('92f8c650a839442f811dcc5a2833c89c') ||
            role['id'].contains('3864a741273347a0b5d1cbe7ea936c0a')) {
          isPGTUser = true;
          break;
        }
      }

      for (var role in data) {
        if (role['id'].contains('f5c9b2280101465693c892c2f6b5a90a') ||
            role['id'].contains('cc9aea4b3ae24c87ab8dc396b04b9587')) {
          isSGRUser = true;
          print(isSGRUser);
          break;
        }
      }

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
        await _role(userId);
      }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  Future<void> _peranan(String userId) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.pentadbiranApiUrl,
    );

    const currentUser = "000119130962";

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/pengguna/$currentUser/peranan',
        // 'mobile/pemohon/$currentUser/permohonan',
      );
      print('currentUser: $currentUser'); // Print the entire response
      print('Response: ${response.data}'); // Print the entire response
      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          peranan =
              response.data['data'][0]; // Assuming the first item in the list
        });
        print('Data: $peranan');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          userName: '', pageName1: 'Kuarters', pageName2: ''),
      drawer: const CustomDrawer(),
      body: Container(
        color: Color.fromARGB(255, 235, 241, 253),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0), // Adjust padding as needed
                  child: Column(
                    children: <Widget>[
                      if (isLoading)
                        CircularProgressIndicator()
                      else
                        Menu_card(
                            title: "Penawaran",
                            targetPage: PenawaranPage(),
                            icon: Icons.local_offer),
                      Container(height: 10),
                      if (isPGTUser)
                        Menu_card(
                            title: "Penguatkuasa",
                            targetPage: KuartersPage(),
                            icon: Icons.gavel),

                      const SizedBox(height: 10),
                      if (isSGRUser)
                        Menu_card(
                            title: "Penyelenggaraan",
                            targetPage: SemakanSurcajPage(),
                            icon: Icons.build),

                      Container(height: 10),

                      // Staff ID TextField
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
