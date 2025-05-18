// import 'package:car_rental_app/services/location/location_service.dart';
// import 'package:car_rental_app/widgect/location_widgect.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter/services.dart';

// import '../providers/date_time_provider.dart';

// class BookingConfirmationScreen extends StatefulWidget {
//   final String carImageUrl;
//   final String carName;
//   final int pricePerDay;

//   const BookingConfirmationScreen({
//     super.key, 
//     required this.carImageUrl,
//     required this.carName,
//     required this.pricePerDay,
//   });

//   @override
//   State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
// }



// class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
//   Map<String, dynamic>? pickupLocation;
//   Map<String, dynamic>? dropLocation;
//   bool isLoading = false;
//     String _addressPick = '';
//         String _addressDrop = '';



//     void _fetchAddress() async {
//     final address = await LocationService.getCurrentAddress();
//     setState(() {
//       _addressPick = address ?? 'Unable to fetch address';
//     });
//   }

//       void _fetchAddressDrop() async {
//     final address = await LocationService.getCurrentAddress();
//     setState(() {
//       _addressDrop = address ?? 'Unable to fetch address';
//     });
//   }

//   void _openMapPicker(bool isPickup) async {
//     setState(() {
//       isLoading = true;
//     });

//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LocationPickerScreen(
//           title: isPickup ? "Select Pickup Location" : "Select Drop Location",
//         ),
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         if (isPickup) {
//           pickupLocation = result;
//         } else {
//           dropLocation = result;
//         }
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

// int _calculateTotalHours(DateTime? startDate, TimeOfDay? startTime, DateTime? endDate, TimeOfDay? endTime) {
//   if (startDate == null || endDate == null || startTime == null || endTime == null) return 0;

//   final startDateTime = DateTime(
//     startDate.year, startDate.month, startDate.day,
//     startTime.hour, startTime.minute,
//   );

//   final endDateTime = DateTime(
//     endDate.year, endDate.month, endDate.day,
//     endTime.hour, endTime.minute,
//   );

//   final difference = endDateTime.difference(startDateTime);
//   return difference.inMinutes <= 0 ? 0 : (difference.inMinutes / 60).ceil(); // round up to next hour
// }


//   @override
//   Widget build(BuildContext context) {
//     final dateTimeProvider = Provider.of<DateTimeProvider>(context);
//     final startDate = dateTimeProvider.startDate;
//     final endDate = dateTimeProvider.endDate;
//     final startTime = dateTimeProvider.startTime;
//     final endTime = dateTimeProvider.endTime;
    
// final totalHours = _calculateTotalHours(startDate, startTime, endDate, endTime);
// final totalPrice = totalHours * widget.pricePerDay;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Confirm Booking'),
//         elevation: 0,
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Colors.white,
//       ),
//       body: isLoading 
//         ? const Center(child: CircularProgressIndicator())
//         : SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Car Image and Details
//                 Container(
//                   height: 220,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary,
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           widget.carImageUrl,
//                           height: 160,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 160,
//                               color: Colors.grey[300],
//                               child: const Center(
//                                 child: Icon(Icons.error, size: 50),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               widget.carName,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "₹${widget.pricePerDay.toStringAsFixed(0)}/day",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Booking Details
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Rental Period",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "Start Date",
//                                   startDate != null
//                                       ? DateFormat('MMM dd, yyyy').format(startDate)
//                                       : "Not selected",
//                                   Icons.calendar_today,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "End Date",
//                                   endDate != null
//                                       ? DateFormat('MMM dd, yyyy').format(endDate)
//                                       : "Not selected",
//                                   Icons.calendar_month,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "Pickup Time",
//                                   startTime?.format(context) ?? "Not selected",
//                                   Icons.access_time,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "Return Time",
//                                   endTime?.format(context) ?? "Not selected",
//                                   Icons.access_time_filled,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Pickup Location
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.location_on, color: Colors.green),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 "Pickup Location",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Spacer(),
//                               TextButton(
//                                 onPressed: () => _fetchAddress(),
//                                 child: Text(
//                                   pickupLocation != null ? "Change" : "Select",
//                                   style: TextStyle(
//                                     color: Theme.of(context).colorScheme.primary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (pickupLocation != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                 pickupLocation!['address'],
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             )
//                           else
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                _addressPick != null ? _addressPick: "Please select a pickup location",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Drop Location
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.location_on, color: Colors.red),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 "Drop Location",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Spacer(),
//                               TextButton(
//                                 onPressed: () => _fetchAddressDrop(),
//                                 child: Text(
//                                   dropLocation != null ? "Change" : "Select",
//                                   style: TextStyle(
//                                     color: Theme.of(context).colorScheme.primary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (dropLocation != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                 dropLocation!['address'],
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             )
//                           else
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                 _addressDrop != null ? _addressDrop :"Please select a drop location",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Total Price Summary
//                 if (startDate != null && endDate != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Card(
//                       elevation: 4,
//                       color: Theme.of(context).colorScheme.primaryContainer,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Price Summary",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "₹${widget.pricePerDay.toStringAsFixed(0)} × $totalHours hr",
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   "₹${totalPrice.toStringAsFixed(0)}",
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             const Divider(height: 24),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Total",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   "₹${totalPrice.toStringAsFixed(0)}",
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                 const SizedBox(height: 20),

