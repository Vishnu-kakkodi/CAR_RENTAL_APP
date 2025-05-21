import 'package:car_rental_app/controllers/car_controller.dart';
import 'package:car_rental_app/models/booking_model.dart';
import 'package:car_rental_app/models/booking_summary_model.dart';
import 'package:car_rental_app/providers/booking_summary_provider.dart';
import 'package:car_rental_app/providers/car_provider.dart';
import 'package:car_rental_app/providers/document_provider.dart';
import 'package:car_rental_app/services/api/car_service.dart';
import 'package:car_rental_app/views/extended_date_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For date formatting

class CarDetailsScreen extends StatefulWidget {
  final String userId;
  final String bookingId;

  const CarDetailsScreen(
      {super.key, required this.userId, required this.bookingId});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  late Future<BookingSummary> _bookingFuture;
  final CarController _controller = CarController(CarProvider(), CarService());
  final BookingSummaryProvider _bookingSummaryProvider =
      BookingSummaryProvider();
  late String userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserIdAndFetchDocuments();

    _bookingFuture = _bookingSummaryProvider.fetchBookingSummary(
        widget.userId, widget.bookingId);
  }

  Future<void> _getUserIdAndFetchDocuments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId') ?? '';

      if (userId.isNotEmpty) {
        await Provider.of<DocumentProvider>(context, listen: false)
            .fetchDocuments(userId);
      } else {
        print('User ID not found in SharedPreferences');
      }
    } catch (e) {
      print('Error getting user ID: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  int selectedImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Get MediaQuery data for responsive design
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final padding = mediaQuery.padding;
    final isSmallScreen = screenWidth < 360;

    // Define responsive sizes
    final defaultPadding = isSmallScreen ? 12.0 : 16.0;
    final smallSpacing = isSmallScreen ? 6.0 : 8.0;
    final mediumSpacing = isSmallScreen ? 12.0 : 16.0;
    final largeSpacing = isSmallScreen ? 16.0 : 20.0;

    // Adjust font sizes
    final smallText = isSmallScreen ? 10.0 : 12.0;
    final bodyText = isSmallScreen ? 12.0 : 14.0;
    final titleText = isSmallScreen ? 14.0 : 16.0;
    final headerText = isSmallScreen ? 16.0 : 18.0;

    // Compute image sizes
    final mainImageHeight = screenHeight * 0.28;
    final thumbnailHeight = screenHeight * 0.05;
    final thumbnailWidth = screenWidth * 0.15;
    final mapImageWidth = screenWidth * 0.35;
    final mapImageHeight = screenHeight * 0.12;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Booking Summary',
            style: TextStyle(color: Colors.black, fontSize: titleText + 2)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<BookingSummary>(
          future: _bookingFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No booking data available'));
            }

            final booking = snapshot.data!;
            final car = booking.car;
            final carImage = car.image[0];

            // Format dates for display
            final startDate = DateFormat('MMM dd, yyyy')
                .format(booking.booking.rentalEndDate);
            final endDate = DateFormat('MMM dd, yyyy')
                .format(booking.booking.rentalEndDate);

            // Format times for display
            final startTime =
                DateFormat('h:mm a').format(booking.booking.rentalStartDate);
            final endTime =
                DateFormat('h:mm a').format(booking.booking.rentalEndDate);

            return SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main car image with thumbnails
                  Container(
                    height: mainImageHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            carImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey.shade300,
                              child: Icon(Icons.error, size: screenWidth * 0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: smallSpacing,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            height: thumbnailHeight + smallSpacing * 2,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              itemCount: 4,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: smallSpacing),
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImageIndex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: selectedImageIndex == index
                                          ? Border.all(
                                              color: Colors.white, width: 2)
                                          : null,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        carImage,
                                        width: thumbnailWidth,
                                        height: thumbnailHeight,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          color: Colors.grey.shade400,
                                          width: thumbnailWidth,
                                          height: thumbnailHeight,
                                          child: Icon(Icons.error,
                                              size: thumbnailWidth * 0.4),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mediumSpacing),

                  // Car Details
                  Text(
                    car.name,
                    style: TextStyle(
                        fontSize: headerText, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: smallSpacing / 2),
                  Text(
                    '${car.seats} seater | ${car.fuel} | ${car.type}',
                    style: TextStyle(color: Colors.grey, fontSize: bodyText),
                  ),

                  SizedBox(height: mediumSpacing),

                  // Booking Status
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: smallSpacing, vertical: smallSpacing / 2),
                    decoration: BoxDecoration(
                      color: (booking.booking.paymentStatus == "pending")
                          ? Colors.orange.shade100
                          : (booking.booking.paymentStatus == "completed")
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      booking.booking.paymentStatus,
                      style: TextStyle(
                        color: (booking.booking.paymentStatus == "pending")
                            ? Colors.orange.shade800
                            : (booking.booking.paymentStatus == "completed")
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                        fontSize: smallText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: mediumSpacing),

                  // Uploaded Documents
                  Text(
                    "Uploaded Documents",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: titleText),
                  ),
                  SizedBox(height: smallSpacing),

                  Consumer<DocumentProvider>(
                    builder: (context, documentProvider, child) {
                      final documents = documentProvider.uploadedDocuments;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 170,
                            height: 84,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                documents!.aadharCard.url,
                                fit: BoxFit.cover,
                                width: 170,
                                height: 84,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.broken_image,
                                          color: Colors.grey),
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 170,
                            height: 84,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                documents!.aadharCard
                                    .url, // You might want to use a different document here
                                fit: BoxFit.cover,
                                width: 170,
                                height: 84,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.broken_image,
                                          color: Colors.grey),
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: mediumSpacing),

                  // Location & Time
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: const Color(0XFF120698),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hyderabad Bus satand, Kphb pahse9, Kukatpally, Hyderabad",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: smallSpacing),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Start time
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 0.6,
                                      vertical: smallSpacing * 0.75,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          size: bodyText + 6,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: smallSpacing / 2),
                                        Text(
                                          startTime,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: bodyText,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Arrow between times
                                  SizedBox(width: smallSpacing),
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            height: 2,
                                            width: screenWidth * 0.2,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(-5, 0),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: bodyText + 6,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // End time
                                  SizedBox(width: smallSpacing),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 0.6,
                                      vertical: smallSpacing * 0.75,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          size: bodyText + 6,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: smallSpacing / 2),
                                        Text(
                                          endTime,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: bodyText,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExtendDatePage()),
                            );
                          },
                          child: Container(
                            width: 40, // Adjust size as needed
                            height: 40, // Adjust size as needed
                            child: Center(
                              child: Image.asset(
                                "assets/tabler_edit.png",
                                width: 40, // Adjust size as needed
                                height: 40, // Adjust size as needed
                                color: Colors.white, // Makes the icon white
                              ),
                            ),
                          ),
                        )
                        // IconButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const ExtendDatePage()),
                        //     );
                        //   },
                        //   icon: const Icon(Icons.edit_rounded,
                        //       color: Colors.white, size: 20),
                        // ),
                      ],
                    ),
                  ),

                  SizedBox(height: largeSpacing),

                  // Pickup location with map
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pickup location",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: bodyText),
                            ),
                            SizedBox(height: smallSpacing * 0.75),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Pickup and return same\nlocation\n",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14, // First part with size 14
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.fontFamily,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\n${booking.booking.pickupLocation}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12, // Second part with size 12
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: defaultPadding * 0.75),
                      Container(
                        width: mapImageWidth,
                        height: mapImageHeight,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage("assets/map.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: mediumSpacing),

                  // Security Deposit
                  Text(
                    "Security Deposit",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: titleText),
                  ),
                  SizedBox(height: smallSpacing),
                  TextField(
                    style: TextStyle(fontSize: bodyText),
                    decoration: InputDecoration(
                      hintText: "Bike, Laptop, Cash",
                      hintStyle: TextStyle(fontSize: bodyText),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: smallSpacing,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  SizedBox(height: mediumSpacing),

                  // Note
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Note: ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: bodyText,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Submit the bike in uploaded rc same otherwise it is not Accepted',
                          style: TextStyle(
                              color: Colors.black, fontSize: bodyText),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Booking Details
                  Text(
                    "Booking details",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: titleText),
                  ),
                  SizedBox(height: defaultPadding * 0.75),

                  // Price details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price",
                          style: TextStyle(
                              fontSize: bodyText, fontWeight: FontWeight.bold)),
                      Text("₹ ${booking.booking.totalPrice}",
                          style: TextStyle(
                              fontSize: bodyText, fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: smallSpacing / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Wallet",
                          style: TextStyle(
                              fontSize: bodyText, fontWeight: FontWeight.bold)),
                      Text("₹ 0",
                          style: TextStyle(
                              fontSize: bodyText, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Divider(height: largeSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 15, 9, 196),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "₹ ${booking.booking.totalPrice}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 15, 9, 196),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Bottom padding to account for the fixed button
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            );
          }),

      // Fixed button at bottom - only show for pending bookings
      bottomNavigationBar: FutureBuilder<BookingSummary>(
        future: _bookingFuture,
        builder: (context, snapshot) {
          // Only show the button if we have data and the booking is pending
          if (snapshot.hasData && snapshot.data!.booking.isPending) {
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              height: screenHeight * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      final dialogWidth = screenWidth * 0.8;

                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding * 1.25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                "https://s3-alpha-sig.figma.com/img/0515/9dbe/5c5eae16ac8914c3cc0b19f1dc721c2b?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TW2GeARkUMivi7jcZAkvqckUlKVTBdt7Ul58CI6Vyhnd4vmFYjT8HoOUWmG-oMT4BLaO1V-dvYu2f8QJsXMassikULxE5Eu2Uc2NOORHi97Png0Qt6vzwKww2gf-3sYKCIOS4yIl-5wX7MC6swWdo9zl66zjxHZVSANiIHh3QktEYDqqjlPuv2PoaSR4~JAIhpg6koxYCIoknbx~nfkM9D9ITvvjZLAvCx44TzP-I2cliACiSlU2LwlLh0isFHvNGgo3yqbbHbZTBgMjZ1ZmISA~WY2uvLhtG1kLHdETA7--bs4SNct4E1wlt~UNbs-6MWt6KArKTgxPJmtC9rDLVg__",
                                width: dialogWidth * 0.6,
                                height: screenHeight * 0.15,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.check_circle,
                                  size: dialogWidth * 0.3,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: mediumSpacing),
                              Text(
                                'Your Booking is confirmed',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: titleText),
                              ),
                              SizedBox(height: largeSpacing),
                              SizedBox(
                                width: dialogWidth * 0.5,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 2,
                                      vertical: defaultPadding * 0.75,
                                    ),
                                  ),
                                  child: Text(
                                    "Done",
                                    style: TextStyle(fontSize: bodyText),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF120698),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.9),
                ),
                child: Text(
                  "Proceed",
                  style: TextStyle(fontSize: titleText, color: Colors.white),
                ),
              ),
            );
          } else {
            // Return an empty container if no button is needed
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
