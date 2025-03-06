import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promis/components/menu_card.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/bayarandeposit/bayarandepositgelanggang_page.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.page.dart';
import 'package:promis/features/tempahan/tempahanDalaman.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang.page.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok.page.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok_notifier.dart';
import 'package:promis/shared/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_appbar.dart';
import 'tempahangelanggang/custom_drawer.dart';

class TempahanPage extends StatefulWidget {
  const TempahanPage({super.key});

  @override
  State<TempahanPage> createState() => _TempahanPageState();
}

class _TempahanPageState extends State<TempahanPage> {
  bool isUTLUser = false;

  @override
  void initState() {
    super.initState();
    _loadIsUTLUser();
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

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(tempahanGelanggangBerkelompokNotifierProvider);
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: 'Dewan & Gelanggang',
        pageName2: 'Senarai Permohonan',
      ),
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
                      SizedBox(
                        height: 80,
                        width: 400,
                        child: Menu_card(
                          title: 'Tempahan Dewan',
                          targetPage: const TempahanDewanPage(),
                          icon: Icons.business,
                        ),
                      ),
                      Container(height: 10),
                      Menu_card(
                        title: 'Tempahan Gelanggang',
                        targetPage: const TempahanGelanggangPage(),
                        icon: Icons.stadium,
                      ),
                      // Container(height: 50),
                      // SizedBox(
                      //   height: 80,
                      //   width: 400,
                      //   child: Card(
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: ListTile(
                      //         leading: ClipRRect(
                      //           borderRadius: BorderRadius.circular(
                      //               8.0), // Optional: to make the image corners rounded
                      //           child: const Icon(
                      //             Icons.image,
                      //             size: 50,
                      //           ),
                      //         ),
                      //         title: const Text(
                      //           'Tempahan Gelanggang Berkelompok',
                      //           style: TextStyle(
                      //               color: primaryColor,
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //         trailing: const Icon(Icons.chevron_right),
                      //         onTap: () {
                      //           //  ref.read(tempahanGelanggangBerkelompokNotifierProvider.notifier).refresh();
                      //           Navigator.of(context).push(
                      //             PageRouteBuilder(
                      //               pageBuilder:
                      //                   (context, animation, secondaryAnimation) {
                      //                 return const TempahanGelanggangBerkelompokPage(); // Target page
                      //               },
                      //               transitionsBuilder: (context, animation,
                      //                   secondaryAnimation, child) {
                      //                 // Define the slide direction (e.g., from right to left)
                      //                 const begin = Offset(1.0,
                      //                     0.0); // Start position (1.0, 0.0) is from the right
                      //                 const end = Offset
                      //                     .zero; // End position is the center (0, 0)
                      //                 const curve = Curves.easeInOut;

                      //                 // Create the tween for the sliding animation
                      //                 var tween = Tween(begin: begin, end: end)
                      //                     .chain(CurveTween(curve: curve));
                      //                 var offsetAnimation =
                      //                     animation.drive(tween);

                      //                 // Apply the SlideTransition
                      //                 return SlideTransition(
                      //                   position:
                      //                       offsetAnimation, // Slide from the right to the center
                      //                   child: child,
                      //                 );
                      //               },
                      //               transitionDuration: const Duration(
                      //                   milliseconds:
                      //                       500), // Adjust duration as needed
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(height: 50),
                      // SizedBox(
                      //   height: 80,
                      //   width: 400,
                      //   child: Card(
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: ListTile(
                      //         leading: ClipRRect(
                      //           borderRadius: BorderRadius.circular(8.0),
                      //           child: const Icon(
                      //             Icons.attach_money, // Icon representing payment
                      //             size: 50,
                      //             color: primaryColor,
                      //           ),
                      //         ),
                      //         title: const Text(
                      //           'Bayaran Deposit',
                      //           style: TextStyle(
                      //             color: primaryColor,
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //         ),
                      //         trailing: const Icon(Icons.chevron_right),
                      //         onTap: () {
                      //           Navigator.of(context).push(
                      //             PageRouteBuilder(
                      //               pageBuilder:
                      //                   (context, animation, secondaryAnimation) {
                      //                 return const BayaranDepositGelanggangPage(); // Target page for Bayaran Deposit
                      //               },
                      //               transitionsBuilder: (context, animation,
                      //                   secondaryAnimation, child) {
                      //                 // Define the slide transition from right to left
                      //                 const begin = Offset(1.0, 0.0);
                      //                 const end = Offset.zero;
                      //                 const curve = Curves.easeInOut;

                      //                 var tween = Tween(begin: begin, end: end)
                      //                     .chain(CurveTween(curve: curve));
                      //                 var offsetAnimation =
                      //                     animation.drive(tween);

                      //                 // Apply the SlideTransition
                      //                 return SlideTransition(
                      //                   position: offsetAnimation,
                      //                   child: child,
                      //                 );
                      //               },
                      //               transitionDuration:
                      //                   const Duration(milliseconds: 500),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),

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
