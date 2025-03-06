import 'package:flutter/material.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/rumahperanginan/tempahanrumahperanginan_page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/shared/color.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  
   final TextEditingController _emailcontroller = TextEditingController();
  String _email = "m.yxsrx@gmail.com";
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
            flexibleSpace: const Padding(
              padding: EdgeInsets.only(
                  top: 40.0, left: 16.0), // Consistent padding
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align items to the start
                  children: [
                    SizedBox(height: 8),
                    Stack(
                      children: [
                        // Main account icon
                        Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.white,
                        ),
                        // Edit icon
                       
                      ],
                    ),
                    // const SizedBox(height: 8), // Spacing between icon and text
                    Text(
                      'Selamat Datang,',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Adjust the font size as needed
                      ),
                    ),
                    Text(
                      'Muhammad Yusri',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '    Profile Pengguna',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
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
            child:Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0), // Adjust padding as needed
    child: Column(
      children: <Widget>[
        Container(height: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the column vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center the column horizontally
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align row content at the top
                children: [
                  const Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kategori Pengguna ',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Gelaran ',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Nama ',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          child: Text(
                            'No. Kad Pengenalan',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          child: Text(
                            'No. Telefon Bimbit',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          child: Text(
                            'Emel Peribadi',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          child: Text(
                            'Emel Rasmi / Pejabat',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20), // Adds spacing between the columns
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Penjawat Awam',
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Encik',
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Muhammad Yusri Bin Abdul Ghani',
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '990421-10-7383',
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 30,
                          child: SizedBox(
                            width: 250,
                            height: 30, // Matches the height of the TextField
                            child: const TextField(

                              decoration: InputDecoration(
                                labelText: '01137940237',
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 40, 40, 40),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          height: 30, // Matches the height of the TextField
                          child:  TextField(
                             controller: _emailcontroller,
                            decoration: InputDecoration(
                              
                             labelText: _email,
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 40, 40, 40),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                              border: const OutlineInputBorder(),
                            ),
                             onChanged: (value) {
              setState(() {
                _email = value.isEmpty ? "m.yxsrx@gmail.com" : value;
              });
            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          height: 30, // Matches the height of the TextField
                          child: const TextField(
                            decoration: InputDecoration(
                              labelText: 'yusri@zenapps.my',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 40, 40, 40),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        Container(height: 20),
        ElevatedButton(
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, 
    backgroundColor: Colors.green, // Text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Button padding
  ),
  onPressed: () {
    // Add your onPressed action here
  },
  child: const Text(
    'Kemaskini',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),)

      ],
    ),
  ),
),

          ),
          
        ],
      ),
    );
  }
}
