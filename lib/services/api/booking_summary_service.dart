// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:car_rental_app/models/booking_summary_model.dart';

// class BookingSummaryService {
//   final String baseUrl = 'https://carrentalbackent.onrender.com/api';

//   Future<BookingSummary> getBookingSummary(String userId, String bookingId) async {
//     print("uuuusser$userId");
//     print("booki$bookingId");
//     final String url = 'https://carrentalbackent.onrender.com/api/users/booking-summary/6829d982b61e44b1a35f5ecf/682a42582336c000aab281d8';

//     try {
//       print("helooooooooooooooooooooooooooooooomorning");

//       final response = await http.get(Uri.parse(url));
//       print("${response.statusCode}");
      
//       if (response.statusCode == 200) {

//         // Parse the JSON response
//         final Map<String, dynamic> data = json.decode(response.body);
//         return BookingSummary.fromJson(data);
//       } else {
//         throw Exception('Failed to fetch booking summary. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in BookingService.getBookingSummary: $e');
//       rethrow;
//     }
//   }
// }




import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:car_rental_app/models/booking_summary_model.dart';

class BookingSummaryService {
  final String baseUrl = 'https://carrentalbackent.onrender.com/api';

  Future<BookingSummary> getBookingSummary(String userId, String bookingId) async {
    print("uuuusser$userId");
    print("booki$bookingId");
    final String url = 'https://carrentalbackent.onrender.com/api/users/booking-summary/6829d982b61e44b1a35f5ecf/682a42582336c000aab281d8';

    try {
      print("helooooooooooooooooooooooooooooooomorning");

      final response = await http.get(Uri.parse(url));
      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      
      if (response.statusCode == 200) {
        // Check if response body is not empty
        if (response.body.isNotEmpty) {
          try {
            // Parse the JSON response
            final Map<String, dynamic> data = json.decode(response.body);
            return BookingSummary.fromJson(data);
          } catch (e) {
            print('Error parsing JSON: $e');
            print('Response body was: ${response.body}');
            throw Exception('Failed to parse booking summary JSON: $e');
          }
        } else {
          throw Exception('Empty response received from server');
        }
      } else {
        throw Exception('Failed to fetch booking summary. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in BookingService.getBookingSummary: $e');
      rethrow;
    }
  }
}