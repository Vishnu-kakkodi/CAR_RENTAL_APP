import 'package:car_rental_app/services/api/booking_summary_service.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_app/models/booking_summary_model.dart';

class BookingSummaryProvider with ChangeNotifier {
  final BookingSummaryService _services = BookingSummaryService();

  BookingSummary? _bookingSummary;
  BookingSummary? get bookingSummary => _bookingSummary;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// Fetch booking summary using userId and bookingId
Future<BookingSummary> fetchBookingSummary(String userId, String bookingId) async {
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    print("helooooooooooooooooooooooooooooooo");
    final summary = await _services.getBookingSummary(userId, bookingId);
    _bookingSummary = summary;
    print('Booking Summary fetched: ${summary.booking}');
    return summary; // Return the summary object here
  } catch (e) {
    _error = 'Failed to fetch booking summary: $e';
    print(_error);
    throw e; // Re-throw the error so the FutureBuilder can handle it
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
}
