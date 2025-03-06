import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:promis/components/navigationButton.dart';
import 'package:promis/features/kuarters/janjitemu.page.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/kuarters/kuartersv2.page.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/semakandanbayaran.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahanDalaman.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_appbar.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/testpage/testpage1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LamanUtamaPage extends StatefulWidget {
  const LamanUtamaPage({super.key});

  @override
  State<LamanUtamaPage> createState() => _LamanUtamaPageState();
}

List<Widget> carouselItems = [
  Image.asset(
    'assets/images/holiday1.png',
    fit: BoxFit.cover, // Adjust the fit as needed
    width: double.infinity, // Ensures the image takes up the full width
  ),
  Image.asset(
    'assets/images/holiday2.jpg',
    fit: BoxFit.cover,
    width: double.infinity,
  ),
  Image.asset(
    'assets/images/holiday3.png',
    fit: BoxFit.cover,
    width: double.infinity,
  ),
  Image.asset(
    'assets/images/holiday4.jpg',
    fit: BoxFit.cover,
    width: double.infinity,
  ),
  Image.asset(
    'assets/images/holiday5.jpg',
    fit: BoxFit.cover,
    width: double.infinity,
  ),
];

List<Widget> carouselText = [
  const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'Enjoy your holidays with our amazing packages. Discover stunning destinations and unforgettable experiences.',
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'Exclusive offers available for a limited time. Book your dream vacation today and make lasting memories.',
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'From beaches to mountains, explore the world with our tailored holiday plans. Adventure awaits you!',
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'Family-friendly getaways and romantic retreats are just a click away. Start your journey now!',
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
  ),
  const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'Travel in comfort and style with our curated selection of top-rated accommodations and tours.',
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
  ),
];

class _LamanUtamaPageState extends State<LamanUtamaPage> {
  String? userId;
  String? namaPengguna;
  bool isQtrUser = false;
  bool isUTLUser = false;
  bool isSGRUser = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadUserName();
    _loadIsQtrUser();
    _loadIsUTLUser();
  }

  Future<void> _loadIsQtrUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isQtrUser = prefs.getBool('isQtrUser') ?? false;
        isSGRUser = prefs.getBool('isSGRUser') ?? false;
      });
      print('isQtrUser: $isQtrUser');
      print('isSGRUser: $isSGRUser');
    } catch (e) {
      print('Error loading isQtrUser: $e');
    }
  }

  Future<void> _loadIsUTLUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isUTLUser = prefs.getBool('isUTLUser') ?? false;
      });
      print('isUTLUser: $isUTLUser');
    } catch (e) {
      print('Error loading isUTLUser: $e');
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
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  Future<void> _loadUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final namaPengguna = prefs.getString('namaPengguna');
      print('namaPengguna: $namaPengguna');
      setState(() {
        this.namaPengguna = namaPengguna;
      });
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 235, 241, 253),
        leading: Builder(
          builder: (context) => IconButton(
            iconSize: 30,
            icon: const Icon(Icons.menu, color: primaryColor),
            tooltip: 'Menu',
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open drawer
            },
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.notifications, color: primaryColor),
            tooltip: 'Notifications',
            onPressed: () {
              // Handle the press
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Container(
        color: Color.fromARGB(255, 235, 241, 253),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 20.0), // Adjust padding as needed
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selamat Datang,',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$namaPengguna',
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Add a background color
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Apply the same border radius
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height *
                                0.18, // Adjust height for your design
                            viewportFraction:
                                1.0, // Ensures each image fits the screen width
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 2000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false, // Disable enlargement
                          ),
                          items: carouselItems,
                        ),
                      ),
                    ),
                    Container(height: 30),
                    const Text(
                      'Pengumuman',
                      style: TextStyle(
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.10,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 2000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                        ),
                        items: carouselText,
                      ),
                    ),
                    const Divider(),
                    Container(height: 10),
                    Center(
                      child: Wrap(
                        alignment:
                            WrapAlignment.center, // Centers items horizontally
                        spacing: 20, // Horizontal spacing
                        runSpacing: 20, // Vertical spacing
                        children: [
                          NavigationButton(
                            icon: Icons.home,
                            title: 'Semakan Kuarters',
                            targetPage: isQtrUser || isSGRUser
                                ? const KuartersV2Page()
                                : const PenawaranPage(),
                            iconColor: Color.fromARGB(255, 17, 54, 107),
                            backgroundColor: Colors.blue.withOpacity(0.2),
                          ),
                          NavigationButton(
                            icon: Icons.edit_document,
                            title: 'Tempahan Peranginan',
                            targetPage: const RumahPeranginanPage(),
                            iconColor: Color.fromARGB(255, 17, 54, 107),
                            backgroundColor: Colors.blue.withOpacity(0.2),
                          ),
                          NavigationButton(
                            icon: Icons.houseboat,
                            title: 'Dewan dan Gelanggang',
                            targetPage: isQtrUser
                                ? const TempahanPage()
                                : const TempahanDalamanPage(),
                            iconColor: Color.fromARGB(255, 17, 54, 107),
                            backgroundColor: Colors.blue.withOpacity(0.2),
                          ),
                          NavigationButton(
                            icon: Icons.attach_money,
                            title: 'Status Bayaran',
                            targetPage: const SemakanDanBayaranPage(),
                            iconColor: Color.fromARGB(255, 17, 54, 107),
                            backgroundColor: Colors.blue.withOpacity(0.2),
                          ),
                          NavigationButton(
                            icon: Icons.logout,
                            title: 'Keluar',
                            targetPage: const LoginPage(),
                            iconColor: Color.fromARGB(255, 17, 54, 107),
                            backgroundColor: Colors.blue.withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 50),
                    const Divider(),
                    Container(height: 50),
                    // Staff ID TextField
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
