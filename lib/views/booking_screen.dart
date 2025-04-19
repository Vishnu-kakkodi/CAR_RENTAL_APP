import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 60),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 90),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "Booking",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TabBar(
                  tabs: const [Tab(text: "Active"), Tab(text: "Completed")],
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0XFF1808C5),
                  indicator: BoxDecoration(
                    color: Color(0XFF1808C5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          _buildBookingCard(
                            carName: "Hyundai Verna",
                            isAutomatic: true,
                            seatingCapacity: 5,
                            collectionDate: "26/12/23",
                            collectionTime: "10:00AM",
                            returnDate: "27/12/23",
                            returnTime: "10:00AM",
                            price: "5500",
                            otp: "1234 44 1234",
                            isCompleted: false,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          _buildBookingCard(
                            carName: "Hyundai Verna",
                            isAutomatic: true,
                            seatingCapacity: 5,
                            collectionDate: "24/12/23",
                            collectionTime: "10:00AM",
                            returnDate: "25/12/23",
                            returnTime: "10:00AM",
                            price: "5000",
                            otp: "",
                            isCompleted: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required String carName,
    required bool isAutomatic,
    required int seatingCapacity,
    required String collectionDate,
    required String collectionTime,
    required String returnDate,
    required String returnTime,
    required String price,
    required String otp,
    required bool isCompleted,
  }) {
    return SingleChildScrollView(
      child: Container(
        // height: 142,
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
                      Text(
                        carName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: Image.network(
                              "https://s3-alpha-sig.figma.com/img/e8f8/65e2/c91404a46fa121357bb184688046fee5?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=pW1NOi4~~VuLgns94GS6zNf4TjhMsaPlyiPT0A7emGprzzlMwyXR9wo1Bfrlviw3OAfGoqiVtTXrmNeFCv7q5RwhpMIP0o~ML2Wlemjz-9u1kjdYIMXpcPjkFLuKl6tAuM67veHly88HC1EHWSbzqfPZVcgY3EYUHepgDEDt4TfdZbh990OMk3B9clgSdfnV13XO5Vu3oGk0Xgg1M0uSRMKMZUi9KnFlreJUV6D6lDJMUZwqWIOFgc8lcgep5B~XPaeBlXBSF8w1xrT2-TxH0XxVceIlT0aBFG5J2UqUa2cKMAuvpuJHwTkfT6X4vBZ44ItpZ8TUKqp3e0URCrbmGA__",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isAutomatic ? "Automatic" : "Manual",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: Image.network(
                              "https://s3-alpha-sig.figma.com/img/336c/57e5/4a2a2fda0c10a8922a097165f5cf504e?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=OtP0WbSdfpPTD15Rb0Aj9wjdI2JGcS3ZMm~KGEeuFp4IyIhu1u7oiypu1xZWWxLwM4Q7sJhNJmBPfI6KxY5TVO7M1BBufRKf6Gooc8RKCm8Wfb1DbgtuWN2pq5I82Cu6fvvyNAowZy4WlihqP6nKb0gI9AtJz0p0AD~FDExGTursRRrOGmUKaIzZMqnuZvlsvRWIoPxBcCzVRjbiu50Fut5b5DsrAdtJ-HhgXBMb~~v8v6CV8rLjodi62HXUOUJPN22w-hoqLavh3UDzQuolQppuOiGGSJMO3lkWyGSK7kMCDDjgAdlqCT7w~o~5HHwAPD-6JLLgVOdieeMku1AF0A__",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "$seatingCapacity Seaters",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        isCompleted ? "Completed" : "OTP: $otp",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 120,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage("https://s3-alpha-sig.figma.com/img/0574/154b/c9aeb8e4b91ef16acae8a243ae5d83fc?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HP8SyYpvbud2SvWWlyVOX8oKHg5KM9w15HDzqG0r8yCoVd5GGu8nEc9Si8AwdOP~PG-EoKGUgCVAeNBVJ8z2UTLP4fKZLeSD4PNguy5on6Liehx3zjX-88JwlM2OTemrSGOPmHLJ3V81Vkuo4MzNSCp99Mq-w1XfA1SroqYCNqSJxN-GqAmQzCJxTHiwtAkJr9bh2~mCF7PNAlRRuORxsF~BnFfdU6~YjnFATheg77HNMFMcvEbsrHXMyXORegwQgW2Jx2YO7ZcNXO8-M3Pz8jlGUyraCNSBw3s3YZkUDm3hoyDWZhRyFpsJTaHUYKUBbkpuME0WC3XyOPxsRVLiVQ__"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              "Collect Date & time: $collectionDate, $collectionTime",
              style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4),
            Text(
              "Return Date & time: $returnDate, $returnTime",
              style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
            ),
          ],
        ),
        Positioned(
          bottom: -16,
          right: -17,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              "₹$price/-",
              style: const TextStyle(
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
    );

  }
}
