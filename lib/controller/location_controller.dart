import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController extends GetxController {
  var currentPosition = const LatLng(21.4735, 55.9754).obs;
  var currentAddress = ''.obs;
  var subLocalityName = ''.obs;
  var streetName = ''.obs;
  var cityName = ''.obs;
  var countryName = ''.obs;
  var savedAddresses = <SavedAddress>[].obs;
  var isLoading = false.obs;
  late GoogleMapController mapController;

  @override
  void onInit() {
    super.onInit();
    _requestPermissions();
  }

  String removeFirstPart(String input) {
    List<String> parts = input.split(' ');
    if (parts.length > 1) {
      return parts.sublist(1).join(' ');
    } else {
      return input; // If there is only one part, return it as is.
    }
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      if (savedAddresses.isEmpty) {
        //getCurrentLocation();
        loadLocationFromPreferences();
      } else {
        // Handle logic if addresses are already saved
        // For example, set the current position to the first saved address
        currentPosition.value = LatLng(
          savedAddresses[0].latitude,
          savedAddresses[0].longitude,
        );
        currentAddress.value = savedAddresses[0].address;
      }
    } else {
      currentAddress.value = "Location permissions are denied.";
    }
  }

  void getCurrentLocation() async {
    try {
      isLoading.value = true;
      // Always navigate to PlacePickerScreen
      Get.to(() => PlacePickerScreen(controller: this));
    } catch (e) {
      currentAddress.value = "Failed to get current location.";
    } finally {
      isLoading.value = false;
    }
  }

  void updateCurrentLocation(LatLng newPosition) async {
    try {
      isLoading.value = true;
      currentPosition.value = newPosition;
      await _getAddressFromLatLng(newPosition);
      await saveLocationToPreferences(newPosition);
    } catch (e) {
      currentAddress.value = "Failed to update location.";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        currentAddress.value =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        subLocalityName.value = place.subLocality ?? 'Unknown';
        streetName.value = place.street ?? 'Unknown';
        cityName.value = place.locality ?? 'Unknown';
        countryName.value = place.country ?? 'Unknown';
        savedAddresses.add(SavedAddress(
          title: "Custom Location",
          address: currentAddress.value,
          subLocalityName: subLocalityName.value,
          streetName: streetName.value,
          cityName: cityName.value,
          countryName: countryName.value,
          latitude: position.latitude,
          longitude: position.longitude,
        ));
      } else {
        currentAddress.value = "No address found";
        streetName.value = "Unknown";
        cityName.value = "Unknown";
        countryName.value = "Unknown";
      }
    } catch (e) {
      currentAddress.value = "Could not get address";
      streetName.value = "Unknown";
      cityName.value = "Unknown";
      countryName.value = "Unknown";
    }
  }

  void updateAddressTitle(SavedAddress address, String newTitle) {
    final index = savedAddresses.indexOf(address);
    if (index != -1) {
      savedAddresses[index] = SavedAddress(
        title: newTitle,
        address: address.address,
        subLocalityName: address.subLocalityName,
        streetName: address.streetName,
        cityName: address.cityName,
        countryName: address.countryName,
        latitude: address.latitude,
        longitude: address.longitude,
      );
      
      savedAddresses.refresh();
    }
  }

  Future<void> saveLocationToPreferences(LatLng position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);
  }

  Future<void> loadLocationFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble('latitude');
    final longitude = prefs.getDouble('longitude');
    if (latitude != null && longitude != null) {
      updateCurrentLocation(LatLng(latitude, longitude));
    } else {
      getCurrentLocation();
    }
  }

  void deleteAddress(SavedAddress address) {
    savedAddresses.remove(address);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    currentPosition.value = position.target;
  }
}

class SavedAddress {
  final String title;
  final String address;
  final String subLocalityName;
  final String streetName;
  final String cityName;
  final String countryName;
  final double latitude;
  final double longitude;

  SavedAddress({
    required this.title,
    required this.address,
    required this.subLocalityName,
    required this.streetName,
    required this.cityName,
    required this.countryName,
    required this.latitude,
    required this.longitude,
  });
}

/*
class PlacePickerScreen extends StatelessWidget {
  final LocationController controller;

  const PlacePickerScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: "AIzaSyAcEE-vXwPyOkwcPROiC3h17CdtJL8onKs",
      initialPosition: controller.currentPosition.value,
      useCurrentLocation: true,
      selectInitialPosition: true,
      onPlacePicked: (result) {
        controller.updateCurrentLocation(
          LatLng(result.geometry!.location.lat, result.geometry!.location.lng),
        );
        Get.back();
      },
    );
  }
}*/
class PlacePickerScreen extends StatelessWidget {
  final LocationController controller;

  const PlacePickerScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: "AIzaSyAcEE-vXwPyOkwcPROiC3h17CdtJL8onKs",
      initialPosition: controller.currentPosition.value,
      useCurrentLocation: true,
      selectInitialPosition: true,
      onPlacePicked: (result) {
        controller.updateCurrentLocation(
          LatLng(result.geometry!.location.lat, result.geometry!.location.lng),
        );
        Get.back(); // Go back to the previous screen
        // You can add additional code here if needed
        // For example, save the location and navigate to the next page
        Get.snackbar(
          "Location Selected",
          "Your location has been updated.",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
