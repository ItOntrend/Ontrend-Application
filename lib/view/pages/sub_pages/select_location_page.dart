import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ontrend_food_and_e_commerce/controller/location_controller.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/model/core/constant.dart';
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
          title: Text("Edit Address Title".tr),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter new title".tr,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel".tr),
            ),
            TextButton(
              onPressed: () {
                locationController.updateAddressTitle(
                    address, titleController.text);
                Get.back();
              },
              child: Text("Save".tr),
            ),
          ],
        );
      },
    );
  }

  void _saveSearchedAddress(String description) {
    locationController.savedAddresses.add(SavedAddress(
      title: "Custom Location".tr,
      address: description,
      streetName: locationController.streetName.value,
      cityName: locationController.cityName.value,
      countryName: locationController.countryName.value,
      latitude: 0.0,
      longitude: 0.0,
    ));
    searchController.clear();
    listOfLocation.clear();
  }

  void _openPlacePicker() async {
    await Get.to(() => PlacePickerScreen(controller: locationController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Select Location".tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
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
                hintText: "Search for area, street name...".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ),
            Visibility(
              visible:
                  searchController.text.isNotEmpty && listOfLocation.isNotEmpty,
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
                  child: Text(
                    "Use my current location".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/small_add_orange_icon.svg",
                ),
                kWidth15,
                TextButton(
                  onPressed: _openPlacePicker,
                  child: Text(
                    "Add location from map".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            kHiegth10,
            kDiver10,
            kHiegth20,
            Text(
              "SAVED ADDRESSES".tr,
              style: TextStyle(
                color: kGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            kHiegth20,
            Expanded(
              child: Obx(
                () => ListView(
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
    );
  }
}
