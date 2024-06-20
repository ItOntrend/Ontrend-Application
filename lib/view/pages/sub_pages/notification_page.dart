import 'package:flutter/material.dart';
import 'package:ontrend_food_and_e_commerce/model/core/colors.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_all_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_ecart_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_food_bar.dart';
import 'package:ontrend_food_and_e_commerce/view/pages/sub_pages/tabs/n_groceries_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Notification"),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
          children: [
            Container(
              // Set a preferred height for the tab bar container
              height: 60.0,
              decoration: BoxDecoration(
                color: kTransparent, // Light grey background
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
              ),
              child: TabBar(
                dividerColor: kTransparent,
                isScrollable: false, // Disable scrolling
                indicator: const BoxDecoration(
                  // Remove indicator (no underline)
                  color: Colors.transparent,
                ),
                labelPadding: EdgeInsets.zero, // Remove default padding
                tabs: [
                  // Individual tab containers
                  _buildTabItem(
                    text: "All", isSelected: _selectedIndex == 0,
                    // Check if selected
                  ),
                  _buildTabItem(text: "Food", isSelected: _selectedIndex == 1),
                  _buildTabItem(
                      text: "Groceries", isSelected: _selectedIndex == 2),
                  _buildTabItem(
                      text: "E - Cart", isSelected: _selectedIndex == 3),
                ],
              ),
            ),
            const Expanded(
              // Use Expanded to fill remaining space
              child: TabBarView(
                // Content for each tab
                children: [
                  NAllBar(),
                  NFoodBar(),
                  NGroceriesBar(),
                  NEcartBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widget for building tab items
  Widget _buildTabItem({required String text, bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color:
            isSelected ? kOrange : Colors.grey[200], // Color based on selection
        border: Border.all(
          color: isSelected ? kTransparent : kGrey,
        ), // Light grey border
      ),
      child: Center(
        child: Text(
          text,
          maxLines: 1, // Ensure text stays on one line
          overflow: TextOverflow.ellipsis, // Handle potential truncation
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black54, // Text color based on selection
            fontSize: 14.0, // Adjust font size as needed
          ),
        ),
      ),
    );
  }
}
