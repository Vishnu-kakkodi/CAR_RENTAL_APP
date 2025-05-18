// import 'package:car_rental_app/controllers/car_controller.dart';
// import 'package:car_rental_app/models/booking_model.dart';
// import 'package:car_rental_app/providers/booking_provider.dart';
// import 'package:car_rental_app/providers/car_provider.dart';
// import 'package:car_rental_app/services/api/car_service.dart';
// import 'package:flutter/material.dart';

// class CarBookingDetailsScreen extends StatefulWidget {
//   const CarBookingDetailsScreen({Key? key}) : super(key: key);

//   @override
//   State<CarBookingDetailsScreen> createState() => _CarBookingDetailsScreenState();
// }

// class _CarBookingDetailsScreenState extends State<CarBookingDetailsScreen> {

//     late Future<Booking> _bookingFuture;
//   final CarController _controller = CarController(CarProvider(), CarService());
//   final BookingProvider _bookingProvider = BookingProvider();

//   @override
//   void initState() {
//     super.initState();
//     _bookingFuture =
//         _bookingProvider.bookingSummary(widget.userId, widget.bookingId);
//   }
//   // Show booking confirmation dialog
//   void _showBookingConfirmation(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             width: 343,
//             height: 347,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Green checkmark in circle
//                 Container(
//                   width: 170,
//                   height: 170,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image(image: AssetImage("assets/check.png"))
//                 ),
//                 const SizedBox(height: 16),
//                 // Confirmation text
//                 const Text(
//                   'Your Booking is confirmed',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Apply button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0XFF2E67F6),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Apply',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final screenWidth = screenSize.width;
//     final screenHeight = screenSize.height;

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image carousel with navigation
//               Stack(
//                 children: [
//                   Container(
//                     height: screenHeight * 0.3,
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/car_detail.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 10,
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.5),
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.white)),
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                   ),
//                   // Thumbnail navigation
//                   Positioned(
//                     bottom: 10,
//                     left: 0,
//                     right: 0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildThumbnail('assets/detailcar1.png',
//                             isSelected: true),
//                         _buildThumbnail('assets/detailcar2.png'),
//                         _buildThumbnail('assets/detailcar3.png'),
//                         _buildThumbnail('assets/detailcar4.png'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               // Car title and details
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'BMW',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         _buildFeatureChip('Automatic'),
//                         const SizedBox(width: 8),
//                         Container(
//                           width: 1,
//                           height: 20,
//                           color: Colors.grey.shade400,
//                         ),
//                         const SizedBox(width: 8),
//                         _buildFeatureChip('7 seats'),
//                         const SizedBox(width: 8),
//                         Container(
//                           width: 1,
//                           height: 20,
//                           color: Colors.grey.shade400,
//                         ),
//                         const SizedBox(width: 8),
//                         _buildFeatureChip('Diesel'),
//                       ],
//                     ),
//                     const SizedBox(height: 16),

//                     // Date and time selection
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFF5E3A),
//                         borderRadius: BorderRadius.circular(5),
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color(0xFF115CFF),
//                             Color.fromARGB(255, 4, 59, 176)
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Hyderabad Bus satand, Kphb pahse9, Kukatpally, Hyderabad',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(4),
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: const Icon(
//                                         Icons.access_time_filled,
//                                         color:
//                                             Color.fromARGB(255, 255, 255, 255),
//                                         size: 15,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 6),
//                                     const Text(
//                                       '10:00 Am',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Container(
//                                                 height: 2,
//                                                 width: 90,
//                                                 color: const Color.fromARGB(
//                                                     136, 255, 255, 255)),
//                                             Transform.translate(
//                                               offset: const Offset(-5, 0),
//                                               child: const Icon(
//                                                   Icons.arrow_forward,
//                                                   size: 25,
//                                                   color: Color.fromARGB(
//                                                       137, 255, 255, 255)),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.all(4),
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: const Icon(
//                                         Icons.access_time_filled,
//                                         color:
//                                             Color.fromARGB(255, 255, 255, 255),
//                                         size: 15,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 6),
//                                     const Text(
//                                       '10:00 Am',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           // Edit icon
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: const Icon(
//                               Icons.edit_square,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Pickup location with map
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.grey.shade200),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: screenHeight * 0.15,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               image: const DecorationImage(
//                                 image: AssetImage('assets/map.png'),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Pickup location',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             'Hyderabad Bus stand, Kphb phase(l), Kukatpally, Hyderabad',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                         ],
//                       ),
//                     ),

//                     SizedBox(
//                       height: 20,
//                     ),

//                     // Note section
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       child: const Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Note: ',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 153, 27, 5),
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               'Submit the bike in uploaded rc same other ways it is not Accepted',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // Booking details section
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       width: double.infinity,
//                       height: 164,
//                       decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 210, 210, 238),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         children: [
//                           const Text(
//                             'Booking details',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           _buildPriceRow('Price', '₹1700'),
//                           const SizedBox(height: 8),
//                           _buildPriceRow('Wallet', '₹1700'),
//                           const SizedBox(height: 8),
//                           const Divider(),
//                           const SizedBox(height: 8),
//                           _buildPriceRow('Total Payable', '₹1700',
//                               isTotal: true),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Proceed button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Show booking confirmation dialog when pressed
//                           _showBookingConfirmation(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0XFF2E67F6),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Proceed',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildThumbnail(String imagePath, {bool isSelected = false}) {
//     return Container(
//       width: 60,
//       height: 40,
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(
//           color: isSelected ? Colors.blue : Colors.white,
//           width: 2,
//         ),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureChip(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }

//   Widget _buildPriceRow(String label, String price, {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isTotal ? 16 : 14,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: Colors.black87,
//           ),
//         ),
//         Text(
//           price,
//           style: TextStyle(
//             fontSize: isTotal ? 16 : 14,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: isTotal ? Colors.blue.shade700 : Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
// }