//                 // Confirm Button
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: (pickupLocation != null && 
//                                  dropLocation != null && 
//                                  startDate != null && 
//                                  endDate != null && 
//                                  startTime != null && 
//                                  endTime != null)
//                           ? () {
//                               // Submit logic here
//                               final bookingPayload = {
//                                 "pickupLocation": pickupLocation,
//                                 "dropLocation": dropLocation,
//                                 "startDate": startDate.toIso8601String(),
//                                 "endDate": endDate.toIso8601String(),
//                                 "startTime": startTime.format(context),
//                                 "endTime": endTime.format(context),
//                                 "totalPrice": totalPrice,
//                               };
                              
//                               print("Submit Booking Payload: $bookingPayload");
                              
//                               // Show confirmation dialog
//                               _showBookingConfirmationDialog();
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).colorScheme.primary,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         "Confirm Booking",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//     );
//   }

//   Widget _buildInfoItem(String title, String value, IconData icon) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16, color: Colors.grey[600]),
//             const SizedBox(width: 4),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   void _showBookingConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Booking Successful"),
//         content: const Text(
//           "Your booking has been confirmed. You will receive a confirmation email with all details shortly.",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               // Navigate to booking history or home screen
//               Navigator.of(context).popUntil((route) => route.isFirst);
//             },
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'package:car_rental_app/services/location/location_service.dart';
// import 'package:car_rental_app/widgect/location_widgect.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter/services.dart';

// import '../providers/date_time_provider.dart';
// import '../providers/booking_provider.dart';
// import '../providers/auth_provider.dart';

// class BookingConfirmationScreen extends StatefulWidget {
//   final String carImageUrl;
//   final String carName;
//   final int pricePerDay;
//   final String carId;

//   const BookingConfirmationScreen({
//     super.key, 
//     required this.carImageUrl,
//     required this.carName,
//     required this.pricePerDay,
//     required this.carId,
//   });

//   @override
//   State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
// }

// class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
//   Map<String, dynamic>? pickupLocation;
//   Map<String, dynamic>? dropLocation;
//   bool isLoading = false;
//   String _addressPick = '';
//   String _addressDrop = '';
//   List<double> _coordinatesPick = [];
//     List<double> _coordinatesDrop = [];




