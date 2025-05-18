

// import 'dart:convert';

// import 'package:car_rental_app/models/car_model.dart';
// import 'package:http/http.dart' as http;

// class CarService{
//   final String baseUrl = 'https://carrentalbackent.onrender.com/api';

// Future<List<Car>> fetchCars() async {
//   final response = await http.get(Uri.parse('$baseUrl/car/get-cars'));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//     final List data = jsonResponse['cars']; // ✅ Extract the 'cars' list
//     return data.map((json) => Car.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load cars');
//   }
// }


//   Future<Car> fetchCarById(String id) async {
//     try{
//       print('iiiid:$id');
//       print('URL: $baseUrl/getcar/$id');
//       final response = await http.get(Uri.parse('$baseUrl/car/getcar/$id'));
//       print(response.statusCode);
//       if(response.statusCode == 200){
//         return Car.fromJson(json.decode(response.body));
//       }else{
//         throw Exception('Failed to load car details');
//       }
//     }catch(e){
//       print('errrrrrrrrrrrrrr$e');
//       throw Exception('Internal Error');
//     }
//   }
// }




import 'dart:convert';

import 'package:car_rental_app/models/car_model.dart';
import 'package:http/http.dart' as http;

class CarService {
  final String baseUrl = 'https://carrentalbackent.onrender.com/api';

  Future<List<Car>> fetchCars({String? type, String? fuel}) async {
    // Build the URL with query parameters if they exist
    String url = '$baseUrl/car/get-cars';
    
    if (type != null && type.isNotEmpty || fuel != null && fuel.isNotEmpty) {
      List<String> queryParams = [];
      
      if (type != null && type.isNotEmpty) {
        queryParams.add('type=$type');
      }
      
      if (fuel != null && fuel.isNotEmpty) {
        queryParams.add('fuel=$fuel');
      }
      
      if (queryParams.isNotEmpty) {
        url = '$url?${queryParams.join('&')}';
      }
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List data = jsonResponse['cars'];
      return data.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }

  Future<Car> fetchCarById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/car/getcar/$id'));
      
      if (response.statusCode == 200) {
        return Car.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load car details');
      }
    } catch (e) {
      throw Exception('Internal Error: $e');
    }
  }
}