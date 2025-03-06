import 'package:flutter/material.dart';
import 'package:promis/shared/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String pageName1;
  final String pageName2;
  final bool showButton;
  final VoidCallback? buttonAction;

  const CustomAppBar({
    Key? key,
    required this.userName,
    required this.pageName1,
    required this.pageName2,
    this.showButton = false,
    this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: const BorderRadius.only(
      //   bottomLeft: Radius.circular(20.0),
      //   bottomRight: Radius.circular(20.0),
      // ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Menu',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          pageName1,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
