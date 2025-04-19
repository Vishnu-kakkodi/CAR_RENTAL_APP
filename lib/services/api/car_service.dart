import 'dart:convert';

import 'package:car_rental_app/models/car_model.dart';
import 'package:http/http.dart' as http;

class CarService{
  final String baseUrl = 'https://carrentalbackent.onrender.com/api';

  Future <List<Car>> fetchCars() async {
    final response = await http.get(Uri.parse('$baseUrl/car/get-cars'));

    if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
      return data.map((json) => Car.fromJson(json)).toList();
    }else{
      throw Exception('Failed to Load cars');
    }
  }

  Future<Car> fetchCarById(String id) async {
    try{
      print('iiiid:$id');
      print('URL: $baseUrl/getcar/$id');
      final response = await http.get(Uri.parse('$baseUrl/car/getcar/$id'));
      print(response.statusCode);
      if(response.statusCode == 200){
        return Car.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load car details');
      }
    }catch(e){
      print('errrrrrrrrrrrrrr$e');
      throw Exception('Internal Error');
    }
  }
}