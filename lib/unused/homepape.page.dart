// import 'package:flutter/material.dart';
// import 'package:promis/features/kuarters/kuarters.page.dart';

// import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
// import 'package:promis/features/tempahan/tempahan.page.dart';

// import '../pengumuman/pengumuman.page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
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
//       home: const MyHomePage(title: 'ProMIS'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
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
//             backgroundColor: const Color.fromARGB(255, 0, 5, 76),
//             flexibleSpace: const Padding(
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
//                     Icon(
//                       Icons.account_circle,
//                       size: 40,
//                       color: Colors.white,
//                     ),
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
//                       '    Laman Utama',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
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
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // Use a Container to control the height of the DrawerHeader
//             Container(
//               height: 60, // Adjust height to your preference
//               color: const Color.fromARGB(255, 0, 5, 76),
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
//             ListTile(
//               title: const Text('E-KUARTERS',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {
//                 Navigator.of(context).push(
//                   PageRouteBuilder(
//                     pageBuilder: (context, animation, secondaryAnimation) {
//                       return const KuartersPage(); // Target page
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
//             ListTile(
//               title: const Text('Penawaran',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {},
//             ),
//             ListTile(
//               title: const Text('Penguatkuasa',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {},
//             ),
//             ListTile(
//               title: const Text('Penyelenggaraan',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {},
//             ),
//             ListTile(
//               title: const Text('E-HARTANAH',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {},
//             ),
//             ListTile(
//               title: const Text('Rumah Peranginan',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {
//                 Navigator.of(context).push(
//                   PageRouteBuilder(
//                     pageBuilder: (context, animation, secondaryAnimation) {
//                       return const RumahPeranginanPage(); // Target page
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
//             ListTile(
//               title: const Text('Dewan dan Gelanggang',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {
//                 Navigator.of(context).push(
//                   PageRouteBuilder(
//                     pageBuilder: (context, animation, secondaryAnimation) {
//                       return const TempahanPage(); // Target page
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
//                 ListTile(
//               title: const Text('Pengumuman',
//                   style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
//               onTap: () {

// //  Navigator.of(context).push(
// //                   PageRouteBuilder(
// //                     pageBuilder: (context, animation, secondaryAnimation) {
// //                       return  PengumumanPage(); // Target page
// //                     },
// //                     transitionsBuilder:
// //                         (context, animation, secondaryAnimation, child) {
// //                       // Create a fade-in effect
// //                       const curve = Curves.easeInOut;
// //                       var tween = Tween(begin: 0.0, end: 1.0)
// //                           .chain(CurveTween(curve: curve));
// //                       var opacityAnimation = animation.drive(tween);

// //                       // Apply the FadeTransition
// //                       return FadeTransition(
// //                         opacity: opacityAnimation, // Apply the fade effect
// //                         child: child,
// //                       );
// //                     },
// //                     transitionDuration: const Duration(
// //                         milliseconds: 500), // Adjust duration as needed
// //                   ),
// //                 );

//               },
//             ),
           
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0, vertical: 20.0), // Adjust padding as needed
//             child: Column(
//               children: <Widget>[
//                 Container(height: 50),
//                 SizedBox(
//                   height: 80,
//                   width: 400,
//                   child: Card(
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: ListTile(
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                               8.0), // Optional: to make the image corners rounded
//                           child: const Icon(
//                             Icons.image,
//                             size: 50,
//                           ),
//                         ),
//                         title: const Text(
//                           'Kuarters',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 0, 5, 76),
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         trailing: const Icon(Icons.chevron_right),
//                         onTap: () {
//                           Navigator.of(context).push(
//                             PageRouteBuilder(
//                               pageBuilder:
//                                   (context, animation, secondaryAnimation) {
//                                 return const KuartersPage(); // Target page
//                               },
//                               transitionsBuilder: (context, animation,
//                                   secondaryAnimation, child) {
//                                 // Define the slide direction (e.g., from right to left)
//                                 const begin = Offset(1.0,
//                                     0.0); // Start position (1.0, 0.0) is from the right
//                                 const end = Offset
//                                     .zero; // End position is the center (0, 0)
//                                 const curve = Curves.easeInOut;

