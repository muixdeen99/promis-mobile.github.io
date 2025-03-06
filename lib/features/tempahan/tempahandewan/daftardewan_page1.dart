import 'package:flutter/material.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../../../components/custom_appbar.dart';

class DaftarDewanPage extends StatefulWidget {
  const DaftarDewanPage({super.key});

  @override
  State<DaftarDewanPage> createState() => _DaftarDewanPageState();
}

class _DaftarDewanPageState extends State<DaftarDewanPage> {
  String _range = '';
  int _days = 0;
  final double _ratePerDay = 100; // Example rate per day
  double _totalPrice = 0;

  String? _selectedDewan;
  String? _selectedTujuan;
  String? _tarikhMula;
  String? _tarikhTamat;

  final List<String> _dewanOptions = ['Dewan A', 'Dewan B', 'Padang C'];
  final List<String> _tujuanOptions = ['Majlis', 'Sukan', 'Persembahan'];
    final TextEditingController _dateRangeController = TextEditingController();


  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        final startDate = args.value.startDate;
        final endDate = args.value.endDate ?? args.value.startDate;
        _tarikhMula = DateFormat('dd/MM/yyyy').format(startDate);
        _tarikhTamat = DateFormat('dd/MM/yyyy').format(endDate);

        _range = '$_tarikhMula - $_tarikhTamat';
        _days = endDate.difference(startDate).inDays + 1; // Inclusive range
        _totalPrice = _days * _ratePerDay;
      }
    });
  }

  void _showDateRangePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Tarikh'),
          content: Container(
            height: 300,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 0)),
                DateTime.now().add(const Duration(days: 0)),
              ),
              minDate: DateTime.now(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Validation Function
  bool _validateInputs() {
    return _selectedDewan != null &&
        _selectedTujuan != null &&
        _range.isNotEmpty;
  }

  Widget _buildDropdownRow(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Row(
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
                .map((String option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
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
            child: Text(value,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }

  // Function to show the bottom sheet
  void _showConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full screen scroll
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7, // Starts by covering half of the screen
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Maklumat Permohonan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildRow('Dewan / Padang:', _selectedDewan ?? ''),
                    _buildRow('Tarikh Mula:', _tarikhMula ?? ''),
                    _buildRow('Tarikh Tamat:', _tarikhTamat ?? ''),
                    _buildRow('Bilangan Hari:', '$_days Hari'),
                    _buildRow('Tujuan:', _selectedTujuan ?? ''),
                    _buildRow('Kadar Sewa / Hari (RM):',
                        'RM${_ratePerDay.toStringAsFixed(2)}'),
                    _buildRow('Jumlah Harga (RM):',
                        'RM${_totalPrice.toStringAsFixed(2)}'),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              // Simpan action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Simpan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Close the bottom sheet first
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('PERMOHONAN BERJAYA DIHANTAR'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior
                                      .floating, // Makes the snackbar float
                                  margin: EdgeInsets.only(
                                      bottom: 30,
                                      left: 20,
                                      right:
                                          20), // Position at the top with margin
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Hantar Permohonan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              _showCancelConfirmationDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Batal Permohonan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Tempahan Dewan',
          pageName2: '    Tempahan Dewan'),
      drawer: const CustomDrawer(),
      body: Container(
        color: Color.fromARGB(255, 235, 241, 253),
        child: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  _buildDropdownRow(
                      'Dewan / Padang:', _selectedDewan, _dewanOptions,
                      (String? value) {
                    setState(() {
                      _selectedDewan = value;
                    });
                  }),
                  const SizedBox(height: 16),
                  _buildDropdownRow('Tujuan:', _selectedTujuan, _tujuanOptions,
                      (String? value) {
                    setState(() {
                      _selectedTujuan = value;
                    });
                  }),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _dateRangeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tarikh',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    onTap: _showDateRangePicker,
                  ),
                  const SizedBox(height: 16),
                  const Text('Tarikh Tempahan:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SfDateRangePicker(
                    rangeSelectionColor:
                        const Color.fromARGB(255, 125, 133, 255),
                    endRangeSelectionColor: const Color.fromARGB(255, 0, 5, 76),
                    startRangeSelectionColor:
                        const Color.fromARGB(255, 0, 5, 76),
                    initialSelectedDate: DateTime.now(),
                    todayHighlightColor: Colors.green,
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 0)),
                      DateTime.now().add(const Duration(days: 0)),
                    ),
                    minDate: DateTime.now(),
                  ),
                  const SizedBox(height: 16),
                  _buildRow('Tarikh Dipilih:', _range),
                  const SizedBox(height: 16),
                  _buildRow('Bilangan Hari:', '$_days Hari'),
                  const SizedBox(height: 16),
                  _buildRow('Kadar Sewa / Hari (RM):', 'RM$_ratePerDay'),
                  const SizedBox(height: 16),
                  _buildRow('Jumlah Harga (RM):', 'RM$_totalPrice'),
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
          ],
        ),
      ),
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
