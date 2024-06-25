import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';

class CountrySelectionField extends StatefulWidget {
  final Function(String) onCountrySelected;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CountrySelectionField({
    super.key,
    required this.onCountrySelected,
    this.controller,
    this.validator,
  });

  @override
  State<CountrySelectionField> createState() => _CountrySelectionFieldState();
}

class _CountrySelectionFieldState extends State<CountrySelectionField> {
  TextEditingController countryController = TextEditingController();

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      countryListTheme: const CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: kBlack),
        bottomSheetHeight: 500, // Optional. Country list modal height
        // Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        // Optional. Styles the search field.
        inputDecoration: InputDecoration(
          hintText: 'Start typing to search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: kBlack,
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          countryController.text = country.name;
        });
        widget.onCountrySelected(country.name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showCountryPicker,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kGrey,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AbsorbPointer(
          child: TextFormField(
            controller: countryController,
            decoration: InputDecoration(
              hintText: "Select Nationality",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
      ),
    );
  }
}
