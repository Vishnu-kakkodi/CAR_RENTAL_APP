// import 'package:car_rental_app/services/api/car_service.dart';
// import 'package:flutter/material.dart';
// import 'package:car_rental_app/models/car_model.dart';

// class CarProvider with ChangeNotifier {
//   List<Car> _allCars = [];
//   List<Car> _filteredCars = [];
//   bool _isLoading = false;
//   String _errorMessage = '';

//   // Getters
//   List<Car> get allCars => _allCars;
//   List<Car> get cars => _filteredCars;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;
//   bool get hasError => _errorMessage.isNotEmpty;

//   // Set loading state
//   void setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   // Set error message
//   void setError(String message) {
//     _errorMessage = message;
//     notifyListeners();
//   }

//   // Clear error
//   void clearError() {
//     _errorMessage = '';
//     notifyListeners();
//   }

//   Future<void> loadCars(String type, String fuel) async {
//     try {
//       setLoading(true);
//       clearError();
      
//       // This simulates the API call that would be in CarService
//       // In your real code, you'll replace this with the actual service call
//       final fetchedCars = await CarService().fetchCars(type: type, fuel: fuel);
      
//       _allCars = fetchedCars;
//       _filteredCars = fetchedCars;
//     } catch (e) {
//       setError('Failed to load cars: ${e.toString()}');
//       _allCars = [];
//       _filteredCars = [];
//     } finally {
//       setLoading(false);
//     }
//   }

//   void setFilteredCars(List<Car> filtered) {
//     _filteredCars = filtered;
//     notifyListeners();
//   }
  
//   // New method to add a car to favorites (example of additional functionality)
//   void toggleFavorite(String carId) {
//     final carIndex = _allCars.indexWhere((car) => car.id == carId);
//     if (carIndex >= 0) {
//       // This assumes your Car model has an isFavorite property
//       // You would need to add this to your Car model
//       // _allCars[carIndex] = _allCars[carIndex].copyWith(isFavorite: !_allCars[carIndex].isFavorite);
      
//       // Also update in filtered cars if present
//       final filteredIndex = _filteredCars.indexWhere((car) => car.id == carId);
//       if (filteredIndex >= 0) {
//         // _filteredCars[filteredIndex] = _filteredCars[filteredIndex].copyWith(isFavorite: !_filteredCars[filteredIndex].isFavorite);
//       }
      
//       notifyListeners();
//     }
//   }
// }






// import 'package:car_rental_app/models/car_model.dart';
// import 'package:car_rental_app/services/api/car_service.dart';
// import 'package:flutter/material.dart';


// class CarProvider with ChangeNotifier {
//   List<Car> _allCars = [];
//   List<Car> _filteredCars = [];

//   List<Car> get allCars => _allCars;
//   List<Car> get cars => _filteredCars;

//   Future<void> loadCars() async {
//     final fetchedCars = await CarService().fetchCars();
//     _allCars = fetchedCars;
//     _filteredCars = fetchedCars;
//     notifyListeners();
//   }

//   void setFilteredCars(List<Car> filtered) {
//     _filteredCars = filtered;
//     notifyListeners();
//   }
// }



import 'package:car_rental_app/models/car_model.dart';
import 'package:car_rental_app/services/api/car_service.dart';
import 'package:flutter/material.dart';

class CarProvider with ChangeNotifier {
  List<Car> _allCars = [];
  List<Car> _filteredCars = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedType = '';
  String _selectedFuel = '';

  // Getters
  List<Car> get allCars => _allCars;
  List<Car> get cars => _filteredCars;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  String get selectedType => _selectedType;
  String get selectedFuel => _selectedFuel;

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> loadCars() async {
    try {
      setLoading(true);
      clearError();
      
      final fetchedCars = await CarService().fetchCars();
      
      _allCars = fetchedCars;
      _filteredCars = fetchedCars;
    } catch (e) {
      setError('Failed to load cars: ${e.toString()}');
      _allCars = [];
      _filteredCars = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> filterCars({String? type, String? fuel}) async {
    try {
      setLoading(true);
      clearError();
      
      if (type != null) _selectedType = type;
      if (fuel != null) _selectedFuel = fuel;
      
      if (_selectedType.isEmpty && _selectedFuel.isEmpty) {
        // If no filters, show all cars
        _filteredCars = _allCars;
      } else {
        // Apply filters
        _filteredCars = _allCars.where((car) {
          bool typeMatch = _selectedType.isEmpty || car.type == _selectedType;
          bool fuelMatch = _selectedFuel.isEmpty || car.fuel == _selectedFuel;
          return typeMatch && fuelMatch;
        }).toList();
      }
    } catch (e) {
      setError('Failed to filter cars: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  void setFilteredCars(List<Car> filtered) {
    _filteredCars = filtered;
    notifyListeners();
  }
  
  void clearFilters() {
    _selectedType = '';
    _selectedFuel = '';
    _filteredCars = _allCars;
    notifyListeners();
  }
}

