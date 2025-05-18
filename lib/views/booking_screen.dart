
import 'package:car_rental_app/models/booking_model.dart';
import 'package:car_rental_app/providers/booking_provider.dart';
import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:car_rental_app/views/car_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // String? userId;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _loadBookings();
      // _loadUserId();
    });
  }

//   Future<void> _loadUserId() async {
//   final id = await StorageHelper.getUserId();
//   setState(() {
//     userId = id;
//   });
// }

  void _loadBookings() async {
    String? userId = await StorageHelper.getUserId();
    if (userId != null) {
      await Provider.of<BookingProvider>(context, listen: false).loadBookings(userId);
    } else {
      print("User ID not found in SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final paddingValue = screenWidth * 0.04;
    
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(paddingValue),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back, 
                          color: Colors.black,
                          size: screenWidth * 0.06, 
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "Bookings",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045, 
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: screenWidth * 0.4, 
                        height: screenHeight * 0.04, 
                        child: Center(
                          child: Text(
                            "Active",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: screenWidth * 0.4, 
                        height: screenHeight * 0.04, 
                        child: Center(
                          child: Text(
                            "Completed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045, 
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: screenWidth * 0.4, 
                        height: screenHeight * 0.04,
                        child: Center(
                          child: Text(
                            "Cancelled",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045, 
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0XFF1808C5),
                  indicator: BoxDecoration(
                    color: const Color(0XFF1808C5),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.transparent,
                ),
              ),
              
              SizedBox(height: screenHeight * 0.02),
              
              Expanded(
                child: Consumer<BookingProvider>(
                  builder: (context, bookingProvider, child) {
                    if (bookingProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    final activeBookings = bookingProvider.bookings
                        .where((booking) => booking.isPending)
                        .toList();
                    
                    final completedBookings = bookingProvider.bookings
                        .where((booking) => booking.isCompleted)
                        .toList();
                    
                    final cancelledBookings = bookingProvider.bookings
                        .where((booking) => booking.isCancelled)
                        .toList();

                    return TabBarView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        _buildBookingList(
                          context,
                          activeBookings,
                          "No active bookings",
                          paddingValue,
                          screenWidth,
                          screenHeight,
                        ),
                        
                        _buildBookingList(
                          context,
                          completedBookings,
                          "No completed bookings",
                          paddingValue,
                          screenWidth,
                          screenHeight,
                        ),
                        
                        _buildBookingList(
                          context,
                          cancelledBookings,
                          "No cancelled bookings",
                          paddingValue,
                          screenWidth,
                          screenHeight,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList(
    BuildContext context,
    List<Booking> bookings,
    String emptyMessage,
    double paddingValue,
    double screenWidth,
    double screenHeight,
  ) {
    if (bookings.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Column(
            children: [
              _buildBookingCard(
                context,
                booking: booking,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02), 
            ],
          );
        },
      ),
    );
  }

Widget _buildBookingCard(
  BuildContext context, {
  required Booking booking,
  required double screenWidth,
  required double screenHeight,
}) {
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetailsScreen(userId:booking.userId, bookingId: booking.id,)));
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(screenWidth * 0.03), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      booking.car.name, 
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, 
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    if (!booking.isCancelled)
                      Text(
                        booking.isCompleted 
                            ? "Completed" 
                            : "OTP: ${booking.otp}  ID: ${booking.id.substring(booking.id.length - 4)}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade400,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
    
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.settings,
                                size: screenWidth * 0.04, 
                                color: Colors.black87,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                booking.car.type == 'automatic' ? "Automatic" : "Manual", 
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.012), 
    
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: screenWidth * 0.04,
                                color: Colors.black87,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                "${booking.car.seats} Seaters",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035, 
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015), 
    
                          Text(
                            "Collect Date & time: ${_formatDate(booking.rentalStartDate)}, ${_formatTime(booking.rentalStartDate)}", 
                            style: TextStyle(
                              fontSize: screenWidth * 0.025, 
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.008), 
                          Text(
                            "Return Date & time: ${_formatDate(booking.rentalEndDate)}, ${_formatTime(booking.rentalEndDate)}",
                            style: TextStyle(
                              fontSize: screenWidth * 0.025, 
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
    
                    Container(
                      width: screenWidth * 0.32,
                      height: screenHeight * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        color: Colors.grey.shade300,
                        image: booking.car.image.isNotEmpty 
                            ? DecorationImage(
                                image: NetworkImage(booking.car.image[0]),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: booking.car.image.isEmpty
                          ? Icon(
                              Icons.directions_car,
                              size: screenWidth * 0.12,
                              color: Colors.black54,
                            )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
    
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03, 
                vertical: screenHeight * 0.01, 
              ),
              decoration: BoxDecoration(
                color: const Color(0XFF1808C5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.03),
                  bottomRight: Radius.circular(screenWidth * 0.03),
                ),
              ),
              child: Text(
                "₹${booking.totalPrice.toStringAsFixed(0)}/-",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
    
          // Cancelled overlay
          if (booking.isCancelled)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Cancelled",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: screenWidth * 0.07,
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

String _formatDate(DateTime dateTime) {
  return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
}

String _formatTime(DateTime dateTime) {
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}
}