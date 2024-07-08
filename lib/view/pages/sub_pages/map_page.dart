// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton_two.dart';
// import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MapPage extends StatefulWidget {
//   MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
  

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
//                 Obx(() => GoogleMap(
//                       zoomControlsEnabled: false,
//                       onMapCreated: locationController.onMapCreated,
//                       initialCameraPosition: CameraPosition(
//                         target: locationController.currentPosition.value,
//                         zoom: 14.0,
//                       ),
//                       onCameraMove: locationController.onCameraMove,
//                       myLocationEnabled: true,
//                       myLocationButtonEnabled: false,
//                     )),
//                 const Center(
//                   child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(10.0),
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
//                     Obx(() => Container(
//                           width: 250,
//                           child: Text(
//                             locationController.currentAddress.value,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                         )),
//                     TextButton(
//                       onPressed: locationController._getCurrentLocation,
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























// // import 'package:flutter/material.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// // import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
// // import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
// // import 'package:ontrend_food_and_e_commerce/view/widgets/main_botton_two.dart';
// // import 'package:ontrend_food_and_e_commerce/view/widgets/textfield_with_mic.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // class MapPage extends StatelessWidget {
// //    MapPage({super.key});
// //    final LocationController locationController = Get.put(LocationController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Confirm delivery location'),
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: Stack(
// //               children: [
// //                 Obx(() => GoogleMap(
// //                   zoomControlsEnabled: false,
// //                   onMapCreated: locationController.onMapCreated,
// //                   initialCameraPosition: CameraPosition(
// //                     target: locationController.currentPosition.value,
// //                     zoom: 14.0,
// //                   ),
// //                   onCameraMove: locationController.onCameraMove,
// //                   myLocationEnabled: true,
// //                   myLocationButtonEnabled: false,
// //                 )),
// //                 const Center(
// //                   child: Icon(Icons.location_pin, color: Colors.red, size: 40),
// //                 ),
// //                 const Padding(
// //                   padding: EdgeInsets.all(10.0),
// //                   child: TextfieldWithMic(
// //                     hintText: "Search for area, street name",
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('DELIVERING YOUR ORDER TO',
// //                     style: GoogleFonts.aBeeZee(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.bold,
// //                         color: kBlue)),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Obx(() => Container(
// //                       width: 250,
// //                       child: Text(
// //                         locationController.currentAddress.value,
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                         style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 16),
// //                       ),
// //                     )),
// //                     TextButton(
// //                       onPressed: locationController._getCurrentLocation,
// //                       child: const Text('CHANGE', style: TextStyle(color: kRed)),
// //                     ),
// //                   ],
// //                 ),
// //                 kHiegth10,
// //                 const MainBottonTwo(name: "Confirm Location")
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class LocationController extends GetxController {
// //   var currentPosition = const LatLng(21.4735, 55.9754).obs;
// //   var currentAddress = 'Fetching location...'.obs;
// //   late GoogleMapController mapController;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     _requestPermissions();
// //   }

// //   Future<void> _requestPermissions() async {
// //     var status = await Permission.location.request();
// //     if (status.isGranted) {
// //       _getCurrentLocation();
// //     } else {
// //       currentAddress.value = "Location permissions are denied.";
// //     }
// //   }

// //   void _getCurrentLocation() {
// //     Get.to(() => PlacePicker(
// //       apiKey: "AIzaSyAcEE-vXwPyOkwcPROiC3h17CdtJL8onKs", 
// //       initialPosition: currentPosition.value,
// //       useCurrentLocation: true,
// //       selectInitialPosition: true,
// //       onPlacePicked: (result) {
// //         currentPosition.value = LatLng(result.geometry!.location.lat, result.geometry!.location.lng);
// //         _getAddressFromLatLng(currentPosition.value);
// //         mapController.animateCamera(CameraUpdate.newLatLng(currentPosition.value));
// //         Get.back();
// //       },
// //     ));
// //   }

// //   void _getAddressFromLatLng(LatLng position) async {
// //     try {
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         position.latitude,
// //         position.longitude,
// //       );
// //       Placemark place = placemarks[0];
// //       currentAddress.value =
// //           "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
// //     } catch (e) {
// //       currentAddress.value = "Could not get address";
// //     }
// //   }

// //   void onMapCreated(GoogleMapController controller) {
// //     mapController = controller;
// //   }

// //   void onCameraMove(CameraPosition position) {
// //     currentPosition.value = position.target;
// //   }
// // }
