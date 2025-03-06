import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/rumahperanginan/bayarantempahan_page.dart';
import 'package:promis/features/rumahperanginan/tempahanrumahperanginan_page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class SenaraiPeranginanPage extends StatefulWidget {
  const SenaraiPeranginanPage({super.key});

  @override
  State<SenaraiPeranginanPage> createState() => _SenaraiPeranginanPageState();
}

class _SenaraiPeranginanPageState extends State<SenaraiPeranginanPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProMIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySenaraiPeranginanPage(title: 'ProMIS'),
    );
  }
}

class MySenaraiPeranginanPage extends StatefulWidget {
  const MySenaraiPeranginanPage({super.key, required this.title});

  final String title;

  @override
  State<MySenaraiPeranginanPage> createState() => _MySenaraiPeranginanPageState();
}

class _MySenaraiPeranginanPageState extends State<MySenaraiPeranginanPage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  final TextEditingController _tarikhMasukController = TextEditingController();
  final TextEditingController _tarikhKeluarController = TextEditingController();

  int? _bilanganUnit = 1;
  int? _bilanganDewasa = 1;
  int? _bilanganKanakKanak = 1;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees, onActionPressed: _showApplicationDetails);
  }

  void _showApplicationDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Maklumat Permohonan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildDateInput('Tarikh Masuk', _tarikhMasukController),
              _buildDateInput('Tarikh Keluar', _tarikhKeluarController),
              _buildDropdown('Bilangan Unit', _bilanganUnit, 1, 4, (value) => setState(() => _bilanganUnit = value)),
              _buildDropdown('Bilangan Dewasa', _bilanganDewasa, 1, 15, (value) => setState(() => _bilanganDewasa = value)),
              _buildDropdown('Bilangan Kanak Kanak', _bilanganKanakKanak, 1, 15, (value) => setState(() => _bilanganKanakKanak = value)),
              Center(
              child: ElevatedButton(
                onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BayarantempahanPage()),
              );
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
            const SizedBox(height: 20),
            ],
          ),
        ),
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

  Widget _buildDropdown(String label, int? currentValue, int min, int max, ValueChanged<int?>? onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: currentValue,
          onChanged: onChanged,
          items: List.generate(
            max - min + 1,
            (index) => DropdownMenuItem(
              value: min + index,
              child: Text('${min + index}'),
            ),
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        userName: 'Muhammad Yusri',
        pageName1: '    Rumah Peranginan',
        pageName2: '    Tempahan Eksekutif / Premier',
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfDataGrid(
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              source: employeeDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'id',
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('No'),
                  ),
                ),
                GridColumn(
                  columnName: 'name',
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Jenis Unit'),
                  ),
                ),
                GridColumn(
                  columnName: 'designation',
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Kadar Sewa'),
                  ),
                ),
                GridColumn(
                  columnName: 'action',
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('Tindakan'),
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
                        return const TempahanRumahPeranginanPage();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(-1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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

  List<Employee> getEmployeeData() {
    return [
      Employee(1, 'Unit A', 'RM100'),
      Employee(2, 'Unit B', 'RM100'),
      Employee(3, 'Unit C', 'RM100'),
      Employee(4, 'Unit D', 'RM100'),
    ];
  }
}

class Employee {
  Employee(this.id, this.name, this.designation);

  final int id;
  final String name;
  final String designation;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employeeData, required this.onActionPressed}) {
    _employeeData = employeeData.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(columnName: 'designation', value: e.designation),
      DataGridCell<String>(columnName: 'action', value: ''),
    ])).toList();
  }

  final VoidCallback onActionPressed;
  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'action') {
          return IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: onActionPressed,
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }
}
