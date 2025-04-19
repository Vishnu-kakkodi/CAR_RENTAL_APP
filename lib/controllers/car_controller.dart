import 'package:car_rental_app/models/car_model.dart';
import 'package:car_rental_app/providers/car_provider.dart';
import 'package:car_rental_app/services/api/car_service.dart';
class CarController {
  final CarProvider _provider;
  final CarService _service;

  CarController(this._provider, this._service);

  Future<void> initCars() async {
    await _provider.loadCars();
  }

  List<Car> getAllCars() {
    return _provider.cars;
  }

  void searchCars(String query) {
    final results = _provider.allCars.where((car) {
      final lowerQuery = query.toLowerCase();
      return car.name.toLowerCase().contains(lowerQuery) ||
             car.location.toLowerCase().contains(lowerQuery);
    }).toList();

    _provider.setFilteredCars(results);
  }

  Future<Car> getCarDetails(String id) async {
    return await _service.fetchCarById(id);
  }
}
