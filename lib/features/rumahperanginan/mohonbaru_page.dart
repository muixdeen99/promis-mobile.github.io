import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/features/rumahperanginan/tempahanlondon_page.dart';
import 'package:intl/intl.dart';

class MohonBaruPage extends StatefulWidget {
  const MohonBaruPage({super.key});

  @override
  State<MohonBaruPage> createState() => _MohonBaruPageState();
}

class _MohonBaruPageState extends State<MohonBaruPage> {
  final TextEditingController _tarikhTempahanController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController _tarikhMasukController = TextEditingController();
  final TextEditingController _tarikhKeluarController = TextEditingController();

  String? _rumahPeranginan;
  String? _jenisUnit;

  final List<String> rumahPeranginanList = ['London', 'Paris', 'New York'];
  final List<String> jenisUnitList = ['Deluxe', 'Standard', 'Suite'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Peranginan',
        pageName2: '    Tempahan London',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _tarikhTempahanController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Tarikh Tempahan',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _rumahPeranginan,
                  decoration: const InputDecoration(
                    labelText: 'Rumah Peranginan',
                    border: OutlineInputBorder(),
                  ),
                  items: rumahPeranginanList
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _rumahPeranginan = value),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _jenisUnit,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Unit',
                    border: OutlineInputBorder(),
                  ),
                  items: jenisUnitList
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _jenisUnit = value),
                ),
                const SizedBox(height: 12),
                _buildDateInput('Tarikh Masuk', _tarikhMasukController),
                _buildDateInput('Tarikh Keluar', _tarikhKeluarController),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Simpan',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
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
                mini: true,
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const TempahanLondonPage();
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
          ),
        ],
      ),
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          readOnly: true,
          controller: controller,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              controller.text = DateFormat('dd/MM/yyyy').format(picked);
            }
          },
          decoration: InputDecoration(
            hintText: 'Pilih Tarikh',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
