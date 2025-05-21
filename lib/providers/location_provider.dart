// lib/providers/location_provider.dart
import 'package:car_rental_app/services/location/location_service.dart';
import 'package:flutter/foundation.dart';

class LocationProvider with ChangeNotifier {
  String _address = 'Fetching location...';
  List<double>? _coordinates;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  // Getters
  String get address => _address;
  List<double>? get coordinates => _coordinates;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  // Initialize location
  Future<void> initLocation() async {
    try {
      _isLoading = true;
      _hasError = false;
      notifyListeners();

      // Get coordinates
      final coords = await LocationService.getCurrentCoordinates();
      if (coords != null) {
        _coordinates = coords;
      } else {
        throw Exception('Failed to get coordinates');
      }

      // Get address
      final fullAddress = await LocationService.getCurrentAddress();
      if (fullAddress != null) {
        // Format address to show only essential parts
        List<String> parts = fullAddress.split(',');
        String trimmedAddress = parts.length > 1 
            ? parts.sublist(0, 2).join(',').trim() 
            : fullAddress;
        _address = trimmedAddress;
      } else {
        throw Exception('Failed to get address');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Update location manually (for "Change" button)
  void updateLocation(String newAddress, List<double> newCoordinates) {
    _address = newAddress;
    _coordinates = newCoordinates;
    notifyListeners();
  }
}