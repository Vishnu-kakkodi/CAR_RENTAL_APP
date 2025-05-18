// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:car_rental_app/providers/date_time_provider.dart';

// class DateTimeEditScreen extends StatefulWidget {
//   const DateTimeEditScreen({Key? key}) : super(key: key);

//   @override
//   State<DateTimeEditScreen> createState() => _DateTimeEditScreenState();
// }

// class _DateTimeEditScreenState extends State<DateTimeEditScreen> {
//   bool _isSameDate(DateTime a, DateTime b) {
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }

//   String formatDate(DateTime? date) {
//     if (date == null) return 'Not selected';
//     return DateFormat('d MMM y').format(date);
//   }

//   String formatTime(TimeOfDay? time) {
//     if (time == null) return '--:--';
//     final now = DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
//     return DateFormat.jm().format(dt); // '10:00 AM'
//   }

//   bool isEndAfterStart(TimeOfDay start, TimeOfDay end) {
//     final startMinutes = start.hour * 60 + start.minute;
//     final endMinutes = end.hour * 60 + end.minute;
//     return endMinutes > startMinutes;
//   }

//   Future<void> _selectFromCalendar({required bool isStartDate}) async {
//     final DateTimeProvider provider =
//         Provider.of<DateTimeProvider>(context, listen: false);
//     final DateTime today = DateTime.now();
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: isStartDate
//           ? (provider.startDate ?? today)
//           : (provider.endDate ?? provider.startDate ?? today),
//       firstDate: isStartDate ? today : (provider.startDate ?? today),
//       lastDate: DateTime(today.year + 1),
//     );

//     if (picked != null) {
//       if (isStartDate) {
//         provider.setStartDate(picked);
//         // If end date exists and is before new start date, reset end date
//         if (provider.endDate != null && provider.endDate!.isBefore(picked)) {
//           provider.setEndDate(null);
//         }
//       } else {
//         provider.setEndDate(picked);
//       }
//     }
//   }

//   Future<void> _pickTime({required bool isStart}) async {
//     final DateTimeProvider provider =
//         Provider.of<DateTimeProvider>(context, listen: false);
//     final TimeOfDay initial = isStart
//         ? (provider.startTime ?? TimeOfDay.now())
//         : (provider.endTime ?? TimeOfDay.now());

//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: initial,
//       builder: (context, child) {
//         return MediaQuery(
//             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//             child: child!);
//       },
//     );

//     if (picked != null) {
//       if (isStart) {
//         provider.setStartTime(picked);
//         // If same day and end time is before new start time, reset end time
//         if (provider.endTime != null && 
//             provider.startDate != null && 
//             provider.endDate != null &&
//             _isSameDate(provider.startDate!, provider.endDate!) &&
//             !isEndAfterStart(picked, provider.endTime!)) {
//           provider.setEndTime(null);
//         }
//       } else {
//         if (provider.startDate != null && 
//             provider.endDate != null &&
//             _isSameDate(provider.startDate!, provider.endDate!) &&
//             provider.startTime != null &&
//             !isEndAfterStart(provider.startTime!, picked)) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("End time must be after start time")),
//           );
//           return;
//         }
//         provider.setEndTime(picked);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Rental Time', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0XFF120698),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Consumer<DateTimeProvider>(
//         builder: (context, dateTimeProvider, _) {
//           return Padding(
//             padding: EdgeInsets.all(screenWidth * 0.05),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Date selection section
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(screenWidth * 0.04),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Select Dates',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
                        
//                         // Start Date Row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Start Date',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   formatDate(dateTimeProvider.startDate),
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: dateTimeProvider.startDate == null
//                                         ? Colors.red
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             ElevatedButton(
//                               onPressed: () => _selectFromCalendar(isStartDate: true),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0XFF120698),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text('Select'),
//                             ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 20),
//                         const Divider(),
//                         const SizedBox(height: 20),
                        
//                         // End Date Row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'End Date',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   formatDate(dateTimeProvider.endDate),
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: dateTimeProvider.endDate == null
//                                         ? Colors.red
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             ElevatedButton(
//                               onPressed: dateTimeProvider.startDate == null
//                                   ? null
//                                   : () => _selectFromCalendar(isStartDate: false),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0XFF120698),
//                                 foregroundColor: Colors.white,
//                                 disabledBackgroundColor: Colors.grey,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text('Select'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: screenHeight * 0.03),

//                 // Time selection section
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(screenWidth * 0.04),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Select Times',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
                        
//                         // Start Time Row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Start Time',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   formatTime(dateTimeProvider.startTime),
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: dateTimeProvider.startTime == null
//                                         ? Colors.red
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             ElevatedButton(
//                               onPressed: () => _pickTime(isStart: true),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0XFF120698),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text('Select'),
//                             ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 20),
//                         const Divider(),
//                         const SizedBox(height: 20),
                        
//                         // End Time Row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'End Time',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   formatTime(dateTimeProvider.endTime),
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: dateTimeProvider.endTime == null
//                                         ? Colors.red
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             ElevatedButton(
//                               onPressed: dateTimeProvider.startTime == null
//                                   ? null
//                                   : () => _pickTime(isStart: false),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0XFF120698),
//                                 foregroundColor: Colors.white,
//                                 disabledBackgroundColor: Colors.grey,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text('Select'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const Spacer(),

//                 // Bottom buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: const Color(0XFF120698),
//                           side: const BorderSide(color: Color(0XFF120698)),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text('Cancel'),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: (dateTimeProvider.startDate == null ||
//                                 dateTimeProvider.endDate == null ||
//                                 dateTimeProvider.startTime == null ||
//                                 dateTimeProvider.endTime == null)
//                             ? null
//                             : () {
//                                 // Validation is all done during selection
//                                 Navigator.pop(context);
//                                 // Show confirmation if needed
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('Rental time updated successfully')),
//                                 );
//                               },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0XFF120698),
//                           foregroundColor: Colors.white,
//                           disabledBackgroundColor: Colors.grey,
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text('Save'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }