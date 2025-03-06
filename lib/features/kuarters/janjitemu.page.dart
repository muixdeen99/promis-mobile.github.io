import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/daftarjanjitemu.page.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/kuarters/penawaran.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/tempahan/tempahandewan/daftardewan_page.dart';
import 'package:promis/shared/color.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:promis/shared/environment_config.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class JanjitemuPage extends StatefulWidget {
  const JanjitemuPage({super.key});

  @override
  State<JanjitemuPage> createState() => _JanjitemuPageState();
}

class _JanjitemuPageState extends State<JanjitemuPage> {
  final List<String> tujuan = [
    '  Tawaran',
    '  Keluar',
  ];

  String? userId;
  List<dynamic> tutupTemu = [];

  String? selectedtujuan;

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  String _range = '';

  Future<void> _loadUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      print('User ID: $userId');
      setState(() {
        this.userId = userId;
      });

      if (userId != null) {
        await _fetchTutupTemu(userId);
      }
    } catch (e) {
      print('Error loading user ID: $e');
    }
  }

  Future<void> _fetchTutupTemu(String userId) async {
    final apiService = DioApiService(
      createDio(EnvironmentConfig.baseUrl),
      EnvironmentConfig.kuartersApiUrl,
    );

    try {
      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/penutupan-janjitemu',
      );
      print('Response: ${response.data}'); // Print the entire response

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          tutupTemu = response.data['data'];
        });
        print('Data: $tutupTemu');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

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
  TextEditingController _tarikhMulaController = TextEditingController();
  TextEditingController _tarikhTamatController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _loadUserId();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          userName: 'Muhammad Yusri',
          pageName1: 'Penutupan Slot',
          pageName2: '    Janji Temu',
          showButton: true,
          buttonAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Daftarjanjitemupage(),
              ),
            );
          },
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
        body: Container(
          color: Color.fromARGB(255, 235, 241, 253),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.orange),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const Daftarjanjitemupage(); // Target page
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
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text('Daftar',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.blue, // Background color
                      // ),
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            Color.fromARGB(255, 17, 54, 107)),
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    'Tapis Carian',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _tarikhMulaController,
                                    decoration: InputDecoration(
                                      labelText: 'Tarikh Mula Janjitemu',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Pill shape
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          _tarikhMulaController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _tarikhTamatController,
                                    decoration: InputDecoration(
                                      labelText: 'Tarikh Tamat Janjitemu',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Pill shape
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          _tarikhTamatController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Tutup'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle filter action
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.blue),
                                        ),
                                        child: const Text(
                                          'Tapis',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.filter_list, color: Colors.white),
                      label: Text('Tapis',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.blue, // Background color
                      // ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      tutupTemu.isNotEmpty
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: tutupTemu.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  child: Card(
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    elevation: 5,
                                                    shadowColor: Colors.black,
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: [
                                                          Table(
                                                            columnWidths: const {
                                                              0: FlexColumnWidth(
                                                                  2),
                                                              1: FlexColumnWidth(
                                                                  3),
                                                            },
                                                            children: [
                                                              TableRow(
                                                                children: [
                                                                  const Text(
                                                                    'Tarikh  ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    '${tutupTemu[index]['tarikhMulaPenutupan']} - ${tutupTemu[index]['tarikhTamatPenutupan']}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              TableRow(
                                                                children: [
                                                                  const Text(
                                                                    'Masa ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    '${tutupTemu[index]['masaMulaPenutupan']} - ${tutupTemu[index]['masaTamatPenutupan']}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              TableRow(
                                                                children: [
                                                                  const Text(
                                                                    'Catatan ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    '${tutupTemu[index]['catatan']}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              TableRow(
                                                                children: [
                                                                  const Text(
                                                                    'Daftar Oleh ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    '${tutupTemu[index]['daftarOleh'] ?? '-'}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: Text('No data available'),
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 16.0, vertical: 10.0),
              //     child: Center(
              //       // Centers the Row within the available space
              //       child: Column(children: [
              //         const SizedBox(
              //           height: 30,
              //         ),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           mainAxisSize: MainAxisSize.min,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             const Text(
              //               '  Tujuan',
              //               style: TextStyle(
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w700,
              //                 color: primaryColor,
              //               ),
              //             ),
              //             const SizedBox(
              //                 width:
              //                     16), // Adds spacing between the label and dropdown
              //             SizedBox(
              //               width: 5000, // Sets the width of the dropdown
              //               child: DecoratedBox(
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: Colors.black,
              //                     width: 1.0,
              //                   ),
              //                   borderRadius: BorderRadius.circular(8.0),
              //                 ),
              //                 child: SizedBox(
              //                   height: 40,
              //                   child: DropdownButtonHideUnderline(
              //                     child: DropdownButton<String>(
              //                       borderRadius: BorderRadius.circular(8.0),
              //                       isExpanded: true,
              //                       hint: const Padding(
              //                         padding:
              //                             EdgeInsets.symmetric(horizontal: 8.0),
              //                         child: Text(
              //                           'Semakan',
              //                           style: TextStyle(
              //                             fontSize: 14,
              //                             fontWeight: FontWeight.bold,
              //                             color: Color.fromARGB(255, 85, 85, 85),
              //                           ),
              //                         ),
              //                       ),
              //                       items: tujuan
              //                           .map(
              //                             (String item) =>
              //                                 DropdownMenuItem<String>(
              //                               value: item,
              //                               child: Padding(
              //                                 padding: const EdgeInsets.all(8.0),
              //                                 child: Text(
              //                                   item,
              //                                   style: const TextStyle(
              //                                     fontSize: 14,
              //                                     fontWeight: FontWeight.bold,
              //                                     color: Color.fromARGB(
              //                                         255, 102, 102, 102),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                           )
              //                           .toList(),
              //                       value: selectedtujuan,
              //                       onChanged: (String? value) {
              //                         setState(() {
              //                           selectedtujuan = value;
              //                         });
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 30),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           mainAxisSize: MainAxisSize.min,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             const Text(
              //               '  Tarikh ',
              //               style: TextStyle(
              //                 color: primaryColor,
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //               overflow: TextOverflow.ellipsis, // Handle long text
              //             ),
              //             Row(
              //               children: [
              //                 Expanded(
              //                   child: Container(
              //                     height:
              //                         40, // Set a fixed height for the container
              //                     padding: const EdgeInsets.symmetric(
              //                         horizontal: 8), // Padding inside
              //                     decoration: BoxDecoration(
              //                       color: Colors.black[
              //                           200], // Background color of the container
              //                       borderRadius: BorderRadius.circular(
              //                           8), // Rounded corners
              //                       border: Border.all(
              //                           color: Colors.black), // Optional border
              //                     ),
              //                     alignment: Alignment
              //                         .centerLeft, // Align text to the left
              //                     child: Text(
              //                       _selectedDate != null
              //                           ? DateFormat('dd/MM/yyyy')
              //                               .format(_selectedDate!)
              //                           : 'Pilih Tarikh', // Fallback if no date is selected
              //                       style: const TextStyle(
              //                         color: Color.fromARGB(255, 48, 48, 48),
              //                         fontSize: 15,
              //                         fontWeight: FontWeight.w700,
              //                       ),
              //                       overflow:
              //                           TextOverflow.ellipsis, // Handle long text
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                     width:
              //                         8), // Spacing between the container and the button
              //                 SizedBox(
              //                   width: 80, // Fixed width for the button
              //                   height: 40, // Fixed height for the button
              //                   child: ElevatedButton(
              //                     onPressed: () {
              //                       _selectDate(context);
              //                     },
              //                     style: ElevatedButton.styleFrom(
              //                       backgroundColor: primaryColor, // Button color
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(
              //                             8), // Rounded corners
              //                       ),
              //                     ),
              //                     child: const Text(
              //                       'Pilih',
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ]),
              //     ),
              //   ),
              // ),
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
