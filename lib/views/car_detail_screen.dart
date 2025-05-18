// import 'package:car_rental_app/controllers/car_controller.dart';
// import 'package:car_rental_app/models/car_model.dart';
// import 'package:car_rental_app/providers/car_provider.dart';
// import 'package:car_rental_app/services/api/car_service.dart';
// import 'package:flutter/material.dart';

// class CarDetailsScreen extends StatefulWidget {
//   final String carId;
//   const CarDetailsScreen({super.key, required this.carId});

//   @override
//   State<CarDetailsScreen> createState() => _CarDetailsScreenState();
// }

// class _CarDetailsScreenState extends State<CarDetailsScreen> {
//   late Future<Car> _carFuture;
//   final CarController _controller = CarController(CarProvider(), CarService());

//   @override
//   void initState() {
//     super.initState();
//     _carFuture = _controller.getCarDetails(widget.carId);
//   }

//   int selectedImageIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//         title: const Text('Car Details', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: FutureBuilder<Car>(
//           future: _carFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }

//             final car = snapshot.data!;
//             final carImage = car.image;
//             print(carImage);

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 257,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.grey[300],
//                     ),
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(
//                             carImage,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 8,
//                           left: 0,
//                           right: 0,
//                           child: SizedBox(
//                             height: 60,
//                             child: ListView.separated(
//                               scrollDirection: Axis.horizontal,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               itemCount: 4,
//                               separatorBuilder: (_, __) =>
//                                   const SizedBox(width: 8),
//                               itemBuilder: (_, index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedImageIndex = index;
//                                     });
//                                   },
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(4),
//                                     child: Image.network(
//                                       carImage,
//                                       width: 63,
//                                       height: 34,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Car Details
//                   Text(
//                     car.name,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${car.seats} seater | ${car.fuel} | ${car.type}',
//                     style: TextStyle(color: Colors.grey),
//                   ),

//                   const SizedBox(height: 16),

//                   // Uploaded Documents
//                   const Text(
//                     "Uploaded Documents",
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Container(
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   // Location & Time
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Color(0XFF120698),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             const Expanded(
//                               child: Text(
//                                 'Hyderabad Bus stand, Kphb phase9, Kukatpally, Hyderabad',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 10),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: const Row(
//                                 children: [
//                                   Icon(
//                                     Icons.access_time,
//                                     size: 16,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     "10:00 AM",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Container(
//                                       height: 2,
//                                       width: 90,
//                                       color: Colors.white,
//                                     ),
//                                     Transform.translate(
//                                       offset: const Offset(-5, 0),
//                                       child: const Icon(
//                                         Icons.arrow_forward,
//                                         size: 25,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(width: 8),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: const Row(
//                                 children: [
//                                   Icon(
//                                     Icons.access_time,
//                                     size: 16,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     "10:00 AM",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Pickup location",
//                               style: TextStyle(fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(height: 6),
//                             Text(
//                               "Pickup and return same location\nHyderabad Bus Stand, KPHB, Kukatpally",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Container(
//                         width: 152,
//                         height: 93,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               "https://s3-alpha-sig.figma.com/img/77d8/3866/6b389d6ccba22bf54d38042f2e7ee3e3?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ex9csb8IkFJrAgcSSWddKQTLdZ4MReezR6scrrLL8Q0CvIgJHqdgvUAKGjkHRe6xwxyoELntVykRJBUioQ3a1s35SxWPi7npqcD4s-5bJ4rvZuupQCITK6hU4jeu32fehiad3rViDHBl9YujWolZT45FOwEe~mbt3ZbRrY~6S2FVWGg~zCccALi6rVEgOyioEEiHzIs8I8arNWLxoMlTyp5k6I7vesdPY-ZMKGjCzel-duYmDo7NfrQweThNhMGbC~yQ2bfBN7K6QnWY6IJIZM-sFNPV9NEvumGPlJKfiezcxCwjn~MRuwy8osbc1PKPGl0bIwCydROOZy-MfqmE8Q__",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   // Security Deposit
//                   const Text(
//                     "Security Deposit",
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: "Bike, Laptop, Cash",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 16),
//                   RichText(
//                     textAlign: TextAlign.start,
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Note: ',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         TextSpan(
//                           text:
//                               'Submit the bike in uploaded rc same otherwise it is not Accepted',
//                           style: TextStyle(color: Colors.black, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Booking Details
//                   const Text(
//                     "Booking details",
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [Text("Price"), Text("₹ 1700")],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [Text("Wallet"), Text("₹ 1700")],
//                   ),
//                   const Divider(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text("Total",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text(
//                         "₹ 1500",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.indigo,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 80),
//                 ],
//               ),
//             );
//           }),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return Dialog(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Image.network(
//                           "https://s3-alpha-sig.figma.com/img/0515/9dbe/5c5eae16ac8914c3cc0b19f1dc721c2b?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TW2GeARkUMivi7jcZAkvqckUlKVTBdt7Ul58CI6Vyhnd4vmFYjT8HoOUWmG-oMT4BLaO1V-dvYu2f8QJsXMassikULxE5Eu2Uc2NOORHi97Png0Qt6vzwKww2gf-3sYKCIOS4yIl-5wX7MC6swWdo9zl66zjxHZVSANiIHh3QktEYDqqjlPuv2PoaSR4~JAIhpg6koxYCIoknbx~nfkM9D9ITvvjZLAvCx44TzP-I2cliACiSlU2LwlLh0isFHvNGgo3yqbbHbZTBgMjZ1ZmISA~WY2uvLhtG1kLHdETA7--bs4SNct4E1wlt~UNbs-6MWt6KArKTgxPJmtC9rDLVg__",
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           'Your Booking is confirmed',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(); // Close the dialog
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueAccent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 32,
//                               vertical: 12,
//                             ),
//                           ),
//                           child: const Text("Apply"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0XFF120698),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 14),
//           ),
//           child: const Text(
//             "Proceed",
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:car_rental_app/controllers/car_controller.dart';
// import 'package:car_rental_app/models/booking_model.dart';
// import 'package:car_rental_app/models/car_model.dart';
// import 'package:car_rental_app/providers/booking_provider.dart';
// import 'package:car_rental_app/providers/car_provider.dart';
// import 'package:car_rental_app/services/api/car_service.dart';
// import 'package:flutter/material.dart';

// class CarDetailsScreen extends StatefulWidget {
//   final String userId;
//   final String bookingId;

//   const CarDetailsScreen(
//       {super.key, required this.userId, required this.bookingId});

//   @override
//   State<CarDetailsScreen> createState() => _CarDetailsScreenState();
// }

// class _CarDetailsScreenState extends State<CarDetailsScreen> {
//   late Future<Booking> _bookingFuture;
//   final CarController _controller = CarController(CarProvider(), CarService());
//   final BookingProvider _bookingProvider = BookingProvider();

//   @override
//   void initState() {
//     super.initState();
//     _bookingFuture =
//         _bookingProvider.bookingSummary(widget.userId, widget.bookingId);
//   }

//   int selectedImageIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     // Get MediaQuery data for responsive design
//     final mediaQuery = MediaQuery.of(context);
//     final screenHeight = mediaQuery.size.height;
//     final screenWidth = mediaQuery.size.width;
//     final padding = mediaQuery.padding;
//     final isSmallScreen = screenWidth < 360;

//     // Define responsive sizes
//     final defaultPadding = isSmallScreen ? 12.0 : 16.0;
//     final smallSpacing = isSmallScreen ? 6.0 : 8.0;
//     final mediumSpacing = isSmallScreen ? 12.0 : 16.0;
//     final largeSpacing = isSmallScreen ? 16.0 : 20.0;

//     // Adjust font sizes
//     final smallText = isSmallScreen ? 10.0 : 12.0;
//     final bodyText = isSmallScreen ? 12.0 : 14.0;
//     final titleText = isSmallScreen ? 14.0 : 16.0;
//     final headerText = isSmallScreen ? 16.0 : 18.0;

//     // Compute image sizes
//     final mainImageHeight = screenHeight * 0.28;
//     final thumbnailHeight = screenHeight * 0.05;
//     final thumbnailWidth = screenWidth * 0.15;
//     final mapImageWidth = screenWidth * 0.35;
//     final mapImageHeight = screenHeight * 0.12;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text('Car Details',
//             style: TextStyle(color: Colors.black, fontSize: titleText + 2)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: FutureBuilder<Car>(
//           future: _carFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }

//             final car = snapshot.data!;
//             final carImage = car.image;

//             return SingleChildScrollView(
//               padding: EdgeInsets.all(defaultPadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Main car image with thumbnails
//                   Container(
//                     height: mainImageHeight,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.grey[300],
//                     ),
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(
//                             carImage,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 Container(
//                               color: Colors.grey.shade300,
//                               child: Icon(Icons.error, size: screenWidth * 0.1),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: smallSpacing,
//                           left: 0,
//                           right: 0,
//                           child: SizedBox(
//                             height: thumbnailHeight + smallSpacing * 2,
//                             child: ListView.separated(
//                               scrollDirection: Axis.horizontal,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: defaultPadding),
//                               itemCount: 4,
//                               separatorBuilder: (_, __) =>
//                                   SizedBox(width: smallSpacing),
//                               itemBuilder: (_, index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedImageIndex = index;
//                                     });
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(4),
//                                       border: selectedImageIndex == index
//                                           ? Border.all(
//                                               color: Colors.white, width: 2)
//                                           : null,
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(4),
//                                       child: Image.network(
//                                         carImage,
//                                         width: thumbnailWidth,
//                                         height: thumbnailHeight,
//                                         fit: BoxFit.cover,
//                                         errorBuilder:
//                                             (context, error, stackTrace) =>
//                                                 Container(
//                                           color: Colors.grey.shade400,
//                                           width: thumbnailWidth,
//                                           height: thumbnailHeight,
//                                           child: Icon(Icons.error,
//                                               size: thumbnailWidth * 0.4),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: mediumSpacing),

//                   // Car Details
//                   Text(
//                     car.name,
//                     style: TextStyle(
//                         fontSize: headerText, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: smallSpacing / 2),
//                   Text(
//                     '${car.seats} seater | ${car.fuel} | ${car.type}',
//                     style: TextStyle(color: Colors.grey, fontSize: bodyText),
//                   ),

//                   SizedBox(height: mediumSpacing),

//                   // Uploaded Documents
//                   Text(
//                     "Uploaded Documents",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600, fontSize: titleText),
//                   ),
//                   SizedBox(height: smallSpacing),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: screenHeight * 0.07,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: smallSpacing),
//                       Expanded(
//                         child: Container(
//                           height: screenHeight * 0.07,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: mediumSpacing),

//                   // Location & Time
//                   Container(
//                     padding: EdgeInsets.all(defaultPadding),
//                     decoration: BoxDecoration(
//                       color: const Color(0XFF120698),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Hyderabad Bus stand, Kphb phase9, Kukatpally, Hyderabad',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: smallText),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: smallSpacing),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             // Start time
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: defaultPadding * 0.6,
//                                 vertical: smallSpacing * 0.75,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.access_time,
//                                     size: bodyText + 2,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: smallSpacing / 2),
//                                   Text(
//                                     "10:00 AM",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: bodyText),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Arrow between times
//                             SizedBox(width: smallSpacing),
//                             Flexible(
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Flexible(
//                                     child: Container(
//                                       height: 2,
//                                       width: screenWidth * 0.2,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Transform.translate(
//                                     offset: const Offset(-5, 0),
//                                     child: Icon(
//                                       Icons.arrow_forward,
//                                       size: bodyText + 6,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // End time
//                             SizedBox(width: smallSpacing),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: defaultPadding * 0.6,
//                                 vertical: smallSpacing * 0.75,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.access_time,
//                                     size: bodyText + 2,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: smallSpacing / 2),
//                                   Text(
//                                     "10:00 AM",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: bodyText),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: largeSpacing),

//                   // Pickup location with map
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Pickup location",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: bodyText),
//                             ),
//                             SizedBox(height: smallSpacing * 0.75),
//                             Text(
//                               "Pickup and return same location\nHyderabad Bus Stand, KPHB, Kukatpally",
//                               style: TextStyle(
//                                   color: Colors.grey, fontSize: smallText),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: defaultPadding * 0.75),
//                       Container(
//                         width: mapImageWidth,
//                         height: mapImageHeight,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               "https://s3-alpha-sig.figma.com/img/77d8/3866/6b389d6ccba22bf54d38042f2e7ee3e3?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ex9csb8IkFJrAgcSSWddKQTLdZ4MReezR6scrrLL8Q0CvIgJHqdgvUAKGjkHRe6xwxyoELntVykRJBUioQ3a1s35SxWPi7npqcD4s-5bJ4rvZuupQCITK6hU4jeu32fehiad3rViDHBl9YujWolZT45FOwEe~mbt3ZbRrY~6S2FVWGg~zCccALi6rVEgOyioEEiHzIs8I8arNWLxoMlTyp5k6I7vesdPY-ZMKGjCzel-duYmDo7NfrQweThNhMGbC~yQ2bfBN7K6QnWY6IJIZM-sFNPV9NEvumGPlJKfiezcxCwjn~MRuwy8osbc1PKPGl0bIwCydROOZy-MfqmE8Q__",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: mediumSpacing),

//                   // Security Deposit
//                   Text(
//                     "Security Deposit",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600, fontSize: titleText),
//                   ),
//                   SizedBox(height: smallSpacing),
//                   TextField(
//                     style: TextStyle(fontSize: bodyText),
//                     decoration: InputDecoration(
//                       hintText: "Bike, Laptop, Cash",
//                       hintStyle: TextStyle(fontSize: bodyText),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: defaultPadding,
//                         vertical: smallSpacing,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),

//                   SizedBox(height: mediumSpacing),

//                   // Note
//                   RichText(
//                     textAlign: TextAlign.start,
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Note: ',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                             fontSize: bodyText,
//                           ),
//                         ),
//                         TextSpan(
//                           text:
//                               'Submit the bike in uploaded rc same otherwise it is not Accepted',
//                           style: TextStyle(
//                               color: Colors.black, fontSize: bodyText),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: mediumSpacing),

//                   // Booking Details
//                   Text(
//                     "Booking details",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600, fontSize: titleText),
//                   ),
//                   SizedBox(height: defaultPadding * 0.75),

//                   // Price details
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Price", style: TextStyle(fontSize: bodyText)),
//                       Text("₹ 1700", style: TextStyle(fontSize: bodyText))
//                     ],
//                   ),
//                   SizedBox(height: smallSpacing / 2),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Wallet", style: TextStyle(fontSize: bodyText)),
//                       Text("₹ 1700", style: TextStyle(fontSize: bodyText))
//                     ],
//                   ),
//                   Divider(height: largeSpacing),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Total",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: bodyText),
//                       ),
//                       Text(
//                         "₹ 1500",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.indigo,
//                           fontSize: bodyText,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Bottom padding to account for the fixed button
//                   SizedBox(height: screenHeight * 0.1),
//                 ],
//               ),
//             );
//           }),

//       // Fixed button at bottom
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(defaultPadding),
//         height: screenHeight * 0.1,
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 final dialogWidth = screenWidth * 0.8;

//                 return Dialog(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(defaultPadding * 1.25),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Image.network(
//                           "https://s3-alpha-sig.figma.com/img/0515/9dbe/5c5eae16ac8914c3cc0b19f1dc721c2b?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TW2GeARkUMivi7jcZAkvqckUlKVTBdt7Ul58CI6Vyhnd4vmFYjT8HoOUWmG-oMT4BLaO1V-dvYu2f8QJsXMassikULxE5Eu2Uc2NOORHi97Png0Qt6vzwKww2gf-3sYKCIOS4yIl-5wX7MC6swWdo9zl66zjxHZVSANiIHh3QktEYDqqjlPuv2PoaSR4~JAIhpg6koxYCIoknbx~nfkM9D9ITvvjZLAvCx44TzP-I2cliACiSlU2LwlLh0isFHvNGgo3yqbbHbZTBgMjZ1ZmISA~WY2uvLhtG1kLHdETA7--bs4SNct4E1wlt~UNbs-6MWt6KArKTgxPJmtC9rDLVg__",
//                           width: dialogWidth * 0.6,
//                           height: screenHeight * 0.15,
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) => Icon(
//                             Icons.check_circle,
//                             size: dialogWidth * 0.3,
//                             color: Colors.green,
//                           ),
//                         ),
//                         SizedBox(height: mediumSpacing),
//                         Text(
//                           'Your Booking is confirmed',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: titleText),
//                         ),
//                         SizedBox(height: largeSpacing),
//                         SizedBox(
//                           width: dialogWidth * 0.5,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).pop(); // Close the dialog
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blueAccent,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: defaultPadding * 2,
//                                 vertical: defaultPadding * 0.75,
//                               ),
//                             ),
//                             child: Text(
//                               "Apply",
//                               style: TextStyle(fontSize: bodyText),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0XFF120698),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.9),
//           ),
//           child: Text(
//             "Proceed",
//             style: TextStyle(fontSize: titleText, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:car_rental_app/controllers/car_controller.dart';
import 'package:car_rental_app/models/booking_model.dart';
import 'package:car_rental_app/models/booking_summary_model.dart';
import 'package:car_rental_app/providers/booking_summary_provider.dart';
import 'package:car_rental_app/providers/car_provider.dart';
import 'package:car_rental_app/services/api/car_service.dart';
import 'package:car_rental_app/views/extended_date_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

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
  final BookingSummaryProvider _bookingSummaryProvider = BookingSummaryProvider();

  @override
  void initState() {
    super.initState();
  _bookingFuture = _bookingSummaryProvider.fetchBookingSummary(widget.userId, widget.bookingId);
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
            final startDate =
                DateFormat('MMM dd, yyyy').format(booking.booking.rentalEndDate);
            final endDate =
                DateFormat('MMM dd, yyyy').format(booking.booking.rentalEndDate);

            // Format times for display
            final startTime =
                DateFormat('h:mm a').format(booking.booking.rentalStartDate);
            final endTime = DateFormat('h:mm a').format(booking.booking.rentalEndDate);

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
                      color: booking.booking.isPending
                          ? Colors.orange.shade100
                          : booking.booking.isCompleted
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      booking.booking.status,
                      style: TextStyle(
                        color: booking.booking.isPending
                            ? Colors.orange.shade800
                            : booking.booking.isCompleted
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "ID Proof",
                              style: TextStyle(fontSize: smallText),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: smallSpacing),
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "License",
                              style: TextStyle(fontSize: smallText),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: mediumSpacing),

                  // Location & Time
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: const Color(0XFF120698),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "dfdfgdfd",
                                // booking.pickupLocation.address,
                                style: TextStyle(
                                    color: Colors.white, fontSize: smallText),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ExtendDatePage()));
                                },
                                icon: const Icon(Icons.edit_rounded,
                                    color: Colors.white, size: 20))
                          ],
                        ),
                        SizedBox(height: smallSpacing),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    Icons.access_time,
                                    size: bodyText + 2,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: smallSpacing / 2),
                                  Text(
                                    startTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: bodyText),
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
                                    Icons.access_time,
                                    size: bodyText + 2,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: smallSpacing / 2),
                                  Text(
                                    endTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: bodyText),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: smallSpacing),
                        // Add dates
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              startDate,
                              style: TextStyle(
                                  color: Colors.white, fontSize: smallText),
                            ),
                            Text(
                              endDate,
                              style: TextStyle(
                                  color: Colors.white, fontSize: smallText),
                            ),
                          ],
                        ),
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
                            Text(
                              "lfffdfd",
                              // "Pickup and return same location\n${booking.pickupLocation.address}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: smallText),
                            ),
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
                            image: NetworkImage(
                              "https://s3-alpha-sig.figma.com/img/77d8/3866/6b389d6ccba22bf54d38042f2e7ee3e3?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ex9csb8IkFJrAgcSSWddKQTLdZ4MReezR6scrrLL8Q0CvIgJHqdgvUAKGjkHRe6xwxyoELntVykRJBUioQ3a1s35SxWPi7npqcD4s-5bJ4rvZuupQCITK6hU4jeu32fehiad3rViDHBl9YujWolZT45FOwEe~mbt3ZbRrY~6S2FVWGg~zCccALi6rVEgOyioEEiHzIs8I8arNWLxoMlTyp5k6I7vesdPY-ZMKGjCzel-duYmDo7NfrQweThNhMGbC~yQ2bfBN7K6QnWY6IJIZM-sFNPV9NEvumGPlJKfiezcxCwjn~MRuwy8osbc1PKPGl0bIwCydROOZy-MfqmE8Q__",
                            ),
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

                  SizedBox(height: mediumSpacing),

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
                      Text("Price", style: TextStyle(fontSize: bodyText)),
                      Text("₹ ${booking.booking.totalPrice}",
                          style: TextStyle(fontSize: bodyText))
                    ],
                  ),
                  SizedBox(height: smallSpacing / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Wallet", style: TextStyle(fontSize: bodyText)),
                      Text("₹ 0", style: TextStyle(fontSize: bodyText))
                    ],
                  ),
                  Divider(height: largeSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: bodyText),
                      ),
                      Text(
                        "₹ ${booking.booking.totalPrice}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                          fontSize: bodyText,
                        ),
                      ),
                    ],
                  ),

                  // Payment status
                  SizedBox(height: smallSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Status",
                        style: TextStyle(fontSize: bodyText),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: smallSpacing, vertical: 2),
                        decoration: BoxDecoration(
                          color: booking.booking.paymentStatus.toLowerCase() == 'paid'
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          booking.booking.paymentStatus,
                          style: TextStyle(
                            color: booking.booking.paymentStatus.toLowerCase() == 'paid'
                                ? Colors.green.shade800
                                : Colors.orange.shade800,
                            fontSize: smallText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // OTP section (only show if booking is pending)
                  if (booking.booking.isPending) ...[
                    SizedBox(height: mediumSpacing),
                    Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your OTP for pickup",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: bodyText,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          SizedBox(height: smallSpacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${booking.booking.otp}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: headerText + 2,
                                  letterSpacing: 8,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: smallSpacing),
                          Text(
                            "Share this OTP with the rental agent when picking up your car",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: smallText,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

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
