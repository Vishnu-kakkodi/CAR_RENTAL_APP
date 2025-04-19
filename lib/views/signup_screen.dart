import 'package:flutter/material.dart';
import 'package:car_rental_app/views/kyc_verification_screen.dart';
import 'package:car_rental_app/widgect/blurred_circle.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
          Positioned(
            top: -100,
            left: -100,
            child: const BlurredCircle(color: Color(0xFF2E2EFF)),
          ),

          Positioned(
            top: 100,
            left: 200,
            child: const BlurredCircle(color: Color(0xFF2E2EFF)),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 579,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              const Color.fromARGB(255, 23, 78, 174),
                              const Color.fromARGB(255, 252, 236, 255),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 13, 3, 80),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Name",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  const TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Mobile Number",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 60),
                  SizedBox(
                    height: 46,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => KycVerificationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 10, 32, 175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
