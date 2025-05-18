// import 'dart:math';

// import 'package:car_rental_app/controllers/booking_controller.dart';
// import 'package:car_rental_app/models/booking_model.dart';
// import 'package:flutter/material.dart';

// class BookingProvider with ChangeNotifier{

// final BookingController _controller = BookingController();

// List<Booking> _bookings = [];
// List<Booking> get bookings => _bookings;

// Booking? _recentBooking;
// Booking? get recentBooking => _recentBooking;

// Booking? _booking;
// Booking? get booking => _booking;





// bool _isLoading = false;
// bool get isLoading => _isLoading;

// Future<void> loadBookings(String userId) async {
//   _isLoading = true;
//   notifyListeners();

//   try{
//     _bookings = await _controller.getUserBookings(userId);
//     print('lllllllllllllllllll$_bookings');
//   }catch(e){
//     throw Exception('Error Occured');
//   }finally{
//     _isLoading = false;
//     notifyListeners();
//   }
// }

// Future<void> getRecentBooking(String userId) async {
//   _isLoading = true;
//   notifyListeners();
  
//   try {
//     print('Fetching booking for user ID: $userId');
//     _recentBooking = await _controller.getRecentBooking(userId);
//     print('Recent booking fetched: ${_recentBooking != null ? 'YES' : 'NO'}');
    
//     if (_recentBooking != null) {
//       print('Recent booking details: ${_recentBooking.toString()}');
//     }
//   } catch (e) {
//     print('Error fetching recent booking: $e');
//     // Don't throw here, handle gracefully
//     _recentBooking = null;
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }

// Future<Booking> bookingSummary(String userId, String bookingId) async {
//   _isLoading = true;
//   notifyListeners();
//   try {
//     final booking = await _controller.getBookingSummary(userId, bookingId);
//     _booking = booking; // Store in the class variable
//     print('Booking fetched: ${booking != null ? 'YES' : 'NO'}');
//     print('Booking details: ${booking.toString()}');
//     return booking; // Return the non-nullable booking object directly
//   } catch (e) {
//     print('Error fetching booking summary: $e');
//     rethrow; // Re-throw to show error in UI
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }

// }




import 'dart:math';

import 'package:car_rental_app/controllers/booking_controller.dart';
import 'package:car_rental_app/models/booking_model.dart';
import 'package:car_rental_app/providers/date_time_provider.dart';
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  final BookingController _controller = BookingController();
  final DateTimeProvider _provider = DateTimeProvider();

  List<Booking> _bookings = [];
  List<Booking> get bookings => _bookings;

  Booking? _recentBooking;
  Booking? get recentBooking => _recentBooking;

  Booking? _booking;
  Booking? get booking => _booking;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _bookingError;
  String? get bookingError => _bookingError;

  Future<void> loadBookings(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _bookings = await _controller.getUserBookings(userId);
      print('Loaded bookings: $_bookings');
    } catch(e) {
      throw Exception('Error Occurred');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getRecentBooking(String userId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      print('Fetching booking for user ID: $userId');
      _recentBooking = await _controller.getRecentBooking(userId);
      print('Recent booking fetched: ${_recentBooking != null ? 'YES' : 'NO'}');
      
      if (_recentBooking != null) {
        print('Recent booking details: ${_recentBooking.toString()}');
      }
    } catch (e) {
      print('Error fetching recent booking: $e');
      _recentBooking = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<Booking> bookingSummary(String userId, String bookingId) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final booking = await _controller.getBookingSummary(userId, bookingId);
  //     _booking = booking; // Store in the class variable
  //     print('Booking fetched: ${booking != null ? 'YES' : 'NO'}');
  //     print('Booking details: ${booking.toString()}');
  //     return booking;
  //   } catch (e) {
  //     print('Error fetching booking summary: $e');
  //     rethrow;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Add this method to create new bookings
  Future<bool> createBooking({
    required String userId,
    required String carId,
    required DateTime rentalStartDate,
    required DateTime rentalEndDate,
    required String from,
    required String to,
  }) async {
    _isLoading = true;
    _bookingError = null;
    notifyListeners();

    try {
      final result = await _controller.createBooking(
        userId: userId,
        carId: carId,
        rentalStartDate: rentalStartDate,
        rentalEndDate: rentalEndDate,
        from: from,
        to: to,
      );

      await _provider.resetAll();
      
      print('Booking created successfully: $result');
      
      // After successful booking, refresh the recent booking
      await getRecentBooking(userId);
      return true;
    } catch (e) {
      print('Error creating booking: $e');
      _bookingError = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
