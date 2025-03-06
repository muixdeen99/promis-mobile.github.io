import 'package:flutter/material.dart';
import 'package:promis/features/kuarters/kuarters.page.dart';
import 'package:promis/features/rumahperanginan/rumahperanginan.page.dart';
import 'package:promis/features/tempahan/tempahan.page.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/shared/color.dart';

import '../../lamanutama/lamanutama.page.dart.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 60,
            color: primaryColor,
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          ListTile(
            title: const Text('Laman Utama'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LamanUtamaPage()),
              );
            },
          ),
          ExpansionTile(
            title: const Text('E-KUARTERS'),
            children: [
              ListTile(
                title: const Text('Penawaran'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const KuartersPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Penguatkuasa'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Penyelenggaraan'),
                onTap: () {},
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('E-HARTANAH'),
            children: [
              ListTile(
                title: const Text('Rumah Peranginan'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RumahPeranginanPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Dewan dan Gelanggang'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const TempahanPage()),
                  );
                },
              ),
            ],
          ),
          ListTile(
            title: const Text('Log Keluar'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
