import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/senaraiperanginan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/api.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';

class TempahanRumahPeranginanPage extends StatefulWidget {
  const TempahanRumahPeranginanPage({super.key});

  @override
  State<TempahanRumahPeranginanPage> createState() =>
      _TempahanRumahPeranginanPageState();
}

class _TempahanRumahPeranginanPageState
    extends State<TempahanRumahPeranginanPage> {
  bool isEksekutif = true;
  List<dynamic> eksekutifData = [];
  List<dynamic> premierData = [];

  @override
  void initState() {
    super.initState();
    _fetchEksekutifData();
    _fetchPremierData();
  }

  Future<void> _fetchEksekutifData() async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.rppApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/peranginan/tempahan/eksekutif',
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          setState(() {
            eksekutifData = response.data;
          });
        } else if (response.data is Map) {
          // Assuming the list is inside a key like "data" or "results"
          setState(() {
            eksekutifData =
                response.data['data'] ?? []; // Adjust based on API response
          });
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _fetchPremierData() async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.rppApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/peranginan/tempahan/premier',
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          setState(() {
            premierData = response.data;
          });
        } else if (response.data is Map) {
          // Assuming the list is inside a key like "data" or "results"
          setState(() {
            premierData =
                response.data['data'] ?? []; // Adjust based on API response
          });
        }
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
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Peranginan',
        pageName2: '    Tempahan Eksekutif / Premier',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEksekutif = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isEksekutif ? Colors.black : Colors.grey[300],
                        foregroundColor:
                            isEksekutif ? Colors.white : Colors.black,
                      ),
                      child: const Text('Eksekutif'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEksekutif = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !isEksekutif ? Colors.black : Colors.grey[300],
                        foregroundColor:
                            !isEksekutif ? Colors.white : Colors.black,
                      ),
                      child: const Text('Premier'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children:
                      isEksekutif ? _buildEksekutifList() : _buildPremierList(),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  List<Widget> _buildEksekutifList() {
    const defaultImagePath = 'assets/images/rumah-country.jpg';
    final List<dynamic> eksekutifList =
        eksekutifData is List ? eksekutifData : [eksekutifData];

    return eksekutifList.map((data) {
      return _buildRumahCard(data['namaPeranginan'], defaultImagePath);
    }).toList();
  }

  List<Widget> _buildPremierList() {
    const defaultImagePath = 'assets/images/bilik.jpg';
    final List<dynamic> premierList =
        premierData is List ? premierData : [premierData];

    return premierList.map((data) {
      return _buildRumahCard(data['namaPeranginan'], defaultImagePath);
    }).toList();
  }

  Widget _buildRumahCard(String title, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(15.0)),
            child: imagePath.startsWith('assets/')
                ? Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const SenaraiPeranginanPage();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class RumahDetailPage extends StatelessWidget {
//   final String title;

//   const RumahDetailPage({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Center(
//         child: Text(
//           'Details of $title',
//           style: const TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
