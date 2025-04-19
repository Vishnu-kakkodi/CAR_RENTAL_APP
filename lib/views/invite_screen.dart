import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class InviteFriendsScreen extends StatelessWidget {
  final String inviteCode = "HGT9LL8MEE";
  final String imageUrl = "https://s3-alpha-sig.figma.com/img/41df/41e3/2c242f868529f7f8220236825428735b?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=CzgJYo5x11wcMv3wm66r~6~JLNTl5IkVcReMNMSTxuxKJnZ8s6Q8bcXbmW6zIl~a-hCJyOA65KGm2VqZ12D0ecc0XbZ7UYC~kZkkiPjFEZzvgtWDFYFp~0kDeY92VlHxvZR-n7YXEXQS01IadmvWxIRzTZWEtMER1u9zJDTXpZiYh6-rwYgMiARjupWLedmcJynSjkjFjlmdQbBARNn1-bNJykzr-jGtKt2BoKcJU0y~5DWqQ8mYXRvH8kimyFPumgn3KsjrsMIw7dEkGQwBnLcNyLZa57q9r2~YNGW3syj0UW72~O79T3OHQRCHPmpf6TJvOSsu27m4WzEB1lwcKQ__";

  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow and title
              SizedBox(height: 40,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Invite your friends",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Top Illustration
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 24),

              // Earn a free car text
              Align(
                alignment: Alignment.center,
                child: const Text(
                  "Earn a free car",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: const Text(
                  "Did you know you can earn up to AED 3000 by referring 10 friends in a month ? That’s equal to a month subscription.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 45),

              // Invite code box
              Center(
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  dashPattern: [6, 3],
                  color: Colors.black,
                  strokeWidth: 1.2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF2D1DFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      inviteCode,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        "Copy invite code",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2D1DFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const Text("Share invite code",style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
