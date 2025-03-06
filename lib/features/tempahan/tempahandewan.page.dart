// import 'package:flutter/material.dart';
// import 'package:promis/features/kuarters/kuarters.page.dart';
// import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
// import 'package:promis/features/login/login.page.dart';
// import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
// import 'package:promis/features/tempahan/tempahan.page.dart';
// import 'package:promis/shared/color.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';

// class TempahanDewanPage extends StatefulWidget {
//   const TempahanDewanPage({super.key});

//   @override
//   State<TempahanDewanPage> createState() => _TempahanDewanPageState();
// }

// class _TempahanDewanPageState extends State<TempahanDewanPage> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ProMIS',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyTempahanDewanPage(title: 'ProMIS'),
//     );
//   }
// }

// class MyTempahanDewanPage extends StatefulWidget {
//   const MyTempahanDewanPage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyTempahanDewanPage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyTempahanDewanPage> {
//   String _range = '';

//   final List<String> topRowTexts = [
//     'No. Tempahan',
//     'Nama Dewan',
//     'Tarikh Tempahan',
//     'Status Permohonan',
//     'Status Bayaran',
//   ];

//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     setState(() {
//       if (args.value is PickerDateRange) {
//         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
//             // ignore: lines_longer_than_80_chars
//             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//       }
//     });
//   }

//   final List<String> statusbayaran = [
//     'Belum Bayar',
//     'Sudah Bayar',
//   ];
//   final List<String> statuspermohonan = [
//     'Diterima',
//     'Ditolak',
//   ];
//   String? selectedValue;
//   String? selectedValueRight;

//   DateTime? _selectedDate;

//   // Function to show date picker dialog
//   Future<void> _selectDate(BuildContext context) async {
//     // Show the date picker dialog
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ??
//           DateTime.now(), // Default to current date if no date is selected
//       firstDate: DateTime(2000), // Earliest date user can select
//       lastDate: DateTime(2101), // Latest date user can select
//     );

//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked; // Store the selected date
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(200.0),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: primaryColor,
//             flexibleSpace:  Padding(
//               padding:
//                   EdgeInsets.only(top: 40.0, left: 16.0), // Consistent padding
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start, // Align items to the start
//                   children: [
//                     SizedBox(height: 8),
//                    Stack(
//                         children: [
//                           // Main account icon
//                           const Icon(
//                             Icons.account_circle,
//                             size: 40,
//                             color: Colors.white,
//                           ),
//                           // Edit icon
//                           Positioned(
//                             bottom: 0, // Position at the bottom
//                             right: 0, // Position at the right
//                             child: GestureDetector(
//                               onTap: () {
//                                 // Handle edit icon click
//                                 print("Edit icon clicked!");
//                               },
//                               child: Container(
//                                 height: 16, // Size of the edit icon
//                                 width: 16,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.grey, // Background color
//                                   shape: BoxShape.circle, // Circular shape
//                                 ),
//                                 child: const Icon(
//                                   Icons.edit,
//                                   size:
//                                       12, // Smaller icon size to fit inside the circle
//                                   color: Colors.white, // Icon color
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     // const SizedBox(height: 8), // Spacing between icon and text
//                     Text(
//                       'Selamat Datang,',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14, // Adjust the font size as needed
//                       ),
//                     ),
//                     Text(
//                       'Muhammad Yusri',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14, // Adjust the font size as needed
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       '    Dewan dan Gelanggang/',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12, // Adjust the font size as needed
//                       ),
//                     ),
//                     Text(
//                       '    Tempahan Dewan',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12, // Adjust the font size as needed
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             leading: Builder(
//               builder: (context) {
//                 return IconButton(
//                   iconSize: 30,
//                   icon: const Icon(Icons.menu, color: Colors.white),
//                   tooltip: 'Menu',
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                 );
//               },
//             ),
//             actions: <Widget>[
//               IconButton(
//                 iconSize: 30,
//                 icon: const Icon(Icons.notifications, color: Colors.white),
//                 tooltip: 'Notifications',
//                 onPressed: () {
//                   // Handle the press
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//      drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // Use a Container to control the height of the DrawerHeader
//             Container(
//               height: 60, // Adjust height to your preference
//               color: primaryColor,
//               child: const Center(
//                 child: Text(
//                   'Menu',
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//             ListTile(
//               title: const Text('Laman Utama',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {
//                 Navigator.of(context).push(
//                   PageRouteBuilder(
//                     pageBuilder: (context, animation, secondaryAnimation) {
//                       return const LamanUtamaPage(); // Target page
//                     },
//                     transitionsBuilder:
//                         (context, animation, secondaryAnimation, child) {
//                       // Create a fade-in effect
//                       const curve = Curves.easeInOut;
//                       var tween = Tween(begin: 0.0, end: 1.0)
//                           .chain(CurveTween(curve: curve));
//                       var opacityAnimation = animation.drive(tween);

