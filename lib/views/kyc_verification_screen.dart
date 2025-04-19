import 'package:flutter/material.dart';
import 'package:car_rental_app/views/home_screen.dart';
import 'package:car_rental_app/widgect/blurred_circle.dart';

class KycVerificationScreen extends StatefulWidget {
  const KycVerificationScreen({super.key});

  @override
  State<KycVerificationScreen> createState() => _KycVerificationScreenState();
}

class _KycVerificationScreenState extends State<KycVerificationScreen> {
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
                        'Kyc Verification',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              const Color.fromARGB(255, 53, 103, 188),
                              const Color.fromARGB(255, 53, 15, 206),
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
                                '2',
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
                      suffixIcon: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.red,
                      ),
                      hintText: "Upload Adhar card",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  const TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.red,
                      ),
                      hintText: "Upload Driving Licence",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  const TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.red,
                      ),
                      hintText: "Upload Driving Licence",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.red,
                      ),
                      hintText: "Upload Driving Licence",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  SizedBox(
                    height: 46,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        showVerificationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 10, 32, 175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Verify",
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

  void showVerificationDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Dialog",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
            // ✅ Add this to apply proper theme & remove warning
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width - 48,
              height: 470,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 25),

                  Image.asset('assets/loading.jpeg', height: 100),
                  const SizedBox(height: 20),
                  const Text(
                    'Documents is under verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Book the car in low cost and enjoy the\nTrip with your family',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF001AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
