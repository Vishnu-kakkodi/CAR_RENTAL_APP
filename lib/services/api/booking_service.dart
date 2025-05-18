// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:car_rental_app/models/booking_model.dart';

// class BookingService {
//   final String baseUrl = "https://carrentalbackent.onrender.com/api/users";

//   Future<List<Booking>> fetchBookings(String userId) async {
//     final response = await http.get(Uri.parse('$baseUrl/bookings/$userId'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print('dataaa$data');
//       final List bookingsJson = data['bookings'];

//       return bookingsJson.map((json) => Booking.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load bookings');
//     }
//   }

//   Future<Booking> fetchRecentBooking(String userId) async {
//     print('urrrrrrrrrrrrr$userId');
//     final response =
//         await http.get(Uri.parse('$baseUrl/recent-booking/$userId'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print('dataaa $data');

//       final bookingJson = data['booking']; 
//       print('ppppppppppppppppppppppppppppp${Booking.fromJson(bookingJson)}');
//       return Booking.fromJson(bookingJson);
//     } else {
//       throw Exception('Failed to load recent booking');
//     }
//   }

//     Future<Booking> fetchBookingSummary(String userId, String bookingId) async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/booking-summary/$userId/$bookingId'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print('dataaa $data');

//       final bookingJson = data['booking']; 
//       return Booking.fromJson(bookingJson);
//     } else {
//       throw Exception('Failed to load recent booking');
//     }
//   }

//     Future<Map<String, dynamic>> createBooking({
//     required String userId,
//     required String carId,
//     required DateTime startDate,
//     required DateTime endDate,
//     required String startTime,
//     required String endTime,
//   }) async {
//     final url = Uri.parse('https://carrentalbackent.onrender.com/api/users/create-booking');
    
//     // Format the dates to ISO format (YYYY-MM-DD)
//     final formattedStartDate = "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
//     final formattedEndDate = "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

//     final payload = {
//       "userId": userId,
//       "carId": carId,
//       "rentalStartDate": formattedStartDate,
//       "rentalEndDate": formattedEndDate,
//       "from": startTime,
//       "to": endTime,
//     };

//     print('Sending booking payload: $payload');

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(payload),
//     );

//     print('rrrrrrrrrrrrrrrrrrrrrrr${response.statusCode}');

//     if (response.statusCode == 201 || response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       final errorData = json.decode(response.body);
//       throw Exception('Failed to create booking: ${errorData['message'] ?? 'Unknown error'}');
//     }
//   }
// }






import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:car_rental_app/models/booking_model.dart';

class BookingService {
  final String baseUrl = "https://carrentalbackent.onrender.com/api/users";

  Future<List<Booking>> fetchBookings(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/bookings/$userId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data');
      final List bookingsJson = data['bookings'];

      return bookingsJson.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings: ${response.statusCode}');
    }
  }

  Future<Booking> fetchRecentBooking(String userId) async {
    print('Fetching recent booking for user ID: $userId');
    final response = await http.get(Uri.parse('$baseUrl/recent-booking/$userId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Recent booking response data: $data');

      // Check if booking exists in response
      if (data['booking'] == null) {
        throw Exception('No recent booking found');
      }

      final bookingJson = data['booking'];
      try {
        return Booking.fromJson(bookingJson);
      } catch (e) {
        print('Error parsing booking: $e');
        throw Exception('Error parsing booking data: $e');
      }
    } else {
      throw Exception('Failed to load recent booking: ${response.statusCode}');
    }
  }

  Future<Booking> fetchBookingSummary(String userId, String bookingId) async {
    final response = await http.get(Uri.parse('$baseUrl/booking-summary/$userId/$bookingId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Booking summary response data: $data');

      if (data['booking'] == null) {
        throw Exception('Booking not found');
      }

      final bookingJson = data['booking']; 
      try {
        return Booking.fromJson(bookingJson);
      } catch (e) {
        print('Error parsing booking summary: $e');
        throw Exception('Error parsing booking summary: $e');
      }
    } else {
      throw Exception('Failed to load booking summary: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createBooking({
    required String userId,
    required String carId,
    required DateTime startDate,
    required DateTime endDate,
    required String startTime,
    required String endTime,
  }) async {
    final url = Uri.parse('https://carrentalbackent.onrender.com/api/users/create-booking');
    
    // Format the dates to ISO format (YYYY-MM-DD)
    final formattedStartDate = "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
    final formattedEndDate = "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

    final payload = {
      "userId": userId,
      "carId": carId,
      "rentalStartDate": formattedStartDate,
      "rentalEndDate": formattedEndDate,
      "from": startTime,
      "to": endTime,
    };

    print('Sending booking payload: $payload');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorData = json.decode(response.body);
      throw Exception('Failed to create booking: ${errorData['message'] ?? 'Unknown error'}');
    }
  }
}