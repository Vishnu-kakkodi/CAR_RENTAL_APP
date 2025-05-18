
// import 'package:flutter/material.dart';

// class FilterBox extends StatefulWidget {
//   const FilterBox({super.key});

//   @override
//   _FilterBoxState createState() => _FilterBoxState();
// }

// class _FilterBoxState extends State<FilterBox> {
//   String selectedType = 'Manual';
//   String selectedFuel = '';

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15,right: 5),
//       child: Container(
//         height: 321,
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Type", style: TextStyle(fontWeight: FontWeight.bold))),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: ['Manual', 'Automatic'].map((type) {
//                 bool isSelected = selectedType == type;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() => selectedType = type);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Color(0xFF0000FE) : Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.black),
//                     ),
//                     child: Text(type,
//                         style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black)),
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Fuel", style: TextStyle(fontWeight: FontWeight.bold))),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: ['Petrol', 'Diesel'].map((fuel) {
//                 bool isSelected = selectedFuel == fuel;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() => selectedFuel = fuel);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Color(0xFF0000FE) : Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.black),
//                     ),
//                     child: Text(fuel,
//                         style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black)),
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 60),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Colors.blue, Colors.indigo]),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Apply", style: TextStyle(color: Colors.white)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:car_rental_app/controllers/car_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rental_app/providers/car_provider.dart';

class FilterBox extends StatefulWidget {
  final CarController carController;

  const FilterBox({Key? key, required this.carController}) : super(key: key);

  @override
  _FilterBoxState createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  String selectedType = 'Manual'; // Default to Manual
  String selectedFuel = '';

  @override
  void initState() {
    super.initState();
    // Initialize selected values from provider if any
    final provider = Provider.of<CarProvider>(context, listen: false);
    if (provider.selectedType.isNotEmpty) {
      selectedType = provider.selectedType;
    }
    selectedFuel = provider.selectedFuel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Type",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedType = 'Manual');
                    },
                    child: Container(
                      height: 34,
                      margin: EdgeInsets.only(right: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedType == 'Manual' ? Color(0xFF0000FE) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedType == 'Manual' ? Colors.transparent : Colors.black12,
                        ),
                      ),
                      child: Text(
                        "Manual",
                        style: TextStyle(
                          color: selectedType == 'Manual' ? Colors.white : Colors.black,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedType = 'Automatic');
                    },
                    child: Container(
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedType == 'Automatic' ? Color(0xFF0000FE) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedType == 'Automatic' ? Colors.transparent : Colors.black12,
                        ),
                      ),
                      child: Text(
                        "Automatic",
                        style: TextStyle(
                          color: selectedType == 'Automatic' ? Colors.white : Colors.black,
                                                    fontSize: 18

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              "Fuel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                                color: Colors.black,

              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedFuel = selectedFuel == 'Petrol' ? '' : 'Petrol');
                    },
                    child: Container(
                      height: 34,
                      margin: EdgeInsets.only(right: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedFuel == 'Petrol' ? Color(0xFF0000FE) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedFuel == 'Petrol' ? Colors.transparent : Colors.black12,
                        ),
                      ),
                      child: Text(
                        "Petrol",
                        style: TextStyle(
                          color: selectedFuel == 'Petrol' ? Colors.white : Colors.black,
                                                    fontSize: 18

                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedFuel = selectedFuel == 'Diesel' ? '' : 'Diesel');
                    },
                    child: Container(
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedFuel == 'Diesel' ? Color(0xFF0000FE) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedFuel == 'Diesel' ? Colors.transparent : Colors.black12,
                        ),
                      ),
                      child: Text(
                        "Diesel",
                        style: TextStyle(
                          color: selectedFuel == 'Diesel' ? Colors.white : Colors.black,
                                                    fontSize: 18

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF0000FE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  widget.carController.applyFilters(
                    type: selectedType,
                    fuel: selectedFuel,
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Apply",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}