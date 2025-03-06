import 'package:flutter/material.dart';
import 'package:promis/features/login/login.page.dart';
import 'package:promis/shared/color.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0), // Adjust padding as needed
                child: Column(
                  children: <Widget>[
                    Container(height: 80),
                    const Icon(Icons.lock,
                        color: Color.fromARGB(255, 0, 5, 76), size: 60),

                    const Text(
                      'Lupa',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 5, 76),
                          fontSize: 50,
                          fontWeight: FontWeight.w700),
                    ),

                    const Text(
                      'Kata Laluan?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 5, 76),
                          fontSize: 50,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(height: 4),
                    const Text(
                      'Kami akan menghantar verifikasi kata',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 5, 76),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),

                    // Staff ID TextField
                    const Text(
                      'laluan melalui emel',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 5, 76),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    // Checkbox and "Remember Me" Text

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), // Top left corner
                  topRight: Radius.circular(30), // Top right corner
                ),
              ),
              child: SizedBox(
                height: 300, // Set the height of the container
                width: double.infinity, // Make it full width
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          obscureText: false,
                          //  controller: _emailController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[100]),
                            labelText: "No. Kad Pengenalan",
                            labelStyle: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500),
                            fillColor: primaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                          ),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 231, 231, 231)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Password TextField
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          obscureText: false,
                          //  controller: _emailController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[100]),
                            labelText: "Masukkan Email",
                            labelStyle: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500),
                            fillColor: primaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                          ),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 231, 231, 231)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 45, // Adjusted height
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 226, 226),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100.0), // Match text field radius
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0), // Reduced padding
                          ),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         FadeIn(child: const LamanUtamaPage()),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'Hantar Email',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 37, 37, 37),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      GestureDetector(
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const LoginPage(); // Target page
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
