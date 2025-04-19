import 'package:flutter/material.dart';
import 'package:car_rental_app/views/profile_screen.dart';
import 'package:car_rental_app/views/car_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(0),
          ),
          border: Border.all(color: Colors.grey, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.home, color: Color(0XFF120698), size: 24),
                  SizedBox(width: 4),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: Color(0XFF120698),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => CarListScreen()),
                );
              },
              icon: const Icon(Icons.category, color: Colors.grey),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => ProfileScreen()),
                );
              },
              icon: const Icon(Icons.person, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.location_on_outlined,
                        size: 24,
                        color: Color(0XFF120698),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Location', style: TextStyle(fontSize: 12)),
                          Text(
                            'Kukatpally, Jntuk',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.card_giftcard_outlined),
                      SizedBox(width: 8),
                      Icon(Icons.wallet),
                      SizedBox(width: 10),
                      Text('₹200', style: TextStyle(fontSize: 14)),
                      SizedBox(width: 12),
                      Container(
                        width: 65,
                        height: 45,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0XFF120698),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://s3-alpha-sig.figma.com/img/a092/3fb0/85f706b30752e1c21ad66b14ce160e67?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KwBBfdas3pCqKgG54~kj~3aVD6BFd66U1REkY8Ug~rQX1ZXyPlQyHjDa6beeL3CkV9FO~IDjygcgUFyO-Jq0UlKEkt4kOBoPlv2mpud-UD9RWweXFUSlc~C1UwPBTYgfpvlXUQzbtm3F6Fl3Ay-D2cGWFmT~r0pb9FTTlKSBfFsTIbYIrvM5Iyt1EeDSesHkmZBv8XlSiIwcbo309PuFywTYAiNdhqY0z12-31~12SGejo~niRFv-U7abHecL6Dw3Q9PRFCmSvL~TM4Ht0Vt1tyyuogxpIF-75qbSKnZ8JgL4jbhAN~HIOGab5B~ODdC7D27NXAWJwSrmlYSSnawuA__",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/ec17/b4e9/1246ab73a102f44024f779d578dc1ade?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=PbYTDqcq~sn8opL~xpwwJsYaCnBQDJZD1YyymoiTvS6XSSf-8EwqtrZfLmt3fISnFoxnWyxDYXWeCKSgeGUqEUo-GjEP-feGc-j7G6YYHg9KuVi0LaXZFI~upoKYq0kzdsY0oeq9dpfGLsmN~bKAXgZPVZ8dNto-CARVhcsIqv3lRcXiGNTDeP~nwc7sk~BkLnGf4G~~m2xNb6gIvm3tnkbgCGeYjWD35BVMO2Ba0Es2e~gwh1tAAnsGe4qT9w~ckIqmsIrRo08ZCJD3i9SzxThTAu0CbCL2GQXvZMywYEC~pxD5v2Sd8lYDkgry-UYydj3ggUaFTB7PCESIBlp5EA__',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 6,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0XFF120698),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(width: 14),
                  Container(
                    height: 6,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Color(0XFF120698),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(width: 14),

                  Container(
                    height: 6,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Color(0XFF120698),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Rent a car anytime',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  if (index == 4) {
                    // Calendar icon card
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 0,
                          child: Container(
                            height: 6,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 4),
                          height: 80,
                          width: 55,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Icon(Icons.calendar_month_sharp),
                        ),
                      ],
                    );
                  }

                  bool isSelected = index == 0;
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 6,
                          width: 50,
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Color(0XFFDCDCDC) : Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 4),
                        height: 80,

                        width: 60,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0XFF120698) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '22',
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Mar',
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF120698),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.access_time, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text('10:00 Am', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '12hrs',
                        style: TextStyle(color: Colors.black),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 2,
                            width: 90,
                            color: Colors.black54,
                          ),
                          Transform.translate(
                            offset: const Offset(-5, 0),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(width: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF120698),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.access_time, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text('10:00 Am', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Recent Bookings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              Container(
                height: 142,
                width: 343,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade400, width: 2),
                    right: BorderSide(color: Colors.grey.shade400, width: 2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      offset: Offset(3, 3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: OverflowBox(
                  maxHeight: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Hyundai ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Verna',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.settings,
                                          size: 16,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "Automatic",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.event_seat,
                                          size: 16,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "5 Seaters",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "OTP : 1234   id: 1234",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    width: 120,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          'https://s3-alpha-sig.figma.com/img/0574/154b/c9aeb8e4b91ef16acae8a243ae5d83fc?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HP8SyYpvbud2SvWWlyVOX8oKHg5KM9w15HDzqG0r8yCoVd5GGu8nEc9Si8AwdOP~PG-EoKGUgCVAeNBVJ8z2UTLP4fKZLeSD4PNguy5on6Liehx3zjX-88JwlM2OTemrSGOPmHLJ3V81Vkuo4MzNSCp99Mq-w1XfA1SroqYCNqSJxN-GqAmQzCJxTHiwtAkJr9bh2~mCF7PNAlRRuORxsF~BnFfdU6~YjnFATheg77HNMFMcvEbsrHXMyXORegwQgW2Jx2YO7ZcNXO8-M3Pz8jlGUyraCNSBw3s3YZkUDm3hoyDWZhRyFpsJTaHUYKUBbkpuME0WC3XyOPxsRVLiVQ__',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Collect Date & time : 26/9/23 , 10:00AM",
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Return Date & time : 27/9/23 , 10:00AM",
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        bottom:
                            -9, 
                        right:
                            -16, 
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF071952),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "₹500/-",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Rent a car',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    height: 263,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=600',
                            width: double.infinity,
                            height: 263,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF8A935D), Color(0xFF4A522B)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),

                            child: Text(
                              'Kukatpally.. 3km Away',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              color: const Color.fromARGB(255, 160, 160, 160),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hyundai Verna',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '₹45 / hr',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
