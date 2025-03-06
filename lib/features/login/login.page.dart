import 'package:flutter/material.dart';
import 'package:promis/features/forgotpassword/forgotpassword.page.dart';
import 'package:promis/features/lamanutama/lamanutama.page.dart.dart';
import 'package:promis/shared/color.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

// import 'package:wave_container/wave_container.dart';
// import 'package:wave_container/wave_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late DioApiService _apiService;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    final dio = createDio(EnvironmentConfig.pentadbiranApiUrl);
    _apiService = DioApiService(dio, EnvironmentConfig.pentadbiranApiUrl);
  }

  String _hashPassword(String password) {
    // Ensure that the input string is encoded in UTF-8
    final bytes = utf8.encode(password); // This is the UTF-8 encoding
    final md5Hash = md5.convert(bytes); // Generate the MD5 hash

    // Base64 encoding to match Java's output
    return base64.encode(md5Hash.bytes); // Return the Base64 encoded string
  }

  Future<void> _authenticate() async {
    try {
      final hashedPassword = _hashPassword(_passwordController.text);
      print(
          'Hashed Password: $hashedPassword'); // Print the hashed and encoded password

      final response = await _apiService.makeRequest(
        RequestMethod.post,
        'mobile/authenticate', // Replace with your actual endpoint
        body: {
          'login': _usernameController.text, // Use input from text field
          'password':
              _passwordController.text, // Use hashed and encoded password
        },
      );
      // Handle the response
      if (response.statusCode == 200) {
        // Navigate to the main page if authentication is successful

        final responseData = response.data;
        print(responseData);
        final userId = responseData['idPengguna'];
        final namaPengguna = responseData['namaPengguna'];
        // Extract user ID from response
        print(userId);
        // Store the user ID using SharedPreferences
        try {
          print('masuk1');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          print('masuk2');
          await prefs.setString('user_id', userId);
          await prefs.setString('namaPengguna', namaPengguna);

          final roleResponse = await Dio().get(
              'https://gerbang.lokal.my/api/pentadbiran/v1/mobile/pengguna/$userId/peranan');
          if (roleResponse.statusCode == 200) {
            final data = roleResponse.data;
            bool isQtrUser = false;
            bool isUTLUser = false;
            bool isRPPUser = false;
            bool isSGRUser = false;
            for (var role in data) {
              print('keterangan: ${role['keterangan']}');
              if (role['keterangan'].contains('(QTR)')) {
                isQtrUser = true;
                break;
              }
            }

            for (var role in data) {
              print('keterangan: ${role['keterangan']}');
              if (role['keterangan'].contains('(UTILITI)')) {
                isUTLUser = true;
                break;
              }
            }

            for (var role in data) {
              print('keterangan: ${role['keterangan']}');
              if (role['keterangan'].contains('(RPP)')) {
                isRPPUser = true;
                break;
              }
            }

            for (var role in data) {
              print('keterangan: ${role['keterangan']}');
              if (role['keterangan'].contains('(SENGGARA)')) {
                isSGRUser = true;
                break;
              }
            }
            print('isQtrUser: $isQtrUser');
            print('isUTLUser: $isUTLUser');
            print('isRPPUser: $isUTLUser');
            print('isRPPUser: $isSGRUser');

            await prefs.setBool('isQtrUser', isQtrUser);
            await prefs.setBool('isUTLUser', isUTLUser);
            await prefs.setBool('isRPPUser', isRPPUser);
            await prefs.setBool('isSGRUser', isSGRUser);
          } else {
            print('Failed to load user role: ${roleResponse.statusCode}');
          }
          print('masuk3');
        } catch (e) {
          print('Error: $e');
        }

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const LamanUtamaPage(); // Target page
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Create a fade-in effect
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
              var opacityAnimation = animation.drive(tween);

              // Apply the FadeTransition
              return FadeTransition(
                opacity: opacityAnimation, // Apply the fade effect
                child: child,
              );
            },
            transitionDuration:
                const Duration(milliseconds: 1000), // Adjust duration as needed
          ),
        );
      } else {
        setState(() {
          _errorMessage =
              'Authentication failed. Status code: ${response.statusCode}. Message: ${response.data}';
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Log Masuk Tidak Berjaya"),
                content: Text("ID Pengguna dan Kata Laluan Tidak Sepadan"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            });
      }
    } catch (e) {
      // Handle the error
      setState(() {
        _errorMessage = 'Error fetching pentadbiran data: $e';
      });
    }
  }

  bool _isObscured =
      true; // Declare a state variable to control password visibility

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitApp = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Tutup Aplikasi?'),
            content: Text('Adakah anda pasti?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop(); // Closes the app on Android
                  } else {
                    exit(0); // Closes the app on iOS
                  }
                },
                child: Text('Ya'),
              ),
            ],
          ),
        );
        return exitApp ?? false;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage('assets/images/promisnobg.png'),
                          width: 200,
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.59,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              labelText: 'ID Pengguna',
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isObscured,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              labelText: 'Kata Laluan',
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                              onPressed: () async {
                                await _authenticate();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 30.0),
                                child: Text(
                                  'Log Masuk',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            child: const Text('Lupa Kata Laluan?'),
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return const ForgotPasswordPage();
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: 0.0, end: 1.0)
                                        .chain(CurveTween(curve: curve));
                                    var opacityAnimation =
                                        animation.drive(tween);
                                    return FadeTransition(
                                        opacity: opacityAnimation,
                                        child: child);
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