//                                 // Create the tween for the sliding animation
//                                 var tween = Tween(begin: begin, end: end)
//                                     .chain(CurveTween(curve: curve));
//                                 var offsetAnimation = animation.drive(tween);

//                                 // Apply the SlideTransition
//                                 return SlideTransition(
//                                   position:
//                                       offsetAnimation, // Slide from the right to the center
//                                   child: child,
//                                 );
//                               },
//                               transitionDuration: const Duration(
//                                   milliseconds:
//                                       500), // Adjust duration as needed
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(height: 50),
//                 SizedBox(
//                   height: 80,
//                   width: 400,
//                   child: Card(
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: ListTile(
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                               8.0), // Optional: to make the image corners rounded
//                           child: const Icon(
//                             Icons.image,
//                             size: 50,
//                           ),
//                         ),
//                         title: const Text(
//                           'Dewan dan Gelanggang',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 0, 5, 76),
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         trailing: const Icon(Icons.chevron_right),
//                         onTap: () {
//                           Navigator.of(context).push(
//                             PageRouteBuilder(
//                               pageBuilder:
//                                   (context, animation, secondaryAnimation) {
//                                 return const TempahanPage(); // Target page
//                               },
//                               transitionsBuilder: (context, animation,
//                                   secondaryAnimation, child) {
//                                 // Define the slide direction (e.g., from right to left)
//                                 const begin = Offset(1.0,
//                                     0.0); // Start position (1.0, 0.0) is from the right
//                                 const end = Offset
//                                     .zero; // End position is the center (0, 0)
//                                 const curve = Curves.easeInOut;

//                                 // Create the tween for the sliding animation
//                                 var tween = Tween(begin: begin, end: end)
//                                     .chain(CurveTween(curve: curve));
//                                 var offsetAnimation = animation.drive(tween);

//                                 // Apply the SlideTransition
//                                 return SlideTransition(
//                                   position:
//                                       offsetAnimation, // Slide from the right to the center
//                                   child: child,
//                                 );
//                               },
//                               transitionDuration: const Duration(
//                                   milliseconds:
//                                       500), // Adjust duration as needed
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(height: 50),
//                 SizedBox(
//                   height: 80,
//                   width: 400,
//                   child: Card(
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: ListTile(
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                               8.0), // Optional: to make the image corners rounded
//                           child: const Icon(
//                             Icons.image,
//                             size: 50,
//                           ),
//                         ),
//                         title: const Text(
//                           'Rumah Peranginan',
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 0, 5, 76),
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         trailing: const Icon(Icons.chevron_right),
//                         onTap: () {
//                           Navigator.of(context).push(
//                             PageRouteBuilder(
//                               pageBuilder:
//                                   (context, animation, secondaryAnimation) {
//                                 return const RumahPeranginanPage(); // Target page
//                               },
//                               transitionsBuilder: (context, animation,
//                                   secondaryAnimation, child) {
//                                 // Define the slide direction (e.g., from right to left)
//                                 const begin = Offset(1.0,
//                                     0.0); // Start position (1.0, 0.0) is from the right
//                                 const end = Offset
//                                     .zero; // End position is the center (0, 0)
//                                 const curve = Curves.easeInOut;

//                                 // Create the tween for the sliding animation
//                                 var tween = Tween(begin: begin, end: end)
//                                     .chain(CurveTween(curve: curve));
//                                 var offsetAnimation = animation.drive(tween);

//                                 // Apply the SlideTransition
//                                 return SlideTransition(
//                                   position:
//                                       offsetAnimation, // Slide from the right to the center
//                                   child: child,
//                                 );
//                               },
//                               transitionDuration: const Duration(
//                                   milliseconds:
//                                       500), // Adjust duration as needed
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Staff ID TextField
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
