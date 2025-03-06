import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/senaraiperanginan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';

class SenaraiRumahTransitPage extends StatefulWidget {
  const SenaraiRumahTransitPage({super.key});

  @override
  State<SenaraiRumahTransitPage> createState() =>
      _SenaraiRumahTransitPageState();
}

class _SenaraiRumahTransitPageState extends State<SenaraiRumahTransitPage> {
  List<dynamic> transitData = [];

  @override
  void initState() {
    super.initState();
    _fetchTransitData();
  }

  Future<void> _fetchTransitData() async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.rppApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/peranginan/rumah/transit',
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          setState(() {
            transitData = response.data;
          });
        } else if (response.data is Map) {
          // Assuming the list is inside a key like "data" or "results"
          setState(() {
            transitData =
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

  List<Widget> _buildTransitList() {
    const defaultImagePath = 'assets/images/bilik.jpg';
    return transitData.map((data) {
      return _buildRumahCard(data['namaPeranginan'], defaultImagePath);
    }).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Transit',
        pageName2: '    Senarai Rumah Transit',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: _buildTransitList(),
                ),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              splashColor: Colors.transparent,
              mini: true,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const RumahPeranginanPage();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
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
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ],
      ),
    );
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
            child: Image.asset(
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
