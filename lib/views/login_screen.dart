import 'package:car_rental_app/controllers/auth_controller.dart';
import 'package:car_rental_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_app/views/otp_screen.dart';
import 'package:car_rental_app/widgect/blurred_circle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();

  final AuthController _authController = AuthController();

  @override
  void dispose(){
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Stack(
              children: [
                Positioned(
                  top: -100,
                  left: -100,
                  child: BlurredCircle(color: Color(0xFF2E2EFF)),
                ),
                Positioned(
                  top: 100,
                  left: 200,
                  child: BlurredCircle(color: Color(0xFF2E2EFF)),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 615,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Our app is waiting for Campaign your ideas",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                   TextField(
                    keyboardType: TextInputType.phone,
                    controller: _mobileController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "9898989898",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    height: 46,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () async {
                        final mobile = _mobileController.text.trim();
                        if(mobile.isEmpty) return;
                        final isSuccess = await _authController.loginUser(context, mobile);
                        if(isSuccess){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed"))); 
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 10, 32, 175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Login",
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
