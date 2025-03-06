import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/menu_card.dart';
import 'package:promis/features/kuarters/bayarandepositkuarters_page.dart';
import 'package:promis/features/kuarters/dimerit.page.dart';
import 'package:promis/features/kuarters/kesalahan.page.dart';
import 'package:promis/features/kuarters/janjitemu.page.dart';
import 'package:promis/features/kuarters/senaraideposit.page.dart';
import 'package:promis/features/kuarters/semakannogilirankuarters_page.dart';
import 'package:promis/features/kuarters/semakanstatusjanjitemu.page.dart';
import 'package:promis/features/kuarters/semakanstatuskuarters.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/tempahanrumahperanginan_page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenawaranPage extends StatefulWidget {
  const PenawaranPage({super.key});

  @override
  State<PenawaranPage> createState() => _PenawaranPageState();
}

class _PenawaranPageState extends State<PenawaranPage> {
  // This widget is the root of your application.

  String? userId;
  bool isQtrUser = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadIsQtrUser();
  }

  Future<void> _loadIsQtrUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isQtrUser = prefs.getBool('isQtrUser') ?? false;
      });
      print('isQtrUser: $isQtrUser');
    } catch (e) {
      print('Error loading isQtrUser: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
          userName: '', pageName1: 'Penawaran', pageName2: ''),
      // drawer: const CustomDrawer(),
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
                          title: "Semakan Status Permohonan Kuarters",
                          targetPage: SemakanStatusKuartersPage(),
                          icon: Icons.dynamic_form_outlined),
                      Container(height: 10),
                      Menu_card(
                          title: "Semakan Status Janjitemu",
                          targetPage: SemakanStatusJanjitemuPage(),
                          icon: Icons.table_bar),
                      Container(height: 10),
                      Menu_card(
                          title: "Penutupan Slot Janjitemu",
                          targetPage: JanjitemuPage(),
                          icon: Icons.door_back_door),
                      Container(height: 10),
                      if (isQtrUser)
                        const Menu_card(
                          title: "Senarai Deposit",
                          targetPage: SenaraiDepositPage(),
                          icon: Icons.money,
                        ),
                      Container(height: 10),
                      // if (isQtrUser)
                      //   Menu_card(
                      //       title: "Semakan No Giliran",
                      //       targetPage: SemakannogilirankuartersPage(),
                      //       icon: Icons.numbers),
                      // // const SizedBox(height: 10),
                      //  Menu_card(
                      //       title: "Semakan No Giliran",
                      //       targetPage: SemakannogilirankuartersPage(),
                      //       icon: Icons.numbers),
                      // Container(height: 10),
                      Menu_card(
                          title: "Semakan Pelanggaran Syarat",
                          targetPage: KesalahanPage(),
                          icon: Icons.rule),
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
