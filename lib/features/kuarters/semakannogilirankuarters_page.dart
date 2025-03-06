import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:promis/shared/environment_config.dart';

class SemakannogilirankuartersPage extends StatefulWidget {
  const SemakannogilirankuartersPage({super.key});

  @override
  State<SemakannogilirankuartersPage> createState() =>
      _SemakannogilirankuartersPageState();
}

class _SemakannogilirankuartersPageState
    extends State<SemakannogilirankuartersPage> {
  List<dynamic> noGiliran = [];
  String? userId;
  bool QtrUser = false;
  @override
  void initState() {
    super.initState();
    _loadUserId();
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
        await _fetchSemakanNoGiliran(userId);
      }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  Future<void> _fetchSemakanNoGiliran(String userId) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.kuartersApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        '/mobile/pemohon/$userId/giliran',
      );

      if (QtrUser) {
        response = await apiService.makeRequest(
          RequestMethod.get,
          'mobile/giliran',
        );
      }

      print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          noGiliran = response.data['data'];
        });
        print('Data: $noGiliran');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _showDepositDetails(String noInvois, String tarikhInvois,
      String kodHasil, String keterangan, String amaun) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Maklumat Deposit',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDetailCard('Maklumat Bayaran', {
                      'No. Invois': noInvois,
                      'Tarikh Invois': tarikhInvois,
                      'Kod Hasil': kodHasil,
                      'Keterangan': keterangan,
                      'Amaun (RM)': amaun,
                    }),
                    const SizedBox(height: 20),
                    _buildDetailCard('Maklumat Akaun', {
                      'Nama Akaun': 'Muhammad Yusri',
                      'Nombor Akaun': '1234567890',
                      'Bank': 'Maybank',
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailCard(String title, Map<String, String> details) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...details.entries
                .map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(entry.value),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Kuarters',
        pageName2: '    Senarai Maklumat Kuarters',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                noGiliran.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: noGiliran.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return const PenawaranPage(); // Target page
                                                  },
                                                  transitionsBuilder: (context,
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
                                                        animation.drive(tween);

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
                                            child: Card(
                                              surfaceTintColor: Colors.white,
                                              elevation: 5,
                                              shadowColor: Colors.black,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${noGiliran[index]['keteranganLokasiKuarters']}',
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
                                                        0: FlexColumnWidth(2),
                                                        1: FlexColumnWidth(3),
                                                      },
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Nama Pemohon ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              '${noGiliran[index]['namaPemohon']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Kelas ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              '${noGiliran[index]['idKelasKuarters']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'noGiliran ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              '${noGiliran[index]['noGiliran']}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            const Text(
                                                              'Tarikh Kemaskini ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              '${noGiliran[index]['tarikhKemaskini'] ?? '-'}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
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
                        const SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
              ),
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
                        return const PenawaranPage(); // Target page
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

  Widget _buildDepositCard(String noInvois, String tarikhInvois,
      String kodHasil, String keterangan, String amaun) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No. Invois: $noInvois',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text('# Kod Hasil: $kodHasil',
                style: const TextStyle(color: Colors.black)),
            Text('Keterangan: $keterangan',
                style: const TextStyle(color: Colors.black)),
            Text('Amaun: RM $amaun',
                style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => _showDepositDetails(
                    noInvois, tarikhInvois, kodHasil, keterangan, amaun),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Bayar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