//                       // Apply the FadeTransition
//                       return FadeTransition(
//                         opacity: opacityAnimation, // Apply the fade effect
//                         child: child,
//                       );
//                     },
//                     transitionDuration: const Duration(
//                         milliseconds: 500), // Adjust duration as needed
//                   ),
//                 );
//               },
//             ),
//             ExpansionTile(
//                 title: const Text('E-KUARTERS',
//                     style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//                 children: [
//                   ListTile(
//                     title: const Text('Penawaran',
//                         style:
//                             TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         PageRouteBuilder(
//                           pageBuilder:
//                               (context, animation, secondaryAnimation) {
//                             return const KuartersPage(); // Target page
//                           },
//                           transitionsBuilder:
//                               (context, animation, secondaryAnimation, child) {
//                             // Create a fade-in effect
//                             const curve = Curves.easeInOut;
//                             var tween = Tween(begin: 0.0, end: 1.0)
//                                 .chain(CurveTween(curve: curve));
//                             var opacityAnimation = animation.drive(tween);

//                             // Apply the FadeTransition
//                             return FadeTransition(
//                               opacity:
//                                   opacityAnimation, // Apply the fade effect
//                               child: child,
//                             );
//                           },
//                           transitionDuration: const Duration(
//                               milliseconds: 500), // Adjust duration as needed
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     title: const Text('Penguatkuasa',
//                         style:
//                             TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     title: const Text('Penyelenggaraan',
//                         style:
//                             TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//                     onTap: () {},
//                   ),
//                 ]),

//             ExpansionTile(
//                 title: const Text('E-HARTANAH',
//                     style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//                 children: [
//                   ListTile(
//                     title: const Text('Rumah Peranginan',
//                         style:
//                             TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         PageRouteBuilder(
//                           pageBuilder:
//                               (context, animation, secondaryAnimation) {
//                             return const RumahPeranginanPage(); // Target page
//                           },
//                           transitionsBuilder:
//                               (context, animation, secondaryAnimation, child) {
//                             // Create a fade-in effect
//                             const curve = Curves.easeInOut;
//                             var tween = Tween(begin: 0.0, end: 1.0)
//                                 .chain(CurveTween(curve: curve));
//                             var opacityAnimation = animation.drive(tween);

//                             // Apply the FadeTransition
//                             return FadeTransition(
//                               opacity:
//                                   opacityAnimation, // Apply the fade effect
//                               child: child,
//                             );
//                           },
//                           transitionDuration: const Duration(
//                               milliseconds: 500), // Adjust duration as needed
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     title: const Text('Dewan dan Gelanggang',
//                         style:
//                             TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         PageRouteBuilder(
//                           pageBuilder:
//                               (context, animation, secondaryAnimation) {
//                             return const TempahanPage(); // Target page
//                           },
//                           transitionsBuilder:
//                               (context, animation, secondaryAnimation, child) {
//                             // Create a fade-in effect
//                             const curve = Curves.easeInOut;
//                             var tween = Tween(begin: 0.0, end: 1.0)
//                                 .chain(CurveTween(curve: curve));
//                             var opacityAnimation = animation.drive(tween);

//                             // Apply the FadeTransition
//                             return FadeTransition(
//                               opacity:
//                                   opacityAnimation, // Apply the fade effect
//                               child: child,
//                             );
//                           },
//                           transitionDuration: const Duration(
//                               milliseconds: 500), // Adjust duration as needed
//                         ),
//                       );
//                     },
//                   ),
//                 ]),

//             ListTile(
//               title: const Text('Log Keluar',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {
//                 Navigator.of(context).push(
//                   PageRouteBuilder(
//                     pageBuilder: (context, animation, secondaryAnimation) {
//                       return const LoginPage(); // Target page
//                     },
//                     transitionsBuilder:
//                         (context, animation, secondaryAnimation, child) {
//                       // Create a fade-in effect
//                       const curve = Curves.easeInOut;
//                       var tween = Tween(begin: 0.0, end: 1.0)
//                           .chain(CurveTween(curve: curve));
//                       var opacityAnimation = animation.drive(tween);

//                       // Apply the FadeTransition
//                       return FadeTransition(
//                         opacity: opacityAnimation, // Apply the fade effect
//                         child: child,
//                       );
//                     },
//                     transitionDuration: const Duration(
//                         milliseconds: 500), // Adjust duration as needed
//                   ),
//                 );
//               },
//             ),
//             // ListTile(
//             //   title: const Text('Ruang Komersial',
//             //       style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//             //   onTap: () {},
//             // ),
//             // ListTile(
//             //   title: const Text('Ruang Pejabat',
//             //       style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//             //   onTap: () {},
//             // ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 20.0), // Adjust padding as needed
//                 child: Column(
//                   children: <Widget>[
//                     const SizedBox(height: 30),
//                     Align(
//                       alignment: Alignment
//                           .centerLeft, // Aligns the DropdownButton to the left
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment
//                             .spaceBetween, // Evenly space the dropdowns
//                         children: [
//                           Flexible(
//                             child: Column(
//                               children: [
//                                 const Text(
//                                   'Status Pembayaran',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: primaryColor,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Container(
//                                   width:
//                                       150, // Adjust the width for the dropdown
//                                   height: 40, // Adjust the height if needed
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.grey, // Outline color
//                                       width: 1.5, // Outline width
//                                     ),
//                                     borderRadius: BorderRadius.circular(
//                                         8), // Rounded corners
//                                   ),
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton<String>(
//                                       focusColor: Colors.white,
//                                       isExpanded: true,
//                                       hint: const Row(
//                                         children: [
//                                           SizedBox(
//                                             width: 4,
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               'Pilih Status',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color.fromARGB(
//                                                     255, 85, 85, 85),
//                                               ),
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       items: statusbayaran
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color.fromARGB(
//                                                         255, 102, 102, 102),
//                                                   ),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ))
//                                           .toList(),
//                                       value: selectedValue,
//                                       onChanged: (String? value) {
//                                         setState(() {
//                                           selectedValue = value;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Flexible(
//                             child: Column(
//                               children: [
//                                 const Text(
//                                   'Status Permohonan',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: primaryColor,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Container(
//                                   width:
//                                       150, // Adjust the width for the dropdown
//                                   height: 40, // Adjust the height if needed
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.grey, // Outline color
//                                       width: 1.5, // Outline width
//                                     ),
//                                     borderRadius: BorderRadius.circular(
//                                         8), // Rounded corners
//                                   ),
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton<String>(
//                                       focusColor: Colors.white,
//                                       isExpanded: true,
//                                       hint: const Row(
//                                         children: [
//                                           SizedBox(
//                                             width: 4,
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               'Pilih Status',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color.fromARGB(
//                                                     255, 85, 85, 85),
//                                               ),
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       items: statuspermohonan
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color.fromARGB(
//                                                         255, 102, 102, 102),
//                                                   ),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ))
//                                           .toList(),
//                                       value: selectedValueRight,
//                                       onChanged: (String? value) {
//                                         setState(() {
//                                           selectedValueRight = value;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     Container(height: 50),

//                     SfDateRangePicker(
//                       // selectionColor: Color.fromARGB(255, 0, 5, 76),
//                       rangeSelectionColor:
//                           const Color.fromARGB(255, 125, 133, 255),
//                       endRangeSelectionColor:
//                           const Color.fromARGB(255, 0, 5, 76),
//                       startRangeSelectionColor:
//                           const Color.fromARGB(255, 0, 5, 76),

//                       initialSelectedDate: DateTime.now(),
//                       initialSelectedRanges: [
//                         PickerDateRange(DateTime.now(), DateTime.now())
//                       ],
//                       todayHighlightColor: Colors.green,
//                       onSelectionChanged: _onSelectionChanged,
//                       selectionMode: DateRangePickerSelectionMode.range,
//                       initialSelectedRange: PickerDateRange(
//                           DateTime.now().subtract(const Duration(days: 0)),
//                           DateTime.now().add(const Duration(days: 0))),
//                     ),

//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         const Text(
//                           '  Tarikh ',
//                           style: TextStyle(
//                             color: primaryColor,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                           ),
//                           overflow: TextOverflow.ellipsis, // Handle long text
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 height:
//                                     40, // Set a fixed height for the container
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8), // Padding inside
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[
//                                       200], // Background color of the container
//                                   borderRadius: BorderRadius.circular(
//                                       8), // Rounded corners
//                                   border: Border.all(
//                                       color: Colors.grey), // Optional border
//                                 ),
//                                 alignment: Alignment
//                                     .centerLeft, // Align text to the left
//                                 child: Text(
//                                   _range,
//                                   style: const TextStyle(
//                                     color: Color.fromARGB(255, 48, 48, 48),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                   overflow:
//                                       TextOverflow.ellipsis, // Handle long text
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                                 width:
//                                     8), // Spacing between the container and the button
//                             SizedBox(
//                               width: 80, // Fixed width for the button
//                               height: 40, // Fixed height for the button
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   // Button action
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: primaryColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         8), // Rounded corners
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Cari',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 30),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: List.generate(
//                             6, // 6 rows
//                             (rowIndex) => Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: List.generate(
//                                 5, // 5 containers per row
//                                 (colIndex) {
//                                   bool isTopRow = rowIndex == 0;
//                                   return Flexible(
//                                       flex: 1,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: Container(
//                                           height:
//                                               30, // Set a fixed height for all containers
//                                           decoration: BoxDecoration(
//                                             color: isTopRow
//                                                 ? primaryColor
//                                                 : Colors.grey[
//                                                     300], // Dark blue for the top row
//                                             borderRadius: BorderRadius.circular(
//                                                 8), // Rounded corners
//                                           ),
//                                           alignment: Alignment.center,
//                                           child: LayoutBuilder(
//                                             builder: (context, constraints) {
//                                               // Calculate the font size dynamically
//                                               double fontSize =
//                                                   constraints.maxWidth * 0.1;

//                                               // Ensure font size is not too small or too large
//                                               fontSize =
//                                                   fontSize < 10 ? 10 : fontSize;
//                                               fontSize =
//                                                   fontSize > 14 ? 14 : fontSize;

//                                               return Text(
//                                                 isTopRow
//                                                     ? topRowTexts[
//                                                         colIndex] // Custom text for top row
//                                                     : 'Data${rowIndex + 1}', // Dynamic text for other rows
//                                                 style: TextStyle(
//                                                   color: isTopRow
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize:
//                                                       fontSize, // Dynamic font size
//                                                 ),
//                                                 overflow: TextOverflow
//                                                     .ellipsis, // Handle overflow
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ));
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 30),

//                     // Staff ID TextField
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 2,
//             left: 2,
//             child: SizedBox(
//               height: 40,
//               width: 50,
//               child: FloatingActionButton(
//                 elevation: 0,
//                 hoverElevation: 0,
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.transparent,
//                 splashColor: Colors.transparent,
//                 focusColor: Colors.transparent,
//                 highlightElevation: 0,
//                 hoverColor: Colors.transparent,
//                 mini: true, // Optional: Makes the button small
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation, secondaryAnimation) {
//                         return const TempahanPage(); // Target page
//                       },
//                       transitionsBuilder:
//                           (context, animation, secondaryAnimation, child) {
//                         // Define the slide direction (e.g., from left to right)
//                         const begin = Offset(-1.0,
//                             0.0); // Start position (-1.0, 0.0) is from the left
//                         const end =
//                             Offset.zero; // End position is the center (0, 0)
//                         const curve = Curves.easeInOut;

//                         // Create the tween for the sliding animation
//                         var tween = Tween(begin: begin, end: end)
//                             .chain(CurveTween(curve: curve));
//                         var offsetAnimation = animation.drive(tween);

//                         // Apply the SlideTransition
//                         return SlideTransition(
//                           position:
//                               offsetAnimation, // Slide from the left to the center
//                           child: child,
//                         );
//                       },
//                       transitionDuration: const Duration(
//                           milliseconds: 500), // Adjust duration as needed
//                     ),
//                   );
//                 },

//                 child: const Text(
//                   'Back',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 0, 5, 76),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// ///////////////////////////////////////////////////////////////////////////////////////
// ///
// // import 'package:animate_do/animate_do.dart';
// // import 'package:flutter/material.dart';
// // import 'package:promis/features/homepage/homepape.page.dart';
// // import 'package:promis/features/tempahan/tempahan.page.dart';
// // import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// // // ignore: depend_on_referenced_packages
// // import 'package:intl/intl.dart';

// // class TempahanDewanPage extends StatefulWidget {
// //   const TempahanDewanPage({super.key});

// //   @override
// //   State<TempahanDewanPage> createState() => _TempahanDewanPageState();
// // }

// // class _TempahanDewanPageState extends State<TempahanDewanPage> {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'ProMIS',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const MyTempahanDewanPage(title: 'ProMIS'),
// //     );
// //   }
// // }

// // class MyTempahanDewanPage extends StatefulWidget {
// //   const MyTempahanDewanPage({super.key, required this.title});

// //   final String title;

// //   @override
// //   State<MyTempahanDewanPage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyTempahanDewanPage> {
 
// //   String _range = '';
  

// //   final List<String> topRowTexts = [
// //     'No. Tempahan',
// //     'Nama Dewan',
// //     'Tarikh Tempahan',
// //     'Status Permohonan',
// //     'Status Bayaran',
// //   ];

  

// //   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
// //     setState(() {
// //       if (args.value is PickerDateRange) {
// //         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
// //             // ignore: lines_longer_than_80_chars
// //             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
// //       } 
// //     });
// //   }

// //   final List<String> statusbayaran = [
// //     'Belum Bayar',
// //     'Sudah Bayar',
// //   ];
// //   final List<String> statuspermohonan = [
// //     'Diterima',
// //     'Ditolak',
// //   ];
// //   String? selectedValue;
// //   String? selectedValueRight;


// //  DateTime? _selectedDate;
// //  Future<void> _showDatePicker() async {
// //     await showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return Dialog(
// //           child: SfDateRangePicker(
// //                   // selectionColor: Color.fromARGB(255, 0, 5, 76),
// //                   rangeSelectionColor: const Color.fromARGB(255, 125, 133, 255),
// //                   endRangeSelectionColor: const Color.fromARGB(255, 0, 5, 76),
// //                   startRangeSelectionColor: const Color.fromARGB(255, 0, 5, 76),

// //                   initialSelectedDate: DateTime.now(),
// //                   initialSelectedRanges: [
// //                     PickerDateRange(DateTime.now(), DateTime.now())
// //                   ],
// //                   todayHighlightColor: Colors.green,
// //                   onSelectionChanged: _onSelectionChanged,
// //                   selectionMode: DateRangePickerSelectionMode.range,
// //                   initialSelectedRange: PickerDateRange(
// //                       DateTime.now().subtract(const Duration(days: 0)),
// //                       DateTime.now().add(const Duration(days: 0))),
// //                 ),
// //         );
// //       },
// //     );
// //   }
// //   // Function to show date picker dialog
// //   // Future<void> _selectDate(BuildContext context) async {
// //   //   // Show the date picker dialog
// //   //   final DateTime? picked = await showDatePicker(
// //   //     context: context,
// //   //     initialDate: _selectedDate ?? DateTime.now(), // Default to current date if no date is selected
// //   //     firstDate: DateTime(2000), // Earliest date user can select
// //   //     lastDate: DateTime(2101), // Latest date user can select
// //   //   );

// //   //   if (picked != null && picked != _selectedDate) {
// //   //     setState(() {
// //   //       _selectedDate = picked; // Store the selected date
// //   //     });
// //   //   }
// //   // }


  
// //   @override
// //   Widget build(BuildContext context) {
    
// //     return Scaffold(
// //       appBar: AppBar(
// //         automaticallyImplyLeading: false,
// //         backgroundColor: const Color.fromARGB(255, 0, 5, 76),
// //         centerTitle: true,
// //         title: const Text(
// //           'Tempahan Dewan',
// //           textAlign: TextAlign.center,
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         leading: Builder(
// //           builder: (context) {
// //             return IconButton(
// //               iconSize: 30,
// //               icon: const Icon(Icons.menu, color: Colors.white),
// //               tooltip: 'Menu',
// //               onPressed: () {
// //                 Scaffold.of(context).openDrawer();
// //               },
// //             );
// //           },
// //         ),
// //         actions: <Widget>[
// //           IconButton(
// //             iconSize: 30,
// //             icon: const Icon(Icons.notifications, color: Colors.white),
// //             tooltip: 'Notifications',
// //            onPressed: () {
// //               Navigator.of(context).push(
// //                 MaterialPageRoute(
// //                   builder: (context) => FadeIn(child: const TempahanPage()),
// //                 ),
// //               );
// //               // handle the press
// //             },
// //           ),
// //         ],
// //       ),
// //       drawer: Drawer(
// //         child: ListView(
// //           padding: EdgeInsets.zero,
// //           children: [
// //             // Use a Container to control the height of the DrawerHeader
// //             Container(
// //               height: 60, // Adjust height to your preference
// //               color: const Color.fromARGB(255, 0, 5, 76),
// //               child: const Center(
// //                 child: Text(
// //                   'Menu',
// //                   style: TextStyle(
// //                       color: Colors.white, fontWeight: FontWeight.w500),
// //                 ),
// //               ),
// //             ),
// //          ListTile(
// //               title: const Text('Laman Utama',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {
// //                    Navigator.of(context).push(
// //                   MaterialPageRoute(
// //                     builder: (context) => FadeIn(child: const HomePage()),
// //                   ),
// //                 );
// //               },
// //             ),
// //             ListTile(
// //               title: const Text('E-KUARTERS',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               title: const Text('Penawaran',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               title: const Text('Penguatkuasa',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               title: const Text('Penyelenggaraan',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               title: const Text('E-HARTANAH',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               title: const Text('Rumah Peranginan',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               title: const Text('Dewan dan Gelanggang',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {
// //                 Navigator.of(context).push(
// //                   MaterialPageRoute(
// //                     builder: (context) => FadeIn(child: const TempahanPage()),
// //                   ),
// //                 );
// //               },
// //             ),
// //             ListTile(
// //               title: const Text('Ruang Komersial',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               title: const Text('Ruang Pejabat',
// //                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
// //               onTap: () {},
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Center(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(
// //                 horizontal: 16.0, vertical: 20.0), // Adjust padding as needed
// //             child: Column(
// //               children: <Widget>[
// //                 Align(
// //                   alignment: Alignment
// //                       .centerLeft, // Aligns the DropdownButton to the left
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment
// //                         .spaceBetween, // Evenly space the dropdowns
// //                     children: [
// //                       Flexible(
// //                         child: Column(
// //                           children: [
// //                             const Text(
// //                               'Status Pembayaran',
// //                               style: TextStyle(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Color.fromARGB(255, 0, 5, 76),
// //                               ),
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             Container(
// //                               width: 150, // Adjust the width for the dropdown
// //                               height: 40, // Adjust the height if needed
// //                               padding:
// //                                   const EdgeInsets.symmetric(horizontal: 8),
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(
// //                                   color: Colors.grey, // Outline color
// //                                   width: 1.5, // Outline width
// //                                 ),
// //                                 borderRadius:
// //                                     BorderRadius.circular(8), // Rounded corners
// //                               ),
// //                               child: DropdownButtonHideUnderline(
// //                                 child: DropdownButton<String>(
// //                                   focusColor: Colors.white,
// //                                   isExpanded: true,
// //                                   hint: const Row(
// //                                     children: [
// //                                       SizedBox(
// //                                         width: 4,
// //                                       ),
// //                                       Expanded(
// //                                         child: Text(
// //                                           'Pilih Status',
// //                                           style: TextStyle(
// //                                             fontSize: 14,
// //                                             fontWeight: FontWeight.bold,
// //                                             color:
// //                                                 Color.fromARGB(255, 85, 85, 85),
// //                                           ),
// //                                           overflow: TextOverflow.ellipsis,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   items: statusbayaran
// //                                       .map((String item) =>
// //                                           DropdownMenuItem<String>(
// //                                             value: item,
// //                                             child: Text(
// //                                               item,
// //                                               style: const TextStyle(
// //                                                 fontSize: 14,
// //                                                 fontWeight: FontWeight.bold,
// //                                                 color: Color.fromARGB(
// //                                                     255, 102, 102, 102),
// //                                               ),
// //                                               overflow: TextOverflow.ellipsis,
// //                                             ),
// //                                           ))
// //                                       .toList(),
// //                                   value: selectedValue,
// //                                   onChanged: (String? value) {
// //                                     setState(() {
// //                                       selectedValue = value;
// //                                     });
// //                                   },
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       Flexible(
// //                         child: Column(
// //                           children: [
// //                             const Text(
// //                               'Status Permohonan',
// //                               style: TextStyle(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Color.fromARGB(255, 0, 5, 76),
// //                               ),
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             Container(
// //                               width: 150, // Adjust the width for the dropdown
// //                               height: 40, // Adjust the height if needed
// //                               padding:
// //                                   const EdgeInsets.symmetric(horizontal: 8),
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(
// //                                   color: Colors.grey, // Outline color
// //                                   width: 1.5, // Outline width
// //                                 ),
// //                                 borderRadius:
// //                                     BorderRadius.circular(8), // Rounded corners
// //                               ),
// //                               child: DropdownButtonHideUnderline(
// //                                 child: DropdownButton<String>(
// //                                   focusColor: Colors.white,
// //                                   isExpanded: true,
// //                                   hint: const Row(
// //                                     children: [
// //                                       SizedBox(
// //                                         width: 4,
// //                                       ),
// //                                       Expanded(
// //                                         child: Text(
// //                                           'Pilih Status',
// //                                           style: TextStyle(
// //                                             fontSize: 14,
// //                                             fontWeight: FontWeight.bold,
// //                                             color:
// //                                                 Color.fromARGB(255, 85, 85, 85),
// //                                           ),
// //                                           overflow: TextOverflow.ellipsis,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   items: statuspermohonan
// //                                       .map((String item) =>
// //                                           DropdownMenuItem<String>(
// //                                             value: item,
// //                                             child: Text(
// //                                               item,
// //                                               style: const TextStyle(
// //                                                 fontSize: 14,
// //                                                 fontWeight: FontWeight.bold,
// //                                                 color: Color.fromARGB(
// //                                                     255, 102, 102, 102),
// //                                               ),
// //                                               overflow: TextOverflow.ellipsis,
// //                                             ),
// //                                           ))
// //                                       .toList(),
// //                                   value: selectedValueRight,
// //                                   onChanged: (String? value) {
// //                                     setState(() {
// //                                       selectedValueRight = value;
// //                                     });
// //                                   },
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 Container(height: 50),

// //                 SfDateRangePicker(
// //                   // selectionColor: Color.fromARGB(255, 0, 5, 76),
// //                   rangeSelectionColor: const Color.fromARGB(255, 125, 133, 255),
// //                   endRangeSelectionColor: const Color.fromARGB(255, 0, 5, 76),
// //                   startRangeSelectionColor: const Color.fromARGB(255, 0, 5, 76),

// //                   initialSelectedDate: DateTime.now(),
// //                   initialSelectedRanges: [
// //                     PickerDateRange(DateTime.now(), DateTime.now())
// //                   ],
// //                   todayHighlightColor: Colors.green,
// //                   onSelectionChanged: _onSelectionChanged,
// //                   selectionMode: DateRangePickerSelectionMode.range,
// //                   initialSelectedRange: PickerDateRange(
// //                       DateTime.now().subtract(const Duration(days: 0)),
// //                       DateTime.now().add(const Duration(days: 0))),
// //                 ),
// //                   TextButton(
// //               onPressed: () => _showDatePicker(),
// //               child: const Text(
// //                 'Pick a Date',
// //                 style: TextStyle(fontSize: 18, color: Colors.white),
// //               ),
// //               style: TextButton.styleFrom(
// //                 backgroundColor: const Color.fromARGB(255, 0, 5, 76),
// //               ),
// //             ),

// //                 Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: <Widget>[
// //                     const Text(
// //                       '  Tarikh ',
// //                       style: TextStyle(
// //                         color: Color.fromARGB(255, 0, 5, 76),
// //                         fontSize: 15,
// //                         fontWeight: FontWeight.w700,
// //                       ),
// //                       overflow: TextOverflow.ellipsis, // Handle long text
// //                     ),
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: Container(
// //                             height: 40, // Set a fixed height for the container
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 8), // Padding inside
// //                             decoration: BoxDecoration(
// //                               color: Colors.grey[
// //                                   200], // Background color of the container
// //                               borderRadius:
// //                                   BorderRadius.circular(8), // Rounded corners
// //                               border: Border.all(
// //                                   color: Colors.grey), // Optional border
// //                             ),
// //                             alignment:
// //                                 Alignment.centerLeft, // Align text to the left
// //                             child: Text(
// //                               _range,
// //                               style: const TextStyle(
// //                                 color: Color.fromARGB(255, 48, 48, 48),
// //                                 fontSize: 15,
// //                                 fontWeight: FontWeight.w700,
// //                               ),
// //                               overflow:
// //                                   TextOverflow.ellipsis, // Handle long text
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(
// //                             width:
// //                                 8), // Spacing between the container and the button
// //                         SizedBox(
// //                           width: 80, // Fixed width for the button
// //                           height: 40, // Fixed height for the button
// //                           child: ElevatedButton(
// //                             onPressed: () {
// //                               // Button action
// //                             },
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: const Color.fromARGB(
// //                                   255, 0, 5, 76), // Button color
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius:
// //                                     BorderRadius.circular(8), // Rounded corners
// //                               ),
// //                             ),
// //                             child: const Text(
// //                               'Cari',
// //                               style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 30),
// //                     Column(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: List.generate(
// //                         6, // 6 rows
// //                         (rowIndex) => Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                           children: List.generate(
// //                             5, // 5 containers per row
// //                             (colIndex) {
// //                               bool isTopRow = rowIndex == 0;
// //                               return Flexible(
// //                                   flex: 1,
// //                                   child: Padding(
// //                                     padding: const EdgeInsets.all(2.0),
// //                                     child: Container(
// //                                       height:
// //                                           30, // Set a fixed height for all containers
// //                                       decoration: BoxDecoration(
// //                                         color: isTopRow
// //                                             ? const Color.fromARGB(
// //                                                 255, 0, 5, 76)
// //                                             : Colors.grey[
// //                                                 300], // Dark blue for the top row
// //                                         borderRadius: BorderRadius.circular(
// //                                             8), // Rounded corners
// //                                       ),
// //                                       alignment: Alignment.center,
// //                                       child: LayoutBuilder(
// //                                         builder: (context, constraints) {
// //                                           // Calculate the font size dynamically
// //                                           double fontSize =
// //                                               constraints.maxWidth * 0.1;

// //                                           // Ensure font size is not too small or too large
// //                                           fontSize =
// //                                               fontSize < 10 ? 10 : fontSize;
// //                                           fontSize =
// //                                               fontSize > 14 ? 14 : fontSize;

// //                                           return Text(
// //                                             isTopRow
// //                                                 ? topRowTexts[
// //                                                     colIndex] // Custom text for top row
// //                                                 : 'Data${rowIndex + 1}', // Dynamic text for other rows
// //                                             style: TextStyle(
// //                                               color: isTopRow
// //                                                   ? Colors.white
// //                                                   : Colors.black,
// //                                               fontWeight: FontWeight.bold,
// //                                               fontSize:
// //                                                   fontSize, // Dynamic font size
// //                                             ),
// //                                             overflow: TextOverflow
// //                                                 .ellipsis, // Handle overflow
// //                                           );
// //                                         },
// //                                       ),
// //                                     ),
// //                                   ));
// //                             },
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //                 const SizedBox(height: 30),

// //                 // Staff ID TextField
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
