import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

class LocationPickerScreen extends StatefulWidget {
  final String title;

  const LocationPickerScreen({
    super.key,
    required this.title,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(37.7749, -122.4194); // Default to San Francisco
  Marker? _selectedMarker;
  String _selectedAddress = "";
  bool _isSearching = false;
  
  // Create a Places API client
  final places = GoogleMapsPlaces(apiKey: "YOUR_API_KEY_HERE");

  // List to store search results
  List<PlacesSearchResult> _searchResults = [];
  bool _showSearchResults = false;

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isSearching = true;
    });

    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions denied');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions permanently denied');
      }
      
      // Get current position
      final Position position = await Geolocator.getCurrentPosition();
      
      final location = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentPosition = location;
        _updateMarker(location);
      });
      
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(location, 15));
      _getAddressFromLatLng(location);
    } catch (e) {
      print('Error getting location: $e');
      // Fall back to default location
      setState(() {
        _isSearching = false;
        _currentPosition = const LatLng(37.7749, -122.4194);
        _updateMarker(_currentPosition);
        _getAddressFromLatLng(_currentPosition);
      });
    }
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _selectedMarker = Marker(
        markerId: const MarkerId("selected_location"),
        position: position,
        draggable: true,
        onDragEnd: (newPosition) {
          _getAddressFromLatLng(newPosition);
        },
      );
    });
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      setState(() {
        _isSearching = true;
      });

      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];
        
        // Format address, filtering out null or empty components
        List<String> addressComponents = [
          place.street ?? '',
          place.subLocality ?? '',
          place.locality ?? '',
          place.postalCode ?? '',
          place.country ?? ''
        ].where((component) => component.isNotEmpty).toList();
        
        setState(() {
          _selectedAddress = addressComponents.join(', ');
          _isSearching = false;
        });
      } else {
        setState(() {
          _selectedAddress = "Address not found";
          _isSearching = false;
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        _selectedAddress = "Error retrieving address";
        _isSearching = false;
      });
    }
  }

  Future<void> _searchPlace(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isSearching = true;
      _showSearchResults = true;
    });

    try {
      final response = await places.searchByText(
        query,
        // Optional: bias results to current map area
        location: Location(lat: _currentPosition.latitude, lng: _currentPosition.longitude),
        radius: 50000, // 50km radius
      );
      
      if (response.status == "OK" && response.results.isNotEmpty) {
        setState(() {
          _searchResults = response.results;
          _isSearching = false;
        });
      } else {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No locations found')),
        );
      }
    } catch (e) {
      print('Search error: $e');
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Search error: ${e.toString()}')),
      );
    }
  }

  void _selectSearchResult(PlacesSearchResult result) {
    if (result.geometry?.location != null) {
      final location = LatLng(
        result.geometry!.location.lat,
        result.geometry!.location.lng,
      );
      
      setState(() {
        _currentPosition = location;
        _updateMarker(location);
        _showSearchResults = false;
        _searchController.text = result.name;
      });
      
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(location, 15));
      _getAddressFromLatLng(location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _selectedAddress.isNotEmpty
                ? () {
                    Navigator.pop(
                      context,
                      {
                        "address": _selectedAddress,
                        "coordinates": [
                          _currentPosition.longitude,
                          _currentPosition.latitude
                        ],
                      },
                    );
                  }
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search for a location",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _isSearching
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_searchController.text.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _showSearchResults = false;
                                      _searchResults = [];
                                    });
                                  },
                                ),
                              IconButton(
                                icon: const Icon(Icons.my_location),
                                onPressed: _getCurrentLocation,
                              ),
                            ],
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length >= 2) {
                      _searchPlace(value);
                    } else if (value.isEmpty) {
                      setState(() {
                        _showSearchResults = false;
                      });
                    }
                  },
                ),
                
                // Search Results
                if (_showSearchResults && _searchResults.isNotEmpty)
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.transparent,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: _searchResults.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final result = _searchResults[index];
                            return ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(
                                result.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                result.formattedAddress ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () => _selectSearchResult(result),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Map View
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  markers: _selectedMarker != null
                      ? {_selectedMarker!}
                      : {},
                  onTap: (position) {
                    setState(() {
                      _currentPosition = position;
                      _updateMarker(position);
                      _showSearchResults = false;
                    });
                    _getAddressFromLatLng(position);
                  },
                ),
                if (_isSearching && !_showSearchResults)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),

          // Selected Address Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selected Location",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _isSearching && !_showSearchResults
                    ? const LinearProgressIndicator()
                    : Text(
                        _selectedAddress.isEmpty
                            ? "Tap on the map to select a location"
                            : _selectedAddress,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedAddress.isNotEmpty
                        ? () {
                            Navigator.pop(
                              context,
                              {
                                "address": _selectedAddress,
                                "coordinates": [
                                  _currentPosition.longitude,
                                  _currentPosition.latitude
                                ],
                              },
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Confirm Location"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}