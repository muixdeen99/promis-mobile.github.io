import 'package:flutter/material.dart';
import 'package:promis/shared/color.dart';

class Menu_card extends StatelessWidget {
  final String title;
  final Widget targetPage;
  final IconData icon;
  final Color iconColor;

  const Menu_card({
    Key? key,
    required this.title,
    required this.targetPage,
    required this.icon,
    this.iconColor = const Color.fromARGB(255,17,54,107),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 400,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Icon(
                icon,
                size: 30,
                color: this.iconColor,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => targetPage,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}