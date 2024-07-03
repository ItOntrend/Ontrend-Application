// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton_two.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;
//   LatLng _currentPosition = const LatLng(21.4735, 55.9754);
//   String _currentAddress = 'Fetching location...';

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, show an alert to the user.
//       setState(() {
//         _currentAddress = "Location services are disabled.";
//       });
//       return;
//     }

//     // Check for location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, show an alert to the user.
//         setState(() {
//           _currentAddress = "Location permissions are denied.";
//         });
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, show an alert to the user.
//       setState(() {
//         _currentAddress = "Location permissions are permanently denied.";
//       });
//       return;
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     try {
//       Position position = await Geolocator.getCurrentPosition();
//       setState(() {
//         _currentPosition = LatLng(position.latitude, position.longitude);
//       });
//       _getAddressFromLatLng(
//           _currentPosition); // Get address from the current coordinates
//       mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
//     } catch (e) {
//       // Handle any errors that might occur while retrieving the location
//       setState(() {
//         _currentAddress = "Could not get the current location.";
//       });
//     }
//   }

//   void _getAddressFromLatLng(LatLng position) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       setState(() {
//         _currentAddress = "Could not get address";
//       });
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _onCameraMove(CameraPosition position) {
//     _currentPosition = position.target;
//   }

//   void _useCurrentLocation() {
//     _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Confirm delivery location'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 GoogleMap(
//                   zoomControlsEnabled: false,
//                   onMapCreated: _onMapCreated,
//                   initialCameraPosition: CameraPosition(
//                     target: _currentPosition,
//                     zoom: 14.0,
//                   ),
//                   onCameraMove: _onCameraMove,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                 ),
//                 const Center(
//                   child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//                 ),
//                 const Padding(
//                   padding:  EdgeInsets.all(10.0),
//                   child: TextfieldWithMic(
//                     hintText: "Search for area, street name",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('DELIVERING YOUR ORDER TO',
//                     style: GoogleFonts.aBeeZee(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: kBlue)),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 250,
//                       child: Text(
//                         _currentAddress,
//                         maxLines: 2,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             overflow: TextOverflow.ellipsis),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Implement change address functionality
//                       },
//                       child:
//                           const Text('CHANGE', style: TextStyle(color: kRed)),
//                     ),
//                   ],
//                 ),
//                 kHiegth10,
//                 const MainBottonTwo(name: "Confirm Location")
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
