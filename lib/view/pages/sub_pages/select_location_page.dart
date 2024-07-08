import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  final LocationController locationController = Get.put(LocationController());
  final searchController = TextEditingController();
  final String token = '1234567890';
  var uuid = const Uuid();
  List<dynamic> listOfLocation = [];

  @override
  void initState() {
    searchController.addListener(() {
      _onChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  _onChange() {
    placeSuggestion(searchController.text);
  }

  void placeSuggestion(String input) async {
    String apiKey = "AIzaSyAcEE-vXwPyOkwcPROiC3h17CdtJL8onKs";
    try {
      String baseUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        setState(() {
          listOfLocation = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception("Fail to load");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _editAddressTitle(BuildContext context, SavedAddress address) {
    final TextEditingController titleController =
        TextEditingController(text: address.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Address Title"),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Enter new title",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                locationController.updateAddressTitle(
                    address, titleController.text);
                Get.back();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _saveSearchedAddress(String description) {
    locationController.savedAddresses.add(SavedAddress(
      title: "Custom Location",
      address: description,
      streetName: locationController.streetName.value,
      cityName: locationController.cityName.value,
      countryName: locationController.countryName.value,
    ));
    searchController.clear();
    listOfLocation.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "Select Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                enabled: true,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/icons/search_icon.png"),
                  hintText: "Search for area, street name...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: searchController.text.isNotEmpty &&
                    listOfLocation.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: listOfLocation.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(listOfLocation[index]["description"]),
                        onTap: () {
                          _saveSearchedAddress(
                              listOfLocation[index]["description"]);
                        },
                      );
                    },
                  ),
                ),
              ),
              kHiegth20,
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/small_location_orange_icon.svg",
                  ),
                  kWidth15,
                  TextButton(
                    onPressed: locationController.getCurrentLocation,
                    child: const Text(
                      "Use my current location",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              kHiegth10,
              kDiver10,
              kHiegth20,
              const Text(
                "SAVED ADDRESSES",
                style: TextStyle(
                  color: kGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              kHiegth20,
              Expanded(
                child: Obx(
                  () => Column(
                    children: locationController.savedAddresses
                        .map((address) => ListTile(
                              leading: SvgPicture.asset(
                                "assets/svg/small_location_grey_icon.svg",
                              ),
                              title: Text(address.title),
                              subtitle: Text(address.address),
                              onTap: () => _editAddressTitle(context, address),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  locationController.deleteAddress(address);
                                },
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationController extends GetxController {
  var currentPosition = const LatLng(21.4735, 55.9754).obs;
  var currentAddress = 'Fetching location...'.obs;
  var streetName = 'Fetching...'.obs;
  var cityName = 'Fetching...'.obs;
  var countryName = 'Fetching...'.obs;
  var savedAddresses = <SavedAddress>[].obs;
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
    if (savedAddresses.isEmpty) {
      // Only navigate to PlacePickerScreen if no saved addresses
      Get.to(() => _PlacePickerScreen(this));
    } else {
      // Get address from the first saved location
      var firstAddress = savedAddresses.first;
      currentAddress.value = firstAddress.address;
      streetName.value = firstAddress.streetName;
      cityName.value = firstAddress.cityName;
      countryName.value = firstAddress.countryName;
    }
  }

  void updateCurrentLocation(LatLng newPosition) {
    currentPosition.value = newPosition;
    _getAddressFromLatLng(newPosition);
  }

  void _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      currentAddress.value =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      streetName.value = place.street!;
      cityName.value = place.locality!;
      countryName.value = place.country!;
      savedAddresses.add(SavedAddress(
        title: "Custom Location",
        address: currentAddress.value,
        streetName: streetName.value,
        cityName: cityName.value,
        
        countryName: countryName.value,
      ));
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

class _PlacePickerScreen extends StatelessWidget {
  final LocationController controller;

  _PlacePickerScreen(this.controller);

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
