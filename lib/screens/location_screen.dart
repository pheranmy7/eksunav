import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    print("Mapbox map created successfully!");
  }

  @override
  Widget build(BuildContext context) {
    const String ACCESS_TOKEN =
        "pk.eyJ1IjoiZmVyYW5taTA3IiwiYSI6ImNtNW5qYnF4cTA5ajUyaXM2YTI3OTl0NmcifQ.Pw1_pNFDMOhb9AI_KWdk4A"; // Replace with actual token.
    MapboxOptions.setAccessToken(ACCESS_TOKEN);

    return Scaffold(
      body: Stack(
        children: [
          // Mapbox Map Widget (covering the whole screen)
          MapWidget(
            key: const ValueKey("mapWidget"),
            onMapCreated: _onMapCreated,
            cameraOptions: CameraOptions(
              center: Point(
                  coordinates: Position(
                      -3.1883, 55.9533)), // Example: Edinburgh, Scotland
              zoom: 9.0, // Adjust the zoom level based on your preference
              bearing: 0.0,
              pitch: 0.0,
            ),
          ),
          // Custom AppBar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First white box
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.location_on,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "My Location",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Second white box
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue[100],
                          child: const Icon(Icons.check, color: Colors.blue),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Destination",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/location');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
