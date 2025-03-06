import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahandewan/daftardewan_page.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Daftarjanjitemupage extends StatefulWidget {
  const Daftarjanjitemupage({super.key});

  @override
  State<Daftarjanjitemupage> createState() => _DaftarjanjitemupageState();
}

class _DaftarjanjitemupageState extends State<Daftarjanjitemupage> {
  // This widget is the root of your application.

  final _formKey = GlobalKey<FormState>();
  DateTime? _tarikhMula;
  DateTime? _tarikhTamat;
  TimeOfDay? _masaMula;
  TimeOfDay? _masaTamat;
  final TextEditingController _keteranganController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Daftar Janjitemu',
          pageName2: '    Penutupan Slot Janji Temu',
        ),
        body: Container(
          color: Color.fromARGB(255, 235, 241, 253),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Maklumat Slot Janjitemu',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Tarikh Mula',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context, true),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _tarikhMula != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_tarikhMula!)
                                    : '',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sila pilih tarikh mula';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Tarikh Tamat',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context, false),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _tarikhTamat != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_tarikhTamat!)
                                    : '',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sila pilih tarikh tamat';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Masa Mula',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () => _selectTime(context, true),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _masaMula != null
                                    ? _masaMula!.format(context)
                                    : '',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sila pilih masa mula';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Masa Tamat',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () => _selectTime(context, false),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _masaTamat != null
                                    ? _masaTamat!.format(context)
                                    : '',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sila pilih masa tamat';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _keteranganController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                  labelText: 'Keterangan',
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sila masukkan keterangan';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.orange)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Save data
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Data disimpan')),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(1, 'Data', 'Data', 1200, 'Yusri'),
      Employee(2, 'Data', 'Data', 1200, 'Yusri'),
      Employee(3, 'Data', 'Data', 1200, 'Yusri'),
      Employee(4, 'Data', 'Data', 1200, 'Yusri'),
      Employee(5, 'Data', 'Data', 1200, 'Yusri'),
    ];
  }
}

class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary, this.pegawai);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;
  final String pegawai;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
              DataGridCell<String>(columnName: 'salary', value: e.pegawai),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
