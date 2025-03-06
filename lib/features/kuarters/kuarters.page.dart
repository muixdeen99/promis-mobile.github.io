import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/menu_card.dart';
import 'package:promis/features/kuarters/dimerit.page.dart';
import 'package:promis/features/kuarters/janjitemu.page.dart';
import 'package:promis/features/kuarters/semakanjadualbertugas.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/kuarters/semakanstatusjanjitemu.page.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/shared/color.dart';

import '../tempahan/tempahangelanggang/custom_drawer.dart';

class KuartersPage extends StatefulWidget {
  const KuartersPage({super.key});

  @override
  State<KuartersPage> createState() => _KuartersPageState();
}

class _KuartersPageState extends State<KuartersPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(userName: '', pageName1: 'Penguatkuasa', pageName2: ''),
      drawer: const CustomDrawer(),
      body:Container(
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
                          title: "Jadual Petugas Kunci",
                          targetPage: SemakanJadualBertugasPage(),
                          icon: Icons.key),
                      Container(height: 10),
                      Menu_card(
                          title: "Semakan Janjitemu",
                          targetPage: SemakanStatusJanjitemuPage(),
                          icon: Icons.table_bar),
                      Container(height: 10),
                      Menu_card(
                          title: "Penutupan Slot Janjitemu",
                          targetPage: JanjitemuPage(),
                          icon: Icons.door_back_door),
                      Container(height: 10),
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