//   void _fetchAddress() async {
//     final address = await LocationService.getCurrentAddress();
//     final coordinates = await LocationService.getCurrentCoordinates();
//     _coordinatesPick = coordinates ?? [];
//     print('llllllllllllllllllllllllllllllllll$_coordinatesPick');
//     setState(() {
//       _addressPick = address ?? 'Unable to fetch address';
//       if (address != null) {
//         pickupLocation = {
//           'address': address,
//           'coordinates': _coordinatesPick // Replace with actual coordinates
//         };
//       }
//     });
//   }

//   void _fetchAddressDrop() async {
//     final address = await LocationService.getCurrentAddress();
//     final coordinates = await LocationService.getCurrentCoordinates();
//     _coordinatesDrop = coordinates ?? [];
//     print('llllllllllllllllllllllllllllllllll$_coordinatesDrop');
//     setState(() {
//       _addressDrop = address ?? 'Unable to fetch address';
//       if (address != null) {
//         dropLocation = {
//           'address': address,
//           'coordinates': _coordinatesDrop // Replace with actual coordinates
//         };
//       }
//     });
//   }

//   void _openMapPicker(bool isPickup) async {
//     setState(() {
//       isLoading = true;
//     });

//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LocationPickerScreen(
//           title: isPickup ? "Select Pickup Location" : "Select Drop Location",
//         ),
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         if (isPickup) {
//           pickupLocation = result;
//         } else {
//           dropLocation = result;
//         }
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   int _calculateTotalHours(DateTime? startDate, TimeOfDay? startTime, DateTime? endDate, TimeOfDay? endTime) {
//     if (startDate == null || endDate == null || startTime == null || endTime == null) return 0;

//     final startDateTime = DateTime(
//       startDate.year, startDate.month, startDate.day,
//       startTime.hour, startTime.minute,
//     );

//     final endDateTime = DateTime(
//       endDate.year, endDate.month, endDate.day,
//       endTime.hour, endTime.minute,
//     );

//     final difference = endDateTime.difference(startDateTime);
//     return difference.inMinutes <= 0 ? 0 : (difference.inMinutes / 60).ceil(); // round up to next hour
//   }

//   Future<void> _submitBooking() async {
//     final dateTimeProvider = Provider.of<DateTimeProvider>(context, listen: false);
//     final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
//     final userId = authProvider.user?.id;
    
//     if (userId == null) {
//       _showErrorDialog("You must be logged in to create a booking");
//       return;
//     }
    
//     final startDate = dateTimeProvider.startDate;
//     final endDate = dateTimeProvider.endDate;
//     final startTime = dateTimeProvider.startTime;
//     final endTime = dateTimeProvider.endTime;
    
//     if (startDate == null || endDate == null || startTime == null || endTime == null) {
//       _showErrorDialog("Please select dates and times for your booking");
//       return;
//     }
    
//     if (pickupLocation == null || dropLocation == null) {
//       _showErrorDialog("Please select pickup and drop locations");
//       return;
//     }
    
//     setState(() {
//       isLoading = true;
//     });
    
//     try {
//       final success = await bookingProvider.createBooking(
//         userId: userId,
//         carId: widget.carId,
//         rentalStartDate: startDate,
//         rentalEndDate: endDate,
//         from: startTime.format(context),
//         to: endTime.format(context),
//         pickupLocation: pickupLocation!,
//         dropLocation: dropLocation!,
//       );
      
//       setState(() {
//         isLoading = false;
//       });
      
//       if (success) {
//         _showBookingConfirmationDialog();
//       } else {
//         _showErrorDialog(bookingProvider.bookingError ?? "Failed to create booking");
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       _showErrorDialog("An error occurred: $e");
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dateTimeProvider = Provider.of<DateTimeProvider>(context);
//     final startDate = dateTimeProvider.startDate;
//     final endDate = dateTimeProvider.endDate;
//     final startTime = dateTimeProvider.startTime;
//     final endTime = dateTimeProvider.endTime;
    
//     final totalHours = _calculateTotalHours(startDate, startTime, endDate, endTime);
//     final totalPrice = totalHours * widget.pricePerDay;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Confirm Booking'),
//         elevation: 0,
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Colors.white,
//       ),
//       body: isLoading 
//         ? const Center(child: CircularProgressIndicator())
//         : SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Car Image and Details
//                 Container(
//                   height: 220,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary,
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           widget.carImageUrl,
//                           height: 160,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 160,
//                               color: Colors.grey[300],
//                               child: const Center(
//                                 child: Icon(Icons.error, size: 50),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               widget.carName,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "₹${widget.pricePerDay.toStringAsFixed(0)}/day",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Booking Details
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Rental Period",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "Start Date",
//                                   startDate != null
//                                       ? DateFormat('MMM dd, yyyy').format(startDate)
//                                       : "Not selected",
//                                   Icons.calendar_today,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "End Date",
//                                   endDate != null
//                                       ? DateFormat('MMM dd, yyyy').format(endDate)
//                                       : "Not selected",
//                                   Icons.calendar_month,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "Pickup Time",
//                                   startTime?.format(context) ?? "Not selected",
//                                   Icons.access_time,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: _buildInfoItem(
//                                   "Return Time",
//                                   endTime?.format(context) ?? "Not selected",
//                                   Icons.access_time_filled,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Pickup Location
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.location_on, color: Colors.green),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 "Pickup Location",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Spacer(),
//                               TextButton(
//                                 onPressed: () => _fetchAddress(),
//                                 child: Text(
//                                   pickupLocation != null ? "Change" : "Select",
//                                   style: TextStyle(
//                                     color: Theme.of(context).colorScheme.primary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (pickupLocation != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                 pickupLocation!['address'],
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             )
//                           else
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                _addressPick.isNotEmpty ? _addressPick: "Please select a pickup location",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Drop Location
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.location_on, color: Colors.red),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 "Drop Location",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Spacer(),
//                               TextButton(
//                                 onPressed: () => _fetchAddressDrop(),
//                                 child: Text(
//                                   dropLocation != null ? "Change" : "Select",
//                                   style: TextStyle(
//                                     color: Theme.of(context).colorScheme.primary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (dropLocation != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                 dropLocation!['address'],
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             )
//                           else
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, left: 32),
//                               child: Text(
//                                 _addressDrop.isNotEmpty ? _addressDrop :"Please select a drop location",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Total Price Summary
//                 if (startDate != null && endDate != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Card(
//                       elevation: 4,
//                       color: Theme.of(context).colorScheme.primaryContainer,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Price Summary",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "₹${widget.pricePerDay.toStringAsFixed(0)} × $totalHours hr",
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   "₹${totalPrice.toStringAsFixed(0)}",
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             const Divider(height: 24),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Total",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   "₹${totalPrice.toStringAsFixed(0)}",
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                 const SizedBox(height: 20),

