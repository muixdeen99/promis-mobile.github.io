import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/senaraiperanginan.page.dart';
import 'package:promis/features/rumahperanginan/tempahanrumahperanginan_page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// ignore: depend_on_referenced_packages

class TempahanEksekutifPage extends StatefulWidget {
  const TempahanEksekutifPage({super.key});

  @override
  State<TempahanEksekutifPage> createState() => _TempahanEksekutifPageState();
}

class _TempahanEksekutifPageState extends State<TempahanEksekutifPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProMIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyTempahanEksekutifPage(title: 'ProMIS'),
    );
  }
}

class MyTempahanEksekutifPage extends StatefulWidget {
  const MyTempahanEksekutifPage({super.key, required this.title});

  final String title;

  @override
  State<MyTempahanEksekutifPage> createState() =>
      _MyTempahanEksekutifPageState();
}

class _MyTempahanEksekutifPageState extends State<MyTempahanEksekutifPage> {
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
        pageName1: '    Rumah Peranginan',
        pageName2: '    Premier',
      ),
      drawer: CustomDrawer(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Senarai Rumah Peranginan Eksekutif ',
                                style: TextStyle(
                                  color:primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis, // Handle long text
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FadeIn(
                                        child: const SenaraiPeranginanPage()),
                                  ),
                                );
                              },
                              child: SfDataGrid(
                               gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                                source: employeeDataSource,
                                columnWidthMode: ColumnWidthMode.fill,
                                columns: <GridColumn>[
                                  GridColumn(
                                      maximumWidth: 80,
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
                                          child: const Text('Nama Peranginan'))),
                                  GridColumn(
                                      columnName: 'designation',
                                      label: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Tindakan',
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Senarai Rumah Peranginan Premier ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis, // Handle long text
                              ),
                            ),
                            const SizedBox(height: 10),
                            SfDataGrid(
                              gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                              source: employeeDataSource,
                              columnWidthMode: ColumnWidthMode.fill,
                              columns: <GridColumn>[
                                GridColumn(
                                    maximumWidth: 80,
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
                                        child: const Text('Nama Peranginan'))),
                                GridColumn(
                                    columnName: 'designation',
                                    label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Tindakan',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                              ],
                            ),
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
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const SenaraiPeranginanPage(); // Target page
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // Define the slide direction (e.g., from right to left)
                  const begin = Offset(
                      1.0, 0.0); // Start position (1.0, 0.0) is from the right
                  const end = Offset.zero; // End position is the center (0, 0)
                  const curve = Curves.easeInOut;

                  // Create the tween for the sliding animation
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  // Apply the SlideTransition
                  return SlideTransition(
                    position:
                        offsetAnimation, // Slide from the right to the center
                    child: child,
                  );
                },
                transitionDuration: const Duration(
                    milliseconds: 500), // Adjust duration as needed
              ),
            );
          },
          child: const Icon(Icons.arrow_forward_ios),
        ),
      ),
      Employee(
        2,
        'Data',
        GestureDetector(
              onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const SenaraiPeranginanPage(); // Target page
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // Define the slide direction (e.g., from right to left)
                  const begin = Offset(
                      1.0, 0.0); // Start position (1.0, 0.0) is from the right
                  const end = Offset.zero; // End position is the center (0, 0)
                  const curve = Curves.easeInOut;

                  // Create the tween for the sliding animation
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  // Apply the SlideTransition
                  return SlideTransition(
                    position:
                        offsetAnimation, // Slide from the right to the center
                    child: child,
                  );
                },
                transitionDuration: const Duration(
                    milliseconds: 500), // Adjust duration as needed
              ),
            );
          },
            child: const Icon(Icons.arrow_forward_ios)),
      ),
      Employee(
        3,
        'Data',
        GestureDetector(
              onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const SenaraiPeranginanPage(); // Target page
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // Define the slide direction (e.g., from right to left)
                  const begin = Offset(
                      1.0, 0.0); // Start position (1.0, 0.0) is from the right
                  const end = Offset.zero; // End position is the center (0, 0)
                  const curve = Curves.easeInOut;

                  // Create the tween for the sliding animation
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  // Apply the SlideTransition
                  return SlideTransition(
                    position:
                        offsetAnimation, // Slide from the right to the center
                    child: child,
                  );
                },
                transitionDuration: const Duration(
                    milliseconds: 500), // Adjust duration as needed
              ),
            );
          },
            child: const Icon(Icons.arrow_forward_ios)),
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
  );

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final Widget designation;

  /// Salary of an employee.
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
              DataGridCell<Widget>(
                  columnName: 'designation', value: e.designation),
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
        child: e.value is Widget
            ? e.value as Widget // Render the widget directly if it's a widget
            : Text(e.value.toString()),
      );
    }).toList());
  }
}
