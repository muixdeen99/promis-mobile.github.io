import 'package:flutter/material.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TestpagePage extends StatefulWidget {
  const TestpagePage({super.key});

  @override
  State<TestpagePage> createState() => _TestpagePageState();
}

class _TestpagePageState extends State<TestpagePage> {
  
  final List<String> tujuan = [
    '  Tawaran',
    '  Keluar',
  ];

  String? selectedtujuan;

  String _range = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    // Show the date picker dialog
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
          DateTime.now(), // Default to current date if no date is selected
      firstDate: DateTime(2000), // Earliest date user can select
      lastDate: DateTime(2101), // Latest date user can select
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Store the selected date
      });
    }
  }

  late EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    // Initialize the data source
    _employeeDataSource = EmployeeDataSource(employeeData: _getEmployeeData());
  }

  List<Employee> _getEmployeeData() {
    return [
      Employee(1, 'John Doe', 'Manager', 5000, 'Pegawai 1'),
      Employee(2, 'Jane Smith', 'Developer', 4500, 'Pegawai 2'),
      Employee(3, 'Sam Wilson', 'Designer', 4000, null), // No Pegawai value
      Employee(4, 'Lucy Brown', 'Tester', 3500, null), // No Pegawai value
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: primaryColor,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 16.0), // Consistent padding
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align items to the start
                    children: [
                      const SizedBox(height: 8),
                   Stack(
                      children: [
                        // Main account icon
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const ProfileEditPage(); // Target page
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  // Create a fade-in effect
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: 0.0, end: 1.0)
                                      .chain(CurveTween(curve: curve));
                                  var opacityAnimation = animation.drive(tween);

                                  // Apply the FadeTransition
                                  return FadeTransition(
                                    opacity:
                                        opacityAnimation, // Apply the fade effect
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(
                                    milliseconds:
                                        500), // Adjust duration as needed
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        // Edit icon
                        Positioned(
                          bottom: 0, // Position at the bottom
                          right: 0, // Position at the right
                          child: Container(
                            height: 16, // Size of the edit icon
                            width: 16,
                            decoration: const BoxDecoration(
                              color: Colors.grey, // Background color
                              shape: BoxShape.circle, // Circular shape
                            ),
                            child: const Icon(
                              Icons.edit,
                              size:
                                  12, // Smaller icon size to fit inside the circle
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),
                      ],
                    ),

                      // const SizedBox(height: 8), // Spacing between icon and text
                      const Text(
                        'Selamat Datang,',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14, // Adjust the font size as needed
                        ),
                      ),
                      const Text(
                        'Muhammad Yusri',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14, // Adjust the font size as needed
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        '    Kuarters/',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12, // Adjust the font size as needed
                        ),
                      ),
                      const Text(
                        '    Janjitemu',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12, // Adjust the font size as needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.menu, color: Colors.white),
                    tooltip: 'Menu',
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              actions: <Widget>[
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  tooltip: 'Notifications',
                  onPressed: () {
                    // Handle the press
                  },
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Use a Container to control the height of the DrawerHeader
              Container(
                height: 60, // Adjust height to your preference
                color: primaryColor,
                child: const Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Laman Utama',
                    style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const LamanUtamaPage(); // Target page
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Create a fade-in effect
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: 0.0, end: 1.0)
                            .chain(CurveTween(curve: curve));
                        var opacityAnimation = animation.drive(tween);

                        // Apply the FadeTransition
                        return FadeTransition(
                          opacity: opacityAnimation, // Apply the fade effect
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(
                          milliseconds: 500), // Adjust duration as needed
                    ),
                  );
                },
              ),
              ExpansionTile(
                  title: const Text('E-KUARTERS',
                      style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                  children: [
                    ListTile(
                      title: const Text('Penawaran',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const KuartersPage(); // Target page
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Create a fade-in effect
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: 0.0, end: 1.0)
                                  .chain(CurveTween(curve: curve));
                              var opacityAnimation = animation.drive(tween);

                              // Apply the FadeTransition
                              return FadeTransition(
                                opacity:
                                    opacityAnimation, // Apply the fade effect
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                                milliseconds: 500), // Adjust duration as needed
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Penguatkuasa',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Penyelenggaraan',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                      onTap: () {},
                    ),
                  ]),

              ExpansionTile(
                  title: const Text('E-HARTANAH',
                      style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                  children: [
                    ListTile(
                      title: const Text('Rumah Peranginan',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const RumahPeranginanPage(); // Target page
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Create a fade-in effect
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: 0.0, end: 1.0)
                                  .chain(CurveTween(curve: curve));
                              var opacityAnimation = animation.drive(tween);

                              // Apply the FadeTransition
                              return FadeTransition(
                                opacity:
                                    opacityAnimation, // Apply the fade effect
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                                milliseconds: 500), // Adjust duration as needed
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Dewan dan Gelanggang',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const TempahanPage(); // Target page
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              // Create a fade-in effect
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: 0.0, end: 1.0)
                                  .chain(CurveTween(curve: curve));
                              var opacityAnimation = animation.drive(tween);

                              // Apply the FadeTransition
                              return FadeTransition(
                                opacity:
                                    opacityAnimation, // Apply the fade effect
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                                milliseconds: 500), // Adjust duration as needed
                          ),
                        );
                      },
                    ),
                  ]),

              ListTile(
                title: const Text('Log Keluar',
                    style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const LoginPage(); // Target page
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        // Create a fade-in effect
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: 0.0, end: 1.0)
                            .chain(CurveTween(curve: curve));
                        var opacityAnimation = animation.drive(tween);

                        // Apply the FadeTransition
                        return FadeTransition(
                          opacity: opacityAnimation, // Apply the fade effect
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(
                          milliseconds: 500), // Adjust duration as needed
                    ),
                  );
                },
              ),
              // ListTile(
              //   title: const Text('Ruang Komersial',
              //       style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
              //   onTap: () {},
              // ),
              // ListTile(
              //   title: const Text('Ruang Pejabat',
              //       style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
              //   onTap: () {},
              // ),
            ],
          ),
        ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          '  Tujuan',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(
                            width:
                                16), // Adds spacing between the label and dropdown
                        SizedBox(
                          width: 5000, // Sets the width of the dropdown
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SizedBox(
                              height: 40,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(8.0),
                                  isExpanded: true,
                                  hint: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      'Semakan',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 85, 85, 85),
                                      ),
                                    ),
                                  ),
                                  items: tujuan
                                      .map(
                                        (String item) =>
                                            DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 102, 102, 102),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: selectedtujuan,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedtujuan = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          '  Tarikh ',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis, // Handle long text
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height:
                                    40, // Set a fixed height for the container
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8), // Padding inside
                                decoration: BoxDecoration(
                                  color: Colors.grey[
                                      200], // Background color of the container
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                  border: Border.all(
                                      color: Colors.grey), // Optional border
                                ),
                                alignment: Alignment
                                    .centerLeft, // Align text to the left
                                child: Text(
                                  _selectedDate != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(_selectedDate!)
                                      : 'Pilih Tarikh', // Fallback if no date is selected
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 48, 48, 48),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle long text
                                ),
                              ),
                            ),
                            const SizedBox(
                                width:
                                    8), // Spacing between the container and the button
                            SizedBox(
                              width: 80, // Fixed width for the button
                              height: 40, // Fixed height for the button
                              child: ElevatedButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor, // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Rounded corners
                                  ),
                                ),
                                child: const Text(
                                  'Pilih',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '  Hasil ',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // Handle long text
                            ),
                            SfDataGrid(
                              
                              source: _employeeDataSource,
                              columnWidthMode: ColumnWidthMode.fill,
                             gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                              columns: <GridColumn>[
                                GridColumn(
                                  columnName: 'id',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('ID'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'name',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Name'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'designation',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Designation'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'salary',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Salary'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'pegawai',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Pegawai'),
                                  ),
                                ),
                              ],
                            ),
                                SfDataGrid(
                              source: _employeeDataSource,
                              columnWidthMode: ColumnWidthMode.fill,
                              gridLinesVisibility: GridLinesVisibility.both,
                              columns: <GridColumn>[
                                GridColumn(
                                  columnName: 'id',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('ID'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'name',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Name'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'designation',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Designation'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'salary',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Salary'),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'pegawai',
                                  label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Pegawai'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50)
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

  final int id;
  final String name;
  final String designation;
  final int salary;
  final String? pegawai; // Nullable for rows without Pegawai
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
              DataGridCell<String>(columnName: 'pegawai', value: e.pegawai),
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
          child: Text(e.value?.toString() ?? ''),
        );
      }).toList(),
    );
  }
}
