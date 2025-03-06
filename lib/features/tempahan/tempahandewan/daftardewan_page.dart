import 'package:flutter/material.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
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

  List<Map<String, dynamic>> _dewanOptions = [
    {'id': '1', 'keterangan': 'Dewan A'},
    {'id': '2', 'keterangan': 'Dewan B'},
    {'id': '3', 'keterangan': 'Padang C'},
  ];
  final List<String> _tujuanOptions = ['Majlis', 'Sukan', 'Persembahan'];
  final TextEditingController _dateRangeController = TextEditingController();
  bool _isLoading = true;
  List<dynamic> tarikhDewanData = [];

  @override
  void initState() {
    super.initState();
    _fetchTarikhData();
  }

  Future<void> _fetchTarikhData() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.dewanApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        '/mobile/permohonan/dewan',
      );
      print('Response1');

      if (response.statusCode == 200 && response.data['data'] != null) {
        print('Response2');
        List<Map<String, dynamic>> filteredData = [];
        for (var item in response.data['data']) {
          if (item['tarikhKelulusan'] != null) {
            DateTime tarikhMula =
                DateFormat('yyyy-MM-dd').parse(item['tarikhMula']);
            if (tarikhMula.isAfter(DateTime.now())) {
              filteredData.add({
                'tarikhMula': item['tarikhMula'],
                'tarikhTamat': item['tarikhTamat'],
                'bilHari': item['bilHari'],
              });
            }
          }
        }
        setState(() {
          tarikhDewanData = filteredData;
        });
        print('Response3');

        print('Data: $tarikhDewanData');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  void _showDateRangePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Tarikh'),
          content: SizedBox(
            height: 300,
            width: 400,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              minDate: DateTime.now(),
              monthViewSettings: DateRangePickerMonthViewSettings(
                specialDates: _getBlackoutDates(),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                specialDatesTextStyle: TextStyle(
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough,
                ),
                specialDatesDecoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
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

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        final startDate = args.value.startDate;
        final endDate = args.value.endDate ?? args.value.startDate;

        if (_hasBlackoutDates(startDate, endDate)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Berlaku pertindihan pada tarikh yang dipilih")),
          );

          // Reset selection
          _dateRangeController.text = "";
          _days = 0;
          _totalPrice = _days * _ratePerDay;
          return;
        }

        // If valid, update selection
        _tarikhMula = DateFormat('dd/MM/yyyy').format(startDate);
        _tarikhTamat = DateFormat('dd/MM/yyyy').format(endDate);
        _range = '$_tarikhMula - $_tarikhTamat';
        _days = endDate.difference(startDate).inDays + 1;
        _totalPrice = _days * _ratePerDay;
        _dateRangeController.text = _range;
      }
    });
  }

  bool _hasBlackoutDates(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    List<DateTime> blackoutDates = _getBlackoutDates();

    for (DateTime date = startDate;
        date.isBefore(endDate.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      if (blackoutDates.contains(date)) {
        return true; // If any blackout date is in range, return true
      }
    }
    return false;
  }

  List<DateTime> _getBlackoutDates() {
    List<DateTime> blackoutDates = [];
    for (var item in tarikhDewanData) {
      DateTime startDate = DateFormat('yyyy-MM-dd').parse(item['tarikhMula']);
      DateTime endDate = DateFormat('yyyy-MM-dd').parse(item['tarikhTamat']);
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        blackoutDates.add(startDate.add(Duration(days: i)));
      }
    }
    return blackoutDates;
  }

  Widget _buildDropdownRow(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
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
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(), // Show loading spinner
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          _buildDropdownRow(
                              'Dewan / Padang:',
                              _selectedDewan,
                              _dewanOptions
                                  .map((dewan) => dewan['keterangan'] as String)
                                  .toList(), (String? value) {
                            setState(() {
                              _selectedDewan = value;
                            });
                          }),
                          const SizedBox(height: 16),
                          _buildDropdownRow(
                              'Tujuan:', _selectedTujuan, _tujuanOptions,
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
                          const Divider(),
                          const SizedBox(height: 16),
                          _buildRow('Bilangan Hari:', '$_days Hari'),
                          const SizedBox(height: 16),
                          _buildRow(
                              'Kadar Sewa / Hari (RM):', 'RM$_ratePerDay'),
                          const SizedBox(height: 16),
                          _buildRow('Jumlah Harga (RM):', 'RM$_totalPrice'),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Add your "Simpan" button logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      255, 17, 54, 107), // Button color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  shape: StadiumBorder(),
                                ),
                                child: Text(
                                  'Simpan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your "Hantar" button logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green, // Button color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  shape: StadiumBorder(),
                                ),
                                child: Text(
                                  'Hantar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
