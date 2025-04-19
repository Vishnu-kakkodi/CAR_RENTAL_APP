import 'package:flutter/material.dart';
import 'package:car_rental_app/views/booking_screen.dart';
import 'package:car_rental_app/views/documents_screen.dart';
import 'package:car_rental_app/views/edit_profile.dart';
import 'package:car_rental_app/views/invite_screen.dart';
import 'package:car_rental_app/views/login_screen.dart';
import 'package:car_rental_app/views/wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 80),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/8803/09d8/d37dba8d3a87672e52a35231ec7c6673?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bfHpW3Vvr3MdMOncmv~6M-LgnHNttnwLmwC3TXubR4KjGUqu3DWxUkiOFtiOElHOhQ~ftwJgAHyhV5Wu4jdzxzZN3U2jyiqpgjXmk3AAkc7ZIztkTF037wQkomozU9OEbA2vnRPRNMC2IazG0napdJ-i0Hu1BmaX6hX-Hiv13rDQaIx9r3Hg3drnTAveFF~ALNujNbW9MNT~xwgrxR8d5E6kt69Kkd~dnmIpW-GDm7ukh3pIdPVTX7XT~yF--cXVGBrAmiz6C0USJAS~9OjeXGHzQuKKcoVE9uIVkYZ1JoUOah~PIIrsb0T6bWD-hLKXqMVHtv8eXZ2mOW~nVwtT4g__",
                        ),
                        radius: 35,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Handle profile image edit
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.edit, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "K. Narasimha varma",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text("Referal code : XBM4U0123 "),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Divider(),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFEBDCE3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.person_outlined,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => EditProfile()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8EEF6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.history,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Booking History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => BookingScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFCED1E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.document_scanner,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Documents",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => Documents()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEF9DB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.wallet,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Wallet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => WalletScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFEAE5E4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.share,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Invite & Earn",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => InviteFriendsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEF9DB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.settings,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      // );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),

              // Logout Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFFE0000),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.logout,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
