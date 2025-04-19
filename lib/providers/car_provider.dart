import 'package:car_rental_app/models/car_model.dart';
import 'package:car_rental_app/services/api/car_service.dart';
import 'package:flutter/material.dart';


class CarProvider with ChangeNotifier {
  List<Car> _allCars = [];
  List<Car> _filteredCars = [];

  List<Car> get allCars => _allCars;
  List<Car> get cars => _filteredCars;

  Future<void> loadCars() async {
    final fetchedCars = await CarService().fetchCars();
    _allCars = fetchedCars;
    _filteredCars = fetchedCars;
    notifyListeners();
  }

  void setFilteredCars(List<Car> filtered) {
    _filteredCars = filtered;
    notifyListeners();
  }
}
