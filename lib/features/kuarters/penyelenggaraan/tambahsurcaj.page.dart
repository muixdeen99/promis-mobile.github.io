import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TambahSurcajpage extends StatefulWidget {
  const TambahSurcajpage({super.key});

  @override
  State<TambahSurcajpage> createState() => _TambahSurcajpageState();
}

class _TambahSurcajpageState extends State<TambahSurcajpage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _tarikhMula;
  DateTime? _tarikhTamat;
  TimeOfDay? _masaMula;
  TimeOfDay? _masaTamat;
  final TextEditingController _keteranganController = TextEditingController();
  String? _selectedRadio;
  String? _selectedBukuJKK;
  String? _selectedBahagian;
  String? _selectedSubBahagian;
  String? _selectedKategori;
  String? _selectedSubKategori;
  String? _selectedJenis;
  // String? _selectedRuang;
  String? _selectedTambahanPeratusanLokasi;
  String? _selectedHalangan;
  bool _isSurcajSelected = false;
  bool _isJKKSelected = false;
  bool _isSelectAllRuang = false;
  bool _isSelectAllPilihanJKK = false;

  List<Map<String, dynamic>> _ruangList = [];
  Map<String, bool> _selectedRuang = {};

  @override
  void initState() {
    super.initState();
    _fetchRuang();
  }

  Future<void> _fetchRuang() async {
    const String apiUrl =
        'https://gerbang.lokal.my/api/kod/v1/jenis-ruang-senggara?flagAktif=true&authId=970520385221';
    try {
      final response = await Dio().get(apiUrl);
      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          _ruangList = List<Map<String, dynamic>>.from(response.data['data']);
          _selectedRuang = {for (var ruang in _ruangList) ruang['id']: false};
        });
      }
    } catch (e) {
      print('Error fetching ruang: $e');
    }
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      _isSelectAllRuang = value ?? false;
      _selectedRuang.updateAll((key, val) => _isSelectAllRuang);
    });
  }

  void _toggleRuang(String id, bool? value) {
    setState(() {
      _selectedRuang[id] = value ?? false;
      _isSelectAllRuang = _selectedRuang.values.every((val) => val);
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Limit to past dates up to today
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _tarikhMula = picked;
        } else {
          _tarikhTamat = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _masaMula = picked;
        } else {
          _masaTamat = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: 'Tambah Surcaj',
        pageName2: 'Penutupan Slot Janji Temu',
      ),
      body: Container(
        color: Color.fromARGB(255, 235, 241, 253),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MAKLUMAT SURCAJ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedRadio == 'JKK'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedRadio = 'JKK';
                            // _fetchBukuJKK(idJenisJkk: _selectedRadio);
                          });
                        },
                        child: const Text('JADUAL KADAR KERJA',style: TextStyle(color: Colors.white),),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedRadio == 'FR'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedRadio = 'FR';
                            // _fetchBukuJKK(idJenisJkk: _selectedRadio);
                          });
                        },
                        child: const Text('FAIR RATE',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'BUKU JKK',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedBukuJKK,
                    items: ['JADUAL KADAR KERJA 2023', 'JADUAL KADAR KERJA 2024']
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBukuJKK = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Bahagian',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedBahagian,
                    items: ['3 - BAHAGIAN 3', '4 - BAHAGIAN 4']
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBahagian = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Sub Bahagian',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedSubBahagian,
                    items:
                        ['Sub Bahagian 1', 'Sub Bahagian 2', 'Sub Bahagian 3']
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSubBahagian = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedKategori,
                    items: ['Kategori 1', 'Kategori 2', 'Kategori 3']
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedKategori = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Sub Kategori',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedSubKategori,
                    items:
                        ['Sub Kategori 1', 'Sub Kategori 2', 'Sub Kategori 3']
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSubKategori = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Jenis',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedJenis,
                    items: ['Jenis 1', 'Jenis 2', 'Jenis 3']
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedJenis = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Harga (RM)',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 1,
                  ),
                  Text(
                    'RUANG',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: _ruangList.map((ruang) {
                        return CheckboxListTile(
                          title: Text(ruang['keterangan']),
                          value: _selectedRuang[ruang['id']],
                          onChanged: (value) =>
                              _toggleRuang(ruang['id'], value),
                        );
                      }).toList(),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'KUANTITI',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Tambahan Peratusan Lokasi',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedTambahanPeratusanLokasi,
                    items: ['Tambahan 1', 'Tambahan 2', 'Tambahan 3']
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTambahanPeratusanLokasi = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'HALANGAN',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedHalangan,
                    items: ['Halangan 1', 'Halangan 2', 'Halangan 3']
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedHalangan = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _keteranganController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'CATATAN OLEH BPH',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 1,
                  ),
                  Text(
                    'PILIHAN BPH',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('SURCAJ'),
                    value: _isSurcajSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        _isSurcajSelected = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('JKK'),
                    value: _isJKKSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        _isJKKSelected = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Select All'),
                    value: _isSelectAllPilihanJKK,
                    onChanged: (bool? value) {
                      setState(() {
                        _isSelectAllPilihanJKK = value!;
                        _isSurcajSelected = value!;
                        _isJKKSelected = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 17, 54, 107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text('SIMPAN'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
