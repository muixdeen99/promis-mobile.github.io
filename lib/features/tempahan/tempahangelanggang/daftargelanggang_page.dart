import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/features/tempahan/tempahangelanggang/semakkekosongan_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang.page.dart';
import 'package:promis/shared/color.dart';

import '../../../components/custom_appbar.dart';

class DaftarGelanggangPage extends StatefulWidget {
  @override
  _DaftarGelanggangPageState createState() => _DaftarGelanggangPageState();
}

class _DaftarGelanggangPageState extends State<DaftarGelanggangPage> {
  String? selectedDewan;
  String? selectedGelanggang;
  DateTime? selectedDate;
  String? selectedMasaMula;
  String? selectedMasaTamat;
  int bilanganJam = 0;
  double harga = 0.0;

  final List<String> dewanList = ['Dewan A', 'Dewan B', 'Padang C'];
  final List<String> gelanggangList = ['Court 1', 'Court 2', 'Court 3'];
  final List<String> masaMulaList = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM',
    '10:00 PM',
  ];

  final List<String> masaTamatList = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM',
    '10:00 PM',
    '11:00 PM'
  ];

  void _calculateBilanganJam() {
    if (selectedMasaMula != null && selectedMasaTamat != null) {
      int startIndex = masaMulaList.indexOf(selectedMasaMula!);
      int endIndex = masaTamatList.indexOf(selectedMasaTamat!);
      if (startIndex >= 0 && endIndex >= startIndex) {
        setState(() {
          bilanganJam = endIndex - startIndex;
          harga = (startIndex < 10) ? bilanganJam * 15.0 : bilanganJam * 20.0;
        });
      }
    }
  }

  bool _validateInputs() {
    return selectedDewan != null &&
        selectedGelanggang != null &&
        selectedDate != null &&
        selectedMasaMula != null &&
        selectedMasaTamat != null &&
        bilanganJam > 0;
  }

  void _showSemakKekosongan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const SemakKekosonganPage();
      },
    );
  }

  void _showConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Maklumat Permohonan',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow('Dewan:', selectedDewan!),
                  _buildInfoRow('Gelanggang:', selectedGelanggang!),
                  _buildInfoRow('Tarikh Tempahan:',
                      DateFormat('dd/MM/yyyy').format(selectedDate!)),
                  _buildInfoRow('Masa Mula:', selectedMasaMula!),
                  _buildInfoRow('Masa Tamat:', selectedMasaTamat!),
                  _buildInfoRow('Bilangan Jam:', '$bilanganJam Jam'),
                  _buildInfoRow('Harga:', 'RM ${harga.toStringAsFixed(2)}'),
                  _buildPriceReminder(),
                  const SizedBox(height: 20),
                  _buildBottomButtons(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('PERMOHONAN BERJAYA DIHANTAR'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'Bayar',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),

        // Add gap between buttons
        const SizedBox(width: 16),

        ElevatedButton(
          onPressed: () {
            // Add functionality for Cetak Invois
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'Cetak Invois',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),

        // Add gap between buttons
        const SizedBox(width: 16),

        ElevatedButton(
          onPressed: () {
            _showCancelConfirmationDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'Batal Tempahan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Tempahan Gelanggang',
          pageName2: '    Tempahan Gelanggang'),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDropdown('Dewan', selectedDewan, dewanList, (val) {
                  setState(() => selectedDewan = val);
                }),
                _buildDropdown('Gelanggang', selectedGelanggang, gelanggangList,
                    (val) {
                  setState(() => selectedGelanggang = val);
                }),
                const SizedBox(height: 16),
                _buildDatePicker(),
                const SizedBox(height: 16),
                // 'Semak Kekosongan' Button
                Center(
                  child: ElevatedButton(
                    onPressed: _showSemakKekosongan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Semak Kekosongan',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                _buildDropdown('Masa Mula', selectedMasaMula, masaMulaList,
                    (val) {
                  setState(() {
                    selectedMasaMula = val;
                    _calculateBilanganJam();
                  });
                }),
                _buildDropdown('Masa Tamat', selectedMasaTamat, masaTamatList,
                    (val) {
                  setState(() {
                    selectedMasaTamat = val;
                    _calculateBilanganJam();
                  });
                }),
                _buildTextField('Bilangan Jam', bilanganJam.toString()),
                _buildTextField('Harga', 'RM ${harga.toStringAsFixed(2)}'),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validateInputs()) {
                        _showConfirmationBottomSheet();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Sila lengkapkan semua maklumat sebelum meneruskan.'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('Simpan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Pilih $label'),
              value: selectedValue,
              onChanged: onChanged,
              items: options
                  .map((option) =>
                      DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tarikh Tempahan:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime now = DateTime.now();
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: now,
              lastDate: DateTime(now.year + 1),
            );
            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
              });
            }
          },
          child: Container(
            height: 40,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                  : 'Pilih Tarikh',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceReminder() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
          '⚠️ Kadar Sewa:\nSiang (9am-7pm) : RM 15\nMalam (7pm-11pm) : RM 20',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
    );
  }
}

// Confirmation Dialog for Cancelling Booking
void _showCancelConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Pembatalan Tempahan'),
        content: const Text('Adakah anda pasti mahu membatalkan tempahan ini?'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Tidak',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text(
              'Ya',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close the dialog first
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TempahanPage()),
              ); // Navigate to TempahanPage
            },
          ),
        ],
      );
    },
  );
}
