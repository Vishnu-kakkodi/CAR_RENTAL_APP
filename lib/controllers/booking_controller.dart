import 'package:car_rental_app/models/booking_model.dart';
import 'package:car_rental_app/services/api/booking_service.dart';

class BookingController {
  final BookingService _bookingService = BookingService();

  Future<List<Booking>> getUserBookings(String userId) async {
    return await _bookingService.fetchBookings(userId);
  }

    Future<Booking> getRecentBooking(String userId) async {
    return await _bookingService.fetchRecentBooking(userId);
  }


    Future<Map<String, dynamic>> createBooking({
    required String userId,
    required String carId,
    required DateTime rentalStartDate,
    required DateTime rentalEndDate,
    required String from,
    required String to,
  }) async {
    return await _bookingService.createBooking(
      userId: userId,
      carId: carId,
      startDate: rentalStartDate,
      endDate: rentalEndDate,
      startTime: from,
      endTime: to,
    );
  }
}
