

import 'package:car_rental_app/controllers/car_controller.dart';
import 'package:car_rental_app/providers/auth_provider.dart';
import 'package:car_rental_app/providers/booking_provider.dart';
import 'package:car_rental_app/providers/car_provider.dart';
import 'package:car_rental_app/services/api/car_service.dart';
import 'package:car_rental_app/services/location/location_service.dart';
import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:car_rental_app/views/booking_confirmation_screen.dart';
import 'package:car_rental_app/views/invite_screen.dart';
import 'package:car_rental_app/views/wallet_screen.dart';
import 'package:car_rental_app/widgect/home_carousel.dart';
import 'package:car_rental_app/widgect/recent_booking.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_app/views/profile_screen.dart';
import 'package:car_rental_app/views/car_list_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:car_rental_app/providers/date_time_provider.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  String? _localImageUrl;
  String _address = 'Fetching location...';

  late CarController _carController;
  final String type = "";
  final String fuel = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchAddress();
    _initializeCarController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Listen to changes in AuthProvider
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.user?.profileImage != null) {
      _updateProfileImage(authProvider);
    }
  }

  void _initializeCarController() {
    final provider = Provider.of<CarProvider>(context, listen: false);
    final service = CarService();
    _carController = CarController(provider, service);
    _carController.initCars();
  }

  void _updateProfileImage(AuthProvider authProvider) {
    if (authProvider.user?.profileImage != null) {
      setState(() {
        _localImageUrl = authProvider.user!.profileImage;
      });
    }
  }

  void _fetchAddress() async {
    final address = await LocationService.getCurrentAddress();
    setState(() {
      _address = address ?? 'Unable to fetch address';
      List<String> parts = _address.split(',');

// If there's more than one part, remove the first one
String trimmedAddress =
          parts.length > 1 ? parts.sublist(1).join(',').trim() : _address;
      _address = trimmedAddress;
      _address = trimmedAddress;
    });
  }

  Future<void> _loadUserData() async {
    try {
      final userId = await StorageHelper.getUserId();
      if (userId != null && mounted) {
        await Provider.of<BookingProvider>(context, listen: false)
            .getRecentBooking(userId);

        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        StorageHelper.getProfileImage().then((storedImage) {
          final profileImage = authProvider.user?.profileImage ?? storedImage;

          if (profileImage != null) {
            _localImageUrl = profileImage;
          } else {
            _localImageUrl =
                'https://avatar.iran.liara.run/public/boy?username=Ash';
          }

          if (mounted) {
            setState(() {}); // to refresh UI
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to load booking data: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _selectFromCalendar({required bool isStartDate}) async {
    final DateTimeProvider provider =
        Provider.of<DateTimeProvider>(context, listen: false);
    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (provider.startDate ?? today)
          : (provider.endDate ?? provider.startDate ?? today),
      firstDate: isStartDate ? today : (provider.startDate ?? today),
      lastDate: DateTime(today.year + 1),
    );

    if (picked != null) {
      if (isStartDate) {
        provider.setStartDate(picked);
      } else {
        provider.setEndDate(picked);
      }
    }
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return '--:--';
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt); // '10:00 AM'
  }

  bool isSameDate(DateTime? d1, DateTime? d2) {
    if (d1 == null || d2 == null) return false;
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  bool isEndAfterStart(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes > startMinutes;
  }

  Future<void> _pickTime({required bool isStart}) async {
    final DateTimeProvider provider =
        Provider.of<DateTimeProvider>(context, listen: false);
    final TimeOfDay initial = isStart
        ? (provider.startTime ?? TimeOfDay.now())
        : (provider.endTime ?? TimeOfDay.now());

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!);
      },
    );

    if (picked != null) {
      if (isStart) {
        provider.setStartTime(picked);
      } else {
        if (isSameDate(provider.startDate, provider.endDate) &&
            provider.startTime != null &&
            !isEndAfterStart(provider.startTime!, picked)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("End time must be after start time")),
          );
          return;
        }
        provider.setEndTime(picked);
      }
    }
  }

  String _formatAddressWithEllipsis(String address) {
  if (address.isEmpty) return '';
  
  List<String> parts = address.split(',');
  if (parts.length <= 1) return address; // Return as is if no commas
  
  // Return first segment followed by ellipsis
  return '${parts[0]}...';
  
  // Alternative: If you want to show first segment + few characters from second segment:
  // String secondPart = parts.length > 1 && parts[1].trim().isNotEmpty ? 
  //     parts[1].trim() : '';
  // return '${parts[0]}, ${secondPart.length > 10 ? secondPart.substring(0, 10) + '...' : secondPart}';
}

  @override
  Widget build(BuildContext context) {
    final List<String> carouselImages = [
      'assets/home.png',
      'assets/home_slide1.jpg',
      'assets/home_slide2.jpg',
    ];
    final bookingProvider = Provider.of<BookingProvider>(context);
    final recentBooking = bookingProvider.recentBooking;
    final isLoading = bookingProvider.isLoading;
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine if device is in landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Scale factors for responsive sizing
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final cars = context.watch<CarProvider>().cars;

    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
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
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.home, color: Color(0XFF120698), size: 24),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: const Color(0XFF120698),
                      fontSize: 14 * textScaleFactor,
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
                  MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
                );
              },
              icon: const Icon(Icons.person, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              screenWidth * 0.03, screenHeight * 0.015, screenWidth * 0.03, 0),
          child: Consumer<DateTimeProvider>(
            builder: (context, dateTimeProvider, _) {
              return ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 24,
                            color: Color(0XFF120698),
                          ),
                          SizedBox(width: screenWidth * 0.01),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
     Text(
      'Your Location',
      style: TextStyle(fontSize: 12 * textScaleFactor),
    ),
    Text(
      _formatAddressWithEllipsis(_address),
      style:  TextStyle(fontSize: 12 * textScaleFactor),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  ],
),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InviteFriendsScreen()));
                              },
                              icon: Icon(Icons.card_giftcard_outlined)),
                          SizedBox(width: screenWidth * 0.02),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WalletScreen()));
                              },
                              icon: Icon(Icons.wallet)),
                          SizedBox(width: screenWidth * 0.01),
                          // Text('₹200',
                          //     style: TextStyle(fontSize: 14 * textScaleFactor)),
                          SizedBox(width: screenWidth * 0.01),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.06,
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0XFF120698),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                            ),
                            child: _localImageUrl != null
                                ? ClipOval(
                                    child: Image.network(
                                      _localImageUrl!,
                                      width: 50, // Set width/height as needed
                                      height: 50,
                                      fit: BoxFit
                                          .fill, // Change to BoxFit.contain if needed
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://avatar.iran.liara.run/public/boy?username=Ash'),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Rest of the UI remains unchanged
                  SizedBox(height: screenHeight * 0.02),
                  HomeCarousel(
                    height: screenHeight * 0.18,
                    imageAssets: carouselImages,
                    autoPlayDuration: const Duration(seconds: 5),
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
                      // Calendar icon
                      if (index == 4) {
                        return GestureDetector(
                          onTap: () => _selectFromCalendar(isStartDate: true),
                          child: Stack(
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
                                margin: const EdgeInsets.only(top: 4),
                                height: 80,
                                width: 55,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: const Icon(Icons.calendar_month_sharp),
                              ),
                            ],
                          ),
                        );
                      }

                      // Generate today + next 4 days
                      DateTime date = DateTime.now().add(Duration(days: index));
                      String day = DateFormat('d').format(date);
                      String month = DateFormat('MMM').format(date);

                      // Highlight only if selectedDate matches this card's date
                      bool isSelectedCard =
                          dateTimeProvider.startDate != null &&
                              _isSameDate(date, dateTimeProvider.startDate!);

                      return GestureDetector(
                        onTap: () {
                          dateTimeProvider.setStartDate(date);
                        },
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 6,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: isSelectedCard
                                      ? const Color(0XFFDCDCDC)
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 80,
                              width: 60,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelectedCard
                                    ? const Color(0XFF120698)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    day,
                                    style: TextStyle(
                                      color: isSelectedCard
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    month,
                                    style: TextStyle(
                                      color: isSelectedCard
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (dateTimeProvider.startDate != null)
                            Text(
                              'Start Date: ${DateFormat('d MMM y').format(dateTimeProvider.startDate!)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (dateTimeProvider.endDate != null)
                            Text(
                              'End Date: ${DateFormat('d MMM y').format(dateTimeProvider.endDate!)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                        ],
                      ),
                      if (dateTimeProvider.startDate != null)
                        TextButton(
                          onPressed: () =>
                              _selectFromCalendar(isStartDate: false),
                          child: Text(
                            dateTimeProvider.endDate == null
                                ? "Select End Date"
                                : "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Start Time
                      GestureDetector(
                        onTap: () => _pickTime(isStart: true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF120698),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              Text(formatTime(dateTimeProvider.startTime),
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Duration and arrow
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Duration',
                              style: TextStyle(color: Colors.black)),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  height: 2, width: 90, color: Colors.black54),
                              Transform.translate(
                                offset: const Offset(-5, 0),
                                child: const Icon(Icons.arrow_forward,
                                    size: 25, color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      // End Time
                      GestureDetector(
                        onTap: () => _pickTime(isStart: false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF120698),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              Text(formatTime(dateTimeProvider.endTime),
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
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
                  // Replace your current RecentBookingCard line with this:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : recentBooking != null
                          ? RecentBookingCard(booking: recentBooking)
                          : const Center(
                              child: Text(
                                'No recent bookings found',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Rent a car',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CarListScreen()));
                          },
                          child: const Text(
                            'View all',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        height: 263,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 5),
                          ],
                          color: Colors.white,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => BookingConfirmationScreen(
                                  carImageUrl: cars[0].image[0],
                                  carName: cars[0].name,
                                  pricePerDay: cars[0].pricePerHour,
                                  carId: cars[0].id,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  cars[0].image[0],
                                  width: double.infinity,
                                  height: 263,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF8A935D),
                                        Color(0xFF4A522B)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    cars[0].location,
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
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    color: Color.fromARGB(255, 160, 160, 160),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cars[0].name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '₹${cars[0].pricePerHour} / hr',
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
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
