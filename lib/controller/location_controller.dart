import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  var currentPosition = const LatLng(21.4735, 55.9754).obs;
  var currentAddress = 'Select Location'.obs;
  var streetName = 'Fetching...'.obs;
  var cityName = 'Fetching...'.obs;
  var countryName = '...'.obs;
  var savedAddresses = <SavedAddress>[].obs;
  var isLoading = false.obs;
  late GoogleMapController mapController;

  @override
  void onInit() {
    super.onInit();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      getCurrentLocation();
    } else {
      currentAddress.value = "Location permissions are denied.";
    }
  }

  void getCurrentLocation() async {
    try {
      isLoading.value = true;
      if (savedAddresses.isEmpty) {
        // Only navigate to PlacePickerScreen if no saved addresses
        Get.to(() => PlacePickerScreen(controller: this));
      } else {
        // Get address from the first saved location
        var firstAddress = savedAddresses.first;
        currentAddress.value = firstAddress.address;
        streetName.value = firstAddress.streetName;
        cityName.value = firstAddress.cityName;
        countryName.value = firstAddress.countryName;
      }
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
        streetName.value = place.locality ?? 'Unknown';
        cityName.value = place.street ?? 'Unknown';
        countryName.value = place.country ?? 'Unknown';
        savedAddresses.add(SavedAddress(
          title: "Custom Location",
          address: currentAddress.value,
          streetName: streetName.value,
          cityName: cityName.value,
          countryName: countryName.value,
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
        streetName: address.streetName,
        cityName: address.cityName,
        countryName: address.countryName,
      );
      savedAddresses.refresh();
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
  final String streetName;
  final String cityName;
  final String countryName;

  SavedAddress({
    required this.title,
    required this.address,
    required this.streetName,
    required this.cityName,
    required this.countryName,
  });
}

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
        Get.back();
      },
    );
  }
}
