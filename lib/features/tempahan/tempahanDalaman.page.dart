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
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/aduan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang.page.dart';
import 'package:promis/features/tempahan/semakanjadualbertugas.page.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok.page.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok_notifier.dart';
import 'package:promis/shared/color.dart';

import '../../components/custom_appbar.dart';
import 'tempahangelanggang/custom_drawer.dart';

class TempahanDalamanPage extends StatefulWidget {
  const TempahanDalamanPage({super.key});

  @override
  State<TempahanDalamanPage> createState() => _TempahanDalamanPageState();
}

class _TempahanDalamanPageState extends State<TempahanDalamanPage> {
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
                      Container(height: 10),
                      Menu_card(
                        title: 'Tempahan',
                        targetPage: const TempahanPage(),
                        icon: Icons.event,
                      ),
                      Container(height: 10),
                      Menu_card(
                        title: 'Jadual Petugas',
                        targetPage: const JadualBertugasPage(),
                        icon: Icons.calendar_month,
                      ),
                      Container(height: 10),
                      Menu_card(
                        title: 'Aduan Kerosakan',
                        targetPage: const AduanPage(),
                        icon: Icons.edit,
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
