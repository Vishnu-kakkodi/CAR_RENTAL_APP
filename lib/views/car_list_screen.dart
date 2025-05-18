
// import 'package:car_rental_app/controllers/car_controller.dart';
// import 'package:car_rental_app/models/car_model.dart';
// import 'package:car_rental_app/providers/car_provider.dart';
// import 'package:car_rental_app/services/api/car_service.dart';
// import 'package:car_rental_app/views/booking_confirmation_screen.dart';
// import 'package:car_rental_app/views/car_booking_detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:car_rental_app/utils/custom_icon.dart';
// import 'package:car_rental_app/views/car_detail_screen.dart';
// import 'package:car_rental_app/widgect/filter_box.dart';
// import 'package:provider/provider.dart';

// class CarListScreen extends StatefulWidget {
//   CarListScreen({super.key});

//   @override
//   State<CarListScreen> createState() => _CarListScreenState();
// }

// class _CarListScreenState extends State<CarListScreen> {
//   late CarController _carController;
//   List<Car> _filteredCar =[];
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState(){
//     super.initState();
//     final provider = Provider.of<CarProvider>(context,listen: false);
//     final service = CarService();
//     _carController = CarController(provider,service);
//     _carController.initCars();
//   }

//   void _onSerchChange(String value){
//     _carController.searchCars(value);
//   }

//   @override
//   Widget build(BuildContext context) {

//     final cars = context.watch<CarProvider>().cars;
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 60),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.black),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: 25),
//               Expanded(
//                 child: Row(
//                   children: [
//                     const Text(
//                       "Kukatpally, Jntuk...",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w800,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "Change",
//                         style: TextStyle(
//                           color: Color(0xFF1E0AFE),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: _onSerchChange,
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       prefixIcon: Icon(Icons.search),
//                       filled: true,
//                       fillColor: Colors.grey.shade200,
//                       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 10),
//                 IconButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       barrierColor: Colors.transparent,
//                       builder:
//                           (context) => Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 80.0,
//                                 right: 10,
//                               ),
//                               child: Material(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: FilterBox(),
//                               ),
//                             ),
//                           ),
//                     );
//                   },
//                   icon: ExactIcon(size: 24),
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                   splashRadius: 24,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: cars.isEmpty
//             ? const Center(child: Text("No Cars Found"),)
//             :ListView.builder(
//               itemCount: cars.length,
//               padding: EdgeInsets.all(16),
//               itemBuilder: (context, index) {
//                 final car = cars[index];
//                 return Container(
//                   margin: EdgeInsets.only(bottom: 16),
//                   height: 263,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(color: Colors.black12, blurRadius: 5),
//                     ],
//                     color: Colors.white,
//                   ),
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: GestureDetector(
//                           onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> BookingConfirmationScreen(carImageUrl: car.image[0],carName: car.name,pricePerDay: car.pricePerHour,carId: car.id,)));

//                           },
//                           child: Image.network(
//                             car.image[0],
//                             width: double.infinity,
//                             height: 263,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Color(0xFF8A935D), Color(0xFF4A522B)],
//                               begin: Alignment.centerLeft,
//                               end: Alignment.centerRight,
//                             ),
//                             borderRadius: BorderRadius.circular(6),
//                           ),
                
//                           child: Text(
//                             car.location,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(12),
//                               bottomRight: Radius.circular(12),
//                             ),
//                             color: const Color.fromARGB(255, 160, 160, 160),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 car.name,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Text(
//                                 '₹${(car.pricePerHour).toString()} / hr',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






import 'package:car_rental_app/controllers/car_controller.dart';
import 'package:car_rental_app/models/car_model.dart';
import 'package:car_rental_app/providers/car_provider.dart';
import 'package:car_rental_app/services/api/car_service.dart';
import 'package:car_rental_app/views/booking_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_app/utils/custom_icon.dart';
import 'package:car_rental_app/widgect/filter_box.dart';
import 'package:provider/provider.dart';

class CarListScreen extends StatefulWidget {
  CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  late CarController _carController;
  final TextEditingController _searchController = TextEditingController();
  final String userId = "68276e228eef71579fc0d616";
  final String bookingId = "682778088eef71579fc0d627";

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CarProvider>(context, listen: false);
    final service = CarService();
    _carController = CarController(provider, service);
    _carController.initCars();
  }

  void _onSearchChange(String value) {
    _carController.searchCars(value);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CarProvider>();
    final cars = provider.cars;
    final isLoading = provider.isLoading;
    final hasError = provider.hasError;
    final errorMessage = provider.errorMessage;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: Row(
                  children: [
                    const Text(
                      "Kukatpally, Jntuk...",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Change",
                        style: TextStyle(
                          color: Color(0xFF1E0AFE),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChange,
                    decoration: InputDecoration(
                      hintText: 'Search cars...',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black54,
                            builder: (context) => Center(
                              child: FilterBox(carController: _carController),
                            ),
                          );
                        },
                        icon: ExactIcon(size: 24),
                        padding: EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                        splashRadius: 24,
                      ),
                      if (provider.selectedType.isNotEmpty || provider.selectedFuel.isNotEmpty)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Active filters display
          if (provider.selectedType.isNotEmpty || provider.selectedFuel.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (provider.selectedType.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(provider.selectedType),
                          backgroundColor: Colors.blue.shade100,
                          deleteIcon: Icon(Icons.close, size: 16),
                          onDeleted: () {
                            _carController.applyFilters(
                              type: '',
                              fuel: provider.selectedFuel,
                            );
                          },
                        ),
                      ),
                    if (provider.selectedFuel.isNotEmpty)
                      Chip(
                        label: Text(provider.selectedFuel),
                        backgroundColor: Colors.blue.shade100,
                        deleteIcon: Icon(Icons.close, size: 16),
                        onDeleted: () {
                          _carController.applyFilters(
                            type: provider.selectedType,
                            fuel: '',
                          );
                        },
                      ),
                    if (provider.selectedType.isNotEmpty || provider.selectedFuel.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          _carController.clearFilters();
                        },
                        child: Text(
                          "Clear All",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : hasError
                    ? Center(child: Text(errorMessage))
                    : cars.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.car_crash,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "No Cars Found",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  provider.selectedType.isNotEmpty || provider.selectedFuel.isNotEmpty
                                      ? "Try changing your filters"
                                      : "Try searching for a different location",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: cars.length,
                            padding: EdgeInsets.all(16),
                            itemBuilder: (context, index) {
                              final car = cars[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 16),
                                height: 263,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black12, blurRadius: 5),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BookingConfirmationScreen(
                                                carImageUrl: car.image[0],
                                                carName: car.name,
                                                pricePerDay: car.pricePerHour,
                                                carId: car.id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          car.image[0],
                                          width: double.infinity,
                                          height: 263,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey.shade200,
                                              child: Center(
                                                child: Icon(
                                                  Icons.car_rental,
                                                  size: 50,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Color(0xFF8A935D), Color(0xFF4A522B)],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          car.location,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Display car type and fuel if available
                                    if (car.type != null || car.fuel != null)
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Row(
                                          children: [
                                            if (car.type != null)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade700,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  car.type!,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            SizedBox(width: 5),
                                            if (car.fuel != null)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange.shade700,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  car.fuel!,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                          color: const Color.fromARGB(255, 160, 160, 160),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              car.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              '₹${(car.pricePerHour).toString()} / hr',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}