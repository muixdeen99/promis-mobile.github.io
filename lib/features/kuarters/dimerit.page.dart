import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../tempahan/tempahangelanggang/custom_drawer.dart';
// ignore: depend_on_referenced_packages

class DimeritPage extends StatefulWidget {
  const DimeritPage({super.key});

  @override
  State<DimeritPage> createState() => _DimeritPageState();
}

class _DimeritPageState extends State<DimeritPage> {
  
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Semakan Dimerit',
          pageName2: 'Senarai Jadual Bertugas',
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: Center(
                  // Centers the Row within the available space
                  child: Column(children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            const Text(
                              '  Senarai Pelanggaran Syarat ',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // Handle long text
                            ),
                            const SizedBox(height: 40),
                            SfDataGrid(
                              gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                              highlightRowOnHover: true,
                              source: employeeDataSource,
                              columnWidthMode: ColumnWidthMode.fill,
                              columns: <GridColumn>[
                                GridColumn(
                                    columnName: 'id',
                                    label: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'No',
                                        ))),
                                GridColumn(
                                    columnName: 'name',
                                    label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child:
                                            const Text('No Siri Kesalahan'))),
                                GridColumn(
                                    columnName: 'designation',
                                    label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Jenis',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                GridColumn(
                                    columnName: 'salary',
                                    label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text('Mata Dimerit'))),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Jumlah Mata Keseluruhan:  ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // Handle long text
                              ),
                            ),
                            const SizedBox(height: 50),
                            Card(
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.warning, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text(
                                          'PERHATIAN',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                        children: [
                                          TextSpan(
                                            text: '• Jika mata merit melebihi ',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          TextSpan(
                                            text: '70 ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          TextSpan(
                                            text: 'mata',
                                          ),
                                          TextSpan(
                                              text:
                                                  ', surat amaran akan dikeluarkan.'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                        children: [
                                          TextSpan(
                                              text:
                                                  '• Jika mata merit melebihi '),
                                          TextSpan(
                                            text: '100 ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          TextSpan(
                                              text: 'mata, penghuni akan '),
                                          TextSpan(
                                            text: 'HILANG KELAYAKAN',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            
          ],
        ));
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
        1,
        'Data',
        'Data',
        1,
      ),
      Employee(
        2,
        'Data',
        'Data',
        1,
      ),
      Employee(
        3,
        'Data',
        'Data',
        1,
      ),
      Employee(
        4,
        'Data',
        'Data',
        1,
      ),
    ];
  }
}

class Employee {
  /// Creates the employee class with required details.
  Employee(
    this.id,
    this.name,
    this.designation,
    this.salary,
  );

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

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
