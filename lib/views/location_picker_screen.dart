import 'package:flutter/material.dart';
import 'package:car_rental_app/controllers/location_controller.dart';
import 'package:car_rental_app/providers/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  bool _isSearching = false;
  
  // Simulated locations for demonstration
  // In a real app, you would use a places API like Google Places
  final List<Map<String, dynamic>> _predefinedLocations = [
    {
      'name': 'Hyderabad Central Mall, Hyderabad',
      'coordinates': [78.4867, 17.3850]
    },
    {
      'name': 'Inorbit Mall, Hyderabad',
      'coordinates': [78.3807, 17.4432]
    },
    {
      'name': 'Forum Sujana Mall, Kukatpally',
      'coordinates': [78.4311, 17.4943]
    },
    {
      'name': 'JNTU College, Kukatpally',
      'coordinates': [78.3908, 17.4944]
    },
    {
      'name': 'KPHB Colony, Hyderabad',
      'coordinates': [78.4015, 17.4837]
    },
    {
      'name': 'Hitech City, Hyderabad',
      'coordinates': [78.3816, 17.4457]
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchLocations(String query) {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // In a real app, you would call a places API here
    // For demo purposes, we'll filter our predefined locations
    final filteredLocations = _predefinedLocations
        .where((location) =>
            location['name'].toLowerCase().contains(query.toLowerCase()))
        .map((location) => location['name'] as String)
        .toList();

    setState(() {
      _suggestions = filteredLocations;
      _isSearching = false;
    });
  }

  void _selectLocation(String locationName) async {
    final location = _predefinedLocations.firstWhere(
      (loc) => loc['name'] == locationName,
      orElse: () => {'name': locationName, 'coordinates': [0.0, 0.0]},
    );

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final locationController = LocationController(locationProvider);

    // Update location in provider
    await locationController.updateLocation(
      locationName,
      location['coordinates'] as List<double>,
    );

    // Go back to previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchLocations,
              decoration: InputDecoration(
                hintText: 'Search for location',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.my_location, color: Colors.blue),
                SizedBox(width: 12),
                TextButton(
                  onPressed: () async {
                    // Get current location
                    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
                    final locationController = LocationController(locationProvider);
                    await locationController.initLocation();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Use current location',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          _isSearching
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final location = _suggestions[index];
                      return ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(location),
                        onTap: () => _selectLocation(location),
                      );
                    },
                  ),
                ),
          if (_suggestions.isEmpty && _searchController.text.isNotEmpty && !_isSearching)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.location_off, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No locations found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Try a different search term',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}