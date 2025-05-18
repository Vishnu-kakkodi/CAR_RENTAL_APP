// import 'package:car_rental_app/controllers/user_controller.dart';
// import 'package:car_rental_app/providers/auth_provider.dart';
// import 'package:car_rental_app/providers/booking_provider.dart';
// import 'package:car_rental_app/providers/car_provider.dart';
// import 'package:car_rental_app/providers/date_time_provider.dart';
// import 'package:car_rental_app/views/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     MultiProvider(providers: [
//       ChangeNotifierProvider(create: (_)=>AuthProvider()),
//       ChangeNotifierProvider(create: (_)=>CarProvider()),
//       ChangeNotifierProvider(create: (_)=>BookingProvider()),
//       ChangeNotifierProvider(create: (_)=>UserController()),
//       ChangeNotifierProvider(create: (_) => DateTimeProvider()),
//     ],
//     child: const MyApp(),
//     )
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }

// import 'package:car_rental_app/controllers/user_controller.dart';
// import 'package:car_rental_app/providers/auth_provider.dart';
// import 'package:car_rental_app/providers/booking_provider.dart';
// import 'package:car_rental_app/providers/car_provider.dart';
// import 'package:car_rental_app/providers/date_time_provider.dart';
// import 'package:car_rental_app/utils/storage_helper.dart';
// import 'package:car_rental_app/views/home_screen.dart';
// import 'package:car_rental_app/views/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => AuthProvider()),
//       ChangeNotifierProvider(create: (_) => CarProvider()),
//       ChangeNotifierProvider(create: (_) => BookingProvider()),
//       ChangeNotifierProvider(create: (_) => UserController()),
//       ChangeNotifierProvider(create: (_) => DateTimeProvider()),
//     ],
//     child: const MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Car Rental App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     // Add a delay for splash screen visibility (adjust as needed)
//     await Future.delayed(const Duration(seconds: 2));

//     // Get the auth token from storage
//     final userId = await StorageHelper.getUserId();

//     // Check if context is still valid
//     if (!mounted) return;

//     // If token exists, try to validate it and get user info
//     if (userId != null && userId.isNotEmpty) {
//       try {
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => const HomeScreen()));
//       } catch (e) {
//         // Handle error - token might be invalid
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => const LoginScreen()));
//       }
//     } else {
//       // No token, navigate to login screen
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const LoginScreen()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0XFF1E0AFE),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // App logo
//             Image.asset(
//               'assets/images/logo.png',
//               width: 150,
//               height: 150,
//               // If you don't have this asset, you can use a placeholder or text
//               errorBuilder: (context, error, stackTrace) {
//                 return const Icon(
//                   Icons.directions_car,
//                   size: 100,
//                   color: Colors.white,
//                 );
//               },
//             ),
//             const SizedBox(height: 24),
//             // App name
//             const Text(
//               'Car Rental App',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 50),
//             // Loading indicator
//             const CircularProgressIndicator(
//               color: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:car_rental_app/controllers/user_controller.dart';
import 'package:car_rental_app/providers/auth_provider.dart';
import 'package:car_rental_app/providers/booking_provider.dart';
import 'package:car_rental_app/providers/car_provider.dart';
import 'package:car_rental_app/providers/date_time_provider.dart';
import 'package:car_rental_app/providers/document_provider.dart';
import 'package:car_rental_app/providers/wallet_provider.dart';
import 'package:car_rental_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => CarProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
      ChangeNotifierProvider(create: (_) => UserController()),
      ChangeNotifierProvider(create: (_) => DateTimeProvider()),
      ChangeNotifierProvider(create: (_) => DocumentProvider()),
      ChangeNotifierProvider(create: (_) => WalletProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rental App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