//                 // Confirm Button
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: (pickupLocation != null && 
//                                  dropLocation != null && 
//                                  startDate != null && 
//                                  endDate != null && 
//                                  startTime != null && 
//                                  endTime != null)
//                           ? _submitBooking
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).colorScheme.primary,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         "Confirm Booking",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//     );
//   }

//   Widget _buildInfoItem(String title, String value, IconData icon) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16, color: Colors.grey[600]),
//             const SizedBox(width: 4),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   void _showBookingConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Booking Successful"),
//         content: const Text(
//           "Your booking has been confirmed. You will receive a confirmation email with all details shortly.",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               // Navigate to booking history or home screen
//               Navigator.of(context).popUntil((route) => route.isFirst);
//             },
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
// }












import 'package:car_rental_app/services/location/location_service.dart';
import 'package:car_rental_app/widgect/location_widgect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/services.dart';

import '../providers/date_time_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/auth_provider.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final String carImageUrl;
  final String carName;
  final int pricePerDay;
  final String carId;

  const BookingConfirmationScreen({
    super.key, 
    required this.carImageUrl,
    required this.carName,
    required this.pricePerDay,
    required this.carId,
  });

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  Map<String, dynamic>? pickupLocation;
  Map<String, dynamic>? dropLocation;
  bool isLoading = false;
  String _addressPick = '';
  String _addressDrop = '';
  List<double> _coordinatesPick = [];
  List<double> _coordinatesDrop = [];

  void _fetchAddress() async {
    final address = await LocationService.getCurrentAddress();
    final coordinates = await LocationService.getCurrentCoordinates();
    _coordinatesPick = coordinates ?? [];
    print('llllllllllllllllllllllllllllllllll$_coordinatesPick');
    setState(() {
      _addressPick = address ?? 'Unable to fetch address';
      if (address != null) {
        pickupLocation = {
          'address': address,
          'coordinates': _coordinatesPick // Replace with actual coordinates
        };
      }
    });
  }

  void _fetchAddressDrop() async {
    final address = await LocationService.getCurrentAddress();
    final coordinates = await LocationService.getCurrentCoordinates();
    _coordinatesDrop = coordinates ?? [];
    print('llllllllllllllllllllllllllllllllll$_coordinatesDrop');
    setState(() {
      _addressDrop = address ?? 'Unable to fetch address';
      if (address != null) {
        dropLocation = {
          'address': address,
          'coordinates': _coordinatesDrop // Replace with actual coordinates
        };
      }
    });
  }

  void _openMapPicker(bool isPickup) async {
    setState(() {
      isLoading = true;
    });

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          title: isPickup ? "Select Pickup Location" : "Select Drop Location",
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (isPickup) {
          pickupLocation = result;
        } else {
          dropLocation = result;
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  int _calculateTotalHours(DateTime? startDate, TimeOfDay? startTime, DateTime? endDate, TimeOfDay? endTime) {
    if (startDate == null || endDate == null || startTime == null || endTime == null) return 0;

    final startDateTime = DateTime(
      startDate.year, startDate.month, startDate.day,
      startTime.hour, startTime.minute,
    );

    final endDateTime = DateTime(
      endDate.year, endDate.month, endDate.day,
      endTime.hour, endTime.minute,
    );

    final difference = endDateTime.difference(startDateTime);
    return difference.inMinutes <= 0 ? 0 : (difference.inMinutes / 60).ceil(); // round up to next hour
  }

  Future<void> _pickStartDate(BuildContext context, DateTimeProvider dateTimeProvider) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTimeProvider.startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (pickedDate != null) {
      dateTimeProvider.setStartDate(pickedDate);
    }
  }

  Future<void> _pickEndDate(BuildContext context, DateTimeProvider dateTimeProvider) async {
    // Only allow end date selection if start date is selected
    if (dateTimeProvider.startDate == null) {
      _showErrorDialog("Please select a start date first");
      return;
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTimeProvider.endDate ?? dateTimeProvider.startDate!,
      firstDate: dateTimeProvider.startDate!, // End date must be after start date
      lastDate: dateTimeProvider.startDate!.add(const Duration(days: 30)), // Limit to 30 days rental
    );
    
    if (pickedDate != null) {
      dateTimeProvider.setEndDate(pickedDate);
    }
  }

  Future<void> _pickStartTime(BuildContext context, DateTimeProvider dateTimeProvider) async {
    // Only allow time selection if date is selected
    if (dateTimeProvider.startDate == null) {
      _showErrorDialog("Please select a start date first");
      return;
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: dateTimeProvider.startTime ?? TimeOfDay.now(),
    );
    
    if (pickedTime != null) {
      dateTimeProvider.setStartTime(pickedTime);
    }
  }

  Future<void> _pickEndTime(BuildContext context, DateTimeProvider dateTimeProvider) async {
    // Only allow end time selection if end date and start time are selected
    if (dateTimeProvider.endDate == null) {
      _showErrorDialog("Please select an end date first");
      return;
    }
    
    if (dateTimeProvider.startTime == null) {
      _showErrorDialog("Please select a start time first");
      return;
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: dateTimeProvider.endTime ?? dateTimeProvider.startTime ?? TimeOfDay.now(),
    );
    
    if (pickedTime != null) {
      dateTimeProvider.setEndTime(pickedTime);
    }
  }

  Future<void> _submitBooking() async {
    final dateTimeProvider = Provider.of<DateTimeProvider>(context, listen: false);
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final userId = authProvider.user?.id;
    
    if (userId == null) {
      _showErrorDialog("You must be logged in to create a booking");
      return;
    }
    
    final startDate = dateTimeProvider.startDate;
    final endDate = dateTimeProvider.endDate;
    final startTime = dateTimeProvider.startTime;
    final endTime = dateTimeProvider.endTime;
    
    if (startDate == null || endDate == null || startTime == null || endTime == null) {
      _showErrorDialog("Please select dates and times for your booking");
      return;
    }
    
    // if (pickupLocation == null || dropLocation == null) {
    //   _showErrorDialog("Please select pickup and drop locations");
    //   return;
    // }
    
    setState(() {
      isLoading = true;
    });
    
    try {
      final success = await bookingProvider.createBooking(
        userId: userId,
        carId: widget.carId,
        rentalStartDate: startDate,
        rentalEndDate: endDate,
        from: startTime.format(context),
        to: endTime.format(context),
      );
      
      setState(() {
        isLoading = false;
      });
      
      if (success) {
        _showBookingConfirmationDialog();
      } else {
        _showErrorDialog(bookingProvider.bookingError ?? "Failed to create booking");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog("An error occurred: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeProvider = Provider.of<DateTimeProvider>(context);
    final startDate = dateTimeProvider.startDate;
    final endDate = dateTimeProvider.endDate;
    final startTime = dateTimeProvider.startTime;
    final endTime = dateTimeProvider.endTime;
    
    final totalHours = _calculateTotalHours(startDate, startTime, endDate, endTime);
    final totalPrice = totalHours * widget.pricePerDay;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image and Details
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.carImageUrl,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 160,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.error, size: 50),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.carName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹${widget.pricePerDay.toStringAsFixed(0)}/day",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Booking Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Rental Period",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                tooltip: "Edit All Dates & Times",
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => _buildDateTimeEditSheet(context, dateTimeProvider),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDateItem(
                                  "Start Date",
                                  startDate != null
                                      ? DateFormat('MMM dd, yyyy').format(startDate)
                                      : "Not selected",
                                  Icons.calendar_today,
                                  () => _pickStartDate(context, dateTimeProvider),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDateItem(
                                  "End Date",
                                  endDate != null
                                      ? DateFormat('MMM dd, yyyy').format(endDate)
                                      : "Not selected",
                                  Icons.calendar_month,
                                  () => _pickEndDate(context, dateTimeProvider),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDateItem(
                                  "Pickup Time",
                                  startTime?.format(context) ?? "Not selected",
                                  Icons.access_time,
                                  () => _pickStartTime(context, dateTimeProvider),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDateItem(
                                  "Return Time",
                                  endTime?.format(context) ?? "Not selected",
                                  Icons.access_time_filled,
                                  () => _pickEndTime(context, dateTimeProvider),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Pickup Location
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Card(
                //     elevation: 4,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Row(
                //             children: [
                //               const Icon(Icons.location_on, color: Colors.green),
                //               const SizedBox(width: 8),
                //               const Text(
                //                 "Pickup Location",
                //                 style: TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               const Spacer(),
                //               TextButton(
                //                 onPressed: () => _fetchAddress(),
                //                 child: Text(
                //                   pickupLocation != null ? "Change" : "Select",
                //                   style: TextStyle(
                //                     color: Theme.of(context).colorScheme.primary,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //           if (pickupLocation != null)
                //             Padding(
                //               padding: const EdgeInsets.only(top: 8.0, left: 32),
                //               child: Text(
                //                 pickupLocation!['address'],
                //                 style: const TextStyle(fontSize: 16),
                //               ),
                //             )
                //           else
                //             Padding(
                //               padding: const EdgeInsets.only(top: 8.0, left: 32),
                //               child: Text(
                //                _addressPick.isNotEmpty ? _addressPick: "Please select a pickup location",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   fontStyle: FontStyle.italic,
                //                   color: Colors.grey[600],
                //                 ),
                //               ),
                //             ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                // // Drop Location
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Card(
                //     elevation: 4,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Row(
                //             children: [
                //               const Icon(Icons.location_on, color: Colors.red),
                //               const SizedBox(width: 8),
                //               const Text(
                //                 "Drop Location",
                //                 style: TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               const Spacer(),
                //               TextButton(
                //                 onPressed: () => _fetchAddressDrop(),
                //                 child: Text(
                //                   dropLocation != null ? "Change" : "Select",
                //                   style: TextStyle(
                //                     color: Theme.of(context).colorScheme.primary,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //           if (dropLocation != null)
                //             Padding(
                //               padding: const EdgeInsets.only(top: 8.0, left: 32),
                //               child: Text(
                //                 dropLocation!['address'],
                //                 style: const TextStyle(fontSize: 16),
                //               ),
                //             )
                //           else
                //             Padding(
                //               padding: const EdgeInsets.only(top: 8.0, left: 32),
                //               child: Text(
                //                 _addressDrop.isNotEmpty ? _addressDrop :"Please select a drop location",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   fontStyle: FontStyle.italic,
                //                   color: Colors.grey[600],
                //                 ),
                //               ),
                //             ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                // Total Price Summary
                if (startDate != null && endDate != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price Summary",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹${widget.pricePerDay.toStringAsFixed(0)} × $totalHours hr",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "₹${totalPrice.toStringAsFixed(0)}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹${totalPrice.toStringAsFixed(0)}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Confirm Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: ( 
                                 startDate != null && 
                                 endDate != null && 
                                 startTime != null && 
                                 endTime != null)
                          ? _submitBooking
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Confirm Booking",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  Widget _buildDateTimeEditSheet(BuildContext context, DateTimeProvider dateTimeProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Edit Rental Period",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Start Date
          _buildDateTimeEditRow(
            title: "Start Date",
            value: dateTimeProvider.startDate != null
                ? DateFormat('MMM dd, yyyy').format(dateTimeProvider.startDate!)
                : "Not selected",
            icon: Icons.calendar_today,
            onEdit: () => _pickStartDate(context, dateTimeProvider),
          ),
          const Divider(),
          
          // End Date
          _buildDateTimeEditRow(
            title: "End Date",
            value: dateTimeProvider.endDate != null
                ? DateFormat('MMM dd, yyyy').format(dateTimeProvider.endDate!)
                : "Not selected",
            icon: Icons.calendar_month,
            onEdit: () => _pickEndDate(context, dateTimeProvider),
          ),
          const Divider(),
          
          // Start Time
          _buildDateTimeEditRow(
            title: "Pickup Time",
            value: dateTimeProvider.startTime?.format(context) ?? "Not selected",
            icon: Icons.access_time,
            onEdit: () => _pickStartTime(context, dateTimeProvider),
          ),
          const Divider(),
          
          // End Time
          _buildDateTimeEditRow(
            title: "Return Time",
            value: dateTimeProvider.endTime?.format(context) ?? "Not selected",
            icon: Icons.access_time_filled,
            onEdit: () => _pickEndTime(context, dateTimeProvider),
          ),
          
          const Spacer(),
          
          // Done Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeEditRow({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }

  Widget _buildDateItem(String title, String value, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.edit, size: 14, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showBookingConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Booking Successful"),
        content: const Text(
          "Your booking has been confirmed. You will receive a confirmation email with all details shortly.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to booking history or home screen
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}