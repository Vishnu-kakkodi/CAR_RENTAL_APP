import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:car_rental_app/views/home_screen.dart';
import 'package:car_rental_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Add a delay for splash screen visibility (adjust as needed)
    await Future.delayed(const Duration(seconds: 3));

    // Get the auth token from storage
    final userId = await StorageHelper.getUserId();
        final p = await StorageHelper.getProfileImage();

    print("uuuuuuuuuuuuuuuuuuuuuuuuuuu$p");
        print("uuuuuuuuuuuuuuuuuuuuuuuuuuu$userId");


    // Check if context is still valid
    if (!mounted) return;

    // If userId exists, navigate to home screen
    if (userId != null && userId.isNotEmpty) {
      try {
            print("uuuuuuuuuuuuufdhfdufhfdghdfghfdghfdghfduuuuuuuuuuuuu$userId");

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } catch (e) {
        // Handle error - userId might be invalid
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {
      // No userId, navigate to login screen
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1E0AFE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Car animation using Lottie
            SizedBox(
              width: 250,
              height: 250,
              child: Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_2eGBrTWKcC.json', // Car animation
                fit: BoxFit.contain,
                animate: true,
                repeat: true,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.directions_car,
                    size: 100,
                    color: Colors.white,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // App name
            const Text(
              'Car Rental App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            // Loading indicator
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}