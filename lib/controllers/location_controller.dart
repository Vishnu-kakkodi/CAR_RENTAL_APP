// lib/controllers/location_controller.dart
import 'package:car_rental_app/providers/location_provider.dart';

class LocationController {
  final LocationProvider _provider;

  LocationController(this._provider);

  Future<void> initLocation() async {
    await _provider.initLocation();
  }

  Future<void> updateLocation(String address, List<double> coordinates) {
    _provider.updateLocation(address, coordinates);
    return Future.value();
  }
}