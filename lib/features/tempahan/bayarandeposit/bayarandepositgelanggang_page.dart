import 'package:flutter/material.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_appbar.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';

class BayaranDepositGelanggangPage extends StatefulWidget {
  const BayaranDepositGelanggangPage({super.key});

  @override
  State<BayaranDepositGelanggangPage> createState() => _BayaranDepositGelanggangPageState();
}

class _BayaranDepositGelanggangPageState extends State<BayaranDepositGelanggangPage> {
  void _showDepositDetails(String noInvois, String tarikhInvois, String kodHasil, String keterangan, String amaun) {
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            ...details.entries.map((entry) => Padding(
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
            )).toList(),
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
        pageName1: '    Dewan dan Gelanggang',
        pageName2: '    Bayaran Deposit',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Senarai Deposit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDepositCard('BPH/IR/TK/2025/000003', '01/01/2025', '111111', 'Bayaran Deposit untuk Gelanggang', '100.00'),
                const SizedBox(height: 10),
                _buildDepositCard('BPH/IR/TK/2025/000004', '02/01/2025', '222222', 'Bayaran Deposit untuk Dewan', '150.00'),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildDepositCard(String noInvois, String tarikhInvois, String kodHasil, String keterangan, String amaun) {
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
            Text('# Kod Hasil: $kodHasil', style: const TextStyle(color: Colors.black)),
            Text('Keterangan: $keterangan', style: const TextStyle(color: Colors.black)),
            Text('Amaun: RM $amaun', style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => _showDepositDetails(noInvois, tarikhInvois, kodHasil, keterangan, amaun),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Bayar',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
