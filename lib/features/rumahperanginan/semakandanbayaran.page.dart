import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/profile/profileedit.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/shared/color.dart';
// ignore: depend_on_referenced_packages

class SemakanDanBayaranPage extends StatefulWidget {
  const SemakanDanBayaranPage({super.key});

  @override
  State<SemakanDanBayaranPage> createState() => _SemakanDanBayaranPageState();
}

class _SemakanDanBayaranPageState extends State<SemakanDanBayaranPage> {
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
      home: const MySemakanDanBayaranPage(title: 'ProMIS'),
    );
  }
}

class MySemakanDanBayaranPage extends StatefulWidget {
  const MySemakanDanBayaranPage({super.key, required this.title});

  final String title;

  @override
  State<MySemakanDanBayaranPage> createState() =>
      _MySemakanDanBayaranPageState();
}

class _MySemakanDanBayaranPageState extends State<MySemakanDanBayaranPage> {

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CustomAppBar(userName: '', pageName1: 'Semakan & Bayaran', pageName2: ''),
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
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const KuartersPage(); // Target page
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
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Penyelenggaraan',
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                    onTap: () {},
                  ),
                ]),

            ExpansionTile(
                title: const Text('E-HARTANAH',
                    style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                children: [
                  ListTile(
                    title: const Text('Rumah Peranginan',
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const RumahPeranginanPage(); // Target page
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
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const TempahanPage(); // Target page
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Center(
                  // Centers the Row within the available space
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: [
                            
                             const Align(
                              alignment: Alignment.center,
                              child: Text(
                                '  Senarai Semakan Dan Bayaran ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis, // Handle long text
                              ),
                            ),
                              const SizedBox(height: 20),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: Card(
                                surfaceTintColor: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.black,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'ID No',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon:
                                                const Icon(Icons.pin_drop_rounded),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.phone),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.info_outline),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Maklumat Peranginan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Mohon ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Penginapan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Status Bayaran',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16), // Adds some spacing between the columns
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      // const SizedBox(height: 10),
                                      Stack(
                                        children: [
                                          const SizedBox(
                                            height: 40,
                                            width: 450,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'SEMAK',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: TextButton(
                                                style: const ButtonStyle(
                                                  foregroundColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  overlayColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  backgroundColor:
                                                
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  surfaceTintColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                ),
                                                onPressed: () {},
                                                child: const Text('')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                               Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: Card(
                                surfaceTintColor: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.black,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'ID No',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon:
                                                const Icon(Icons.pin_drop_rounded),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.phone),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.info_outline),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Maklumat Peranginan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Mohon ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Penginapan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Status Bayaran',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16), // Adds some spacing between the columns
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      // const SizedBox(height: 10),
                                      Stack(
                                        children: [
                                          const SizedBox(
                                            height: 40,
                                            width: 450,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'SEMAK',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: TextButton(
                                                style: const ButtonStyle(
                                                  foregroundColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  overlayColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  backgroundColor:
                                                
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  surfaceTintColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                ),
                                                onPressed: () {},
                                                child: const Text('')),
                                          ),
                                        ],
                                      
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                               Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: Card(
                                surfaceTintColor: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.black,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'ID No',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon:
                                                const Icon(Icons.pin_drop_rounded),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.phone),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.info_outline),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Maklumat Peranginan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Mohon ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Penginapan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Status Bayaran',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16), // Adds some spacing between the columns
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      // const SizedBox(height: 10),
                                      Stack(
                                        children: [
                                          const SizedBox(
                                            height: 40,
                                            width: 450,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'SEMAK',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: TextButton(
                                                style: const ButtonStyle(
                                                  foregroundColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  overlayColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  backgroundColor:
                                                
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  surfaceTintColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                ),
                                                onPressed: () {},
                                                child: const Text('')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                               Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: Card(
                                surfaceTintColor: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.black,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'ID No',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon:
                                                const Icon(Icons.pin_drop_rounded),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.phone),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            color: Colors.grey,
                                            iconSize: 25,
                                            icon: const Icon(Icons.info_outline),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Maklumat Peranginan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Mohon ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Tarikh Penginapan ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Status Bayaran',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16), // Adds some spacing between the columns
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Data from API',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                      const Divider(thickness: 1),
                                      // const SizedBox(height: 10),
                                      Stack(
                                        children: [
                                          const SizedBox(
                                            height: 40,
                                            width: 450,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'SEMAK',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: TextButton(
                                                style: const ButtonStyle(
                                                  foregroundColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  overlayColor:  MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  backgroundColor:
                                                
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                  surfaceTintColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent),
                                                ),
                                                onPressed: () {},
                                                child: const Text('')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                                const SizedBox(height: 40),
                        ]),
                       
                      ],
                    ),
                  ]),
                ),
              ),
            ),
              
          ],
        ));
  }
}