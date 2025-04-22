import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'offerOverviewTab.dart';
import 'offerStoreTab.dart';
import 'offersTab.dart';

class OfferDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Offer Details'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Static Banner
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/offers_dami_image.png",
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            // Static Tab Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: TColors.grey.withOpacity(0.5), // Background color for the tab bar container
                borderRadius: BorderRadius.circular(64.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), // Added vertical padding for better spacing
              child: TabBar(
                dividerColor: Colors.transparent,
                labelColor: Colors.white, // Text color for the active tab
                unselectedLabelColor: TColors.black, // Text color for inactive tabs
                indicator: BoxDecoration(
                  color: TColors.primaryColor, // Background color for the active tab (orange in your case)
                  borderRadius: BorderRadius.circular(64.0), // Rounded corners for the active tab
                ),
                indicatorPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: -20), // Adjust the padding of the indicator
                labelStyle: TextStyle(fontWeight: FontWeight.bold), // Optional: Bold text for active tab
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal), // Optional: Normal text for inactive tabs
                tabs: [
                  Tab(text: 'Overview'),
                  Tab(text: 'Stores'),
                  Tab(text: 'Offers'),
                ],
              ),
            ),
            // TabBarView for dynamic content
            Expanded(
              child: TabBarView(
                children: [
                  OverviewTab(),
                  StoresTab(),
                  OffersTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
