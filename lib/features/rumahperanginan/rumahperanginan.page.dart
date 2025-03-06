import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/menu_card.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/rumahperanginan/rumahtransit_page.dart';
import 'package:promis/features/rumahperanginan/sejarahpermohonan_page.dart';
import 'package:promis/features/rumahperanginan/semakandanbayaran.page.dart';
import 'package:promis/features/rumahperanginan/tempahanlondon_page.dart';
import 'package:promis/features/rumahperanginan/tempahanrumahperanginan_page.dart';
import 'package:promis/features/rumahperanginan/terimaankelompok_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';

class RumahPeranginanPage extends StatefulWidget {
  const RumahPeranginanPage({super.key});
  

  @override
  State<RumahPeranginanPage> createState() => _RumahPeranginanPageState();
}

class _RumahPeranginanPageState extends State<RumahPeranginanPage> {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Peranginan',
        pageName2: '    ',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0), // Adjust padding as needed
                child: Column(
                  children: <Widget>[
                    
                    Menu_card(
                      title: 'Tempahan Eksekutif/Premier',
                      targetPage: const TempahanRumahPeranginanPage(),
                      icon: Icons.event,
                    ),
                    
                    Menu_card(
                        title: 'Tempahan London',
                        targetPage: const TempahanLondonPage(),
                        icon: Icons.event,
                      ),
                    
                    Menu_card(
                        title: 'Rumah Transit',
                        targetPage: const SenaraiRumahTransitPage(),
                        icon: Icons.home,
                      ),
                    
                    Menu_card(
                        title: 'Semakan dan Bayaran',
                        targetPage: const SemakanDanBayaranPage(),
                        icon: Icons.fact_check,
                      ),
                    Menu_card(
                        title: 'Terimaan Kelompok',
                        targetPage: const TerimaankelompokPage(),
                        icon: Icons.receipt_long,
                      ),
                    Menu_card(
                        title: 'Permohonan London',
                        targetPage: const SemakanDanBayaranPage(),
                        icon: Icons.assignment,
                      ),
                    Menu_card(
                        title: 'Sejarah Permohonan',
                        targetPage: const SejarahPermohonanPage(),
                        icon: Icons.history,
                      ),
                    Menu_card(
                        title: 'Semakan',
                        targetPage: const SemakanDanBayaranPage(),
                        icon: Icons.fact_check,
                      ),
                    Menu_card(
                        title: 'Sejarah Kekosongan',
                        targetPage: const SemakanDanBayaranPage(),
                        icon: Icons.history,
                      ),
                    Menu_card(
                        title: 'Semakan Pemohon',
                        targetPage: const SemakanDanBayaranPage(),
                        icon: Icons.fact_check,
                      ),
                    

                    // Staff ID TextField
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
