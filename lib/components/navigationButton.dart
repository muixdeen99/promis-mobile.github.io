import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget targetPage;
  final Color iconColor;
  final Color? backgroundColor;

  const NavigationButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.targetPage,
    required this.iconColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Set a fixed width
      height: 100, // Set a fixed height
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => targetPage,
                ),
              );
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation, secondaryAnimation) {
              //       return targetPage; // Target page
              //     },
              //     transitionsBuilder:
              //         (context, animation, secondaryAnimation, child) {
              //       // Create a fade-in effect
              //       const curve = Curves.easeInOut;
              //       var tween = Tween(begin: 0.0, end: 1.0)
              //           .chain(CurveTween(curve: curve));
              //       var opacityAnimation = animation.drive(tween);

              //       // Apply the FadeTransition
              //       return FadeTransition(
              //         opacity: opacityAnimation, // Apply the fade effect
              //         child: child,
              //       );
              //     },
              //     transitionDuration: const Duration(
              //         milliseconds: 500), // Adjust duration as needed
              //   ),
              // );
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor ??
                  iconColor.withOpacity(0.2), // Set background color
              foregroundColor: iconColor, // Set icon and text color
              padding: const EdgeInsets.all(12.0), // Set padding
              alignment: Alignment.center, // Align the content to center
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Set border radius
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 28.0, color: iconColor),
              ],
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2, // Allow text to wrap into 2 lines
            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
          ),
        ],
      ),
    );
  }
}
