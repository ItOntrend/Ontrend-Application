import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton_two.dart';
import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  LatLng _currentPosition = const LatLng(0, 0);
  String _currentAddress = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  void _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Could not get address";
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _currentPosition = position.target;
  }

  void _useCurrentLocation() {
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm delivery location'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextfieldWithMic(
              hintText: "Search for area, street name",
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 14.0,
                  ),
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                const Center(
                  child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: _useCurrentLocation,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      elevation: 5,
                    ),
                    child: const Text('Use current location'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('DELIVERING YOUR ORDER TO',
                    style: TextStyle(color: Colors.blue)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_currentAddress,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextButton(
                      onPressed: () {
                        // Implement change address functionality
                      },
                      child:
                          const Text('CHANGE', style: TextStyle(color: kRed)),
                    ),
                  ],
                ),
                const MainBottonTwo(name: "Confirm Location")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
