/*
import 'package:discountzshop/features/offers/screens/offerDetailsMainScreen.dart';
import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate childAspectRatio dynamically based on screen size
    // Base aspect ratio is 0.65, adjusted by screen dimensions
    final childAspectRatio = (screenWidth / screenHeight) * 1.25;

    // Calculate dynamic image height based on screen width
    final imageHeight =
        screenWidth * 0.35; // Scales image height relative to screen width

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: TColors.primaryColor.withOpacity(0.1),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "All Offers",
                    style: TextStyle(color: TColors.primaryColor),
                  ),
                  SizedBox(width: TSizes.sm / 2),
                  Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: TColors.primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: TColors.white.withOpacity(0.1),
                side: BorderSide(
                  color: TColors.grey,
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "Filter",
                    style: TextStyle(color: TColors.primaryColor),
                  ),
                  SizedBox(width: TSizes.sm / 2),
                  Icon(
                    Iconsax.filter,
                    color: TColors.primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(width: TSizes.sm),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: TColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio:
                childAspectRatio, // Adjusted to give more vertical space
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  OfferDetailsScreen()),
                );
              },
              child: OfferCard(
                imageUrl: index % 2 == 0
                    ? "https://images.unsplash.com/photo-1613166945886-166350fd43b1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    : "https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                brand: index % 2 == 0 ? "BATA" : "WALTON",
                title: index % 2 == 0
                    ? "WEINBRENNER SHARJAH BOO..."
                    : "WALTON APPLIANCE DISCOUNT OFF...",
                discount: "${(index + 1) * 10}% OFF",
                timeLeft: "27d: 1h: 30m",
                imageHeight: imageHeight,
              ),
            );
          },
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String title;
  final String discount;
  final String timeLeft;
  final double imageHeight;

  OfferCard({
    required this.imageUrl,
    required this.brand,
    required this.title,
    required this.discount,
    required this.timeLeft,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: TColors.primaryColor.withOpacity(0.05),
      ),
      */
/*elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),*//*

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: imageHeight,
                  // Slightly increased height for better visuals
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite_border,
                    color: TColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: TSizes.sm / 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: TSizes.sm / 2),
                Text(
                  discount,
                  style: TextStyle(
                    fontSize: 14,
                    color: TColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: TSizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: TColors.primaryColor,
                    ),
                    SizedBox(width: TSizes.sm / 2),
                    Expanded(
                      child: Text(
                        timeLeft,
                        style: TextStyle(
                          fontSize: 12,
                          color: TColors.darkGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: TSizes.sm / 2),
                TextButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: TColors.primaryColor,
                  ),
                  child: Text(
                    "VIEW",
                    style: TextStyle(
                        fontSize: 12,
                        color: TColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:discountzshop/features/offers/screens/offerDetailsMainScreen.dart';
import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/offerProvider.dart';

class OfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final childAspectRatio = (screenWidth / screenHeight) * 1.25;
    final imageHeight = screenWidth * 0.35;

    return ChangeNotifierProvider(
      create: (context) => OfferProvider()..fetchOffers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: TColors.primaryColor.withOpacity(0.1),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "All Offers",
                      style: TextStyle(color: TColors.primaryColor),
                    ),
                    SizedBox(width: TSizes.sm / 2),
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: TColors.primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: TColors.white.withOpacity(0.1),
                  side: BorderSide(
                    color: TColors.grey,
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(color: TColors.primaryColor),
                    ),
                    SizedBox(width: TSizes.sm / 2),
                    Icon(
                      Iconsax.filter,
                      color: TColors.primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(width: TSizes.sm),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: TColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Consumer<OfferProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.offers.isEmpty) {
              return Center(child: CircularProgressIndicator(color: TColors.primaryColor,));
            }
            if (provider.error != null) {
              return Center(child: Text('Error: ${provider.error}'));
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!provider.isLoading &&
                    provider.hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  provider.fetchOffers();
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: provider.refreshOffers,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: provider.offers.length + (provider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == provider.offers.length) {
                        return Center(child: CircularProgressIndicator(color: TColors.primaryColor,));
                      }
                      final offer = provider.offers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfferDetailsScreen(id: offer.id, initialTab: 2),
                            ),
                          );
                        },
                        child: OfferCard(
                          imageUrl: offer.image,
                          brand: offer.brandName,
                          title: offer.name,
                          discount: offer.badge,
                          timeLeft: _calculateTimeLeft(offer.expiryDate),
                          imageHeight: imageHeight,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _calculateTimeLeft(String expiryDate) {
    final expiry = DateTime.parse(expiryDate);
    final now = DateTime.now();
    final difference = expiry.difference(now);

    if (difference.isNegative) {
      return "Expired";
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    return "${days}d: ${hours}h: ${minutes}m";
  }
}
class OfferCard extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String title;
  final String discount;
  final String timeLeft;
  final double imageHeight;

  OfferCard({
    required this.imageUrl,
    required this.brand,
    required this.title,
    required this.discount,
    required this.timeLeft,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
    color: TColors.primaryColor.withOpacity(0.05),
    ),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: imageHeight,
                  // Slightly increased height for better visuals
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite_border,
                    color: TColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: TSizes.sm / 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: TSizes.sm / 2),
                Text(
                  discount,
                  style: TextStyle(
                    fontSize: 14,
                    color: TColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: TSizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: TColors.primaryColor,
                    ),
                    SizedBox(width: TSizes.sm / 2),
                    Expanded(
                      child: Text(
                        timeLeft,
                        style: TextStyle(
                          fontSize: 12,
                          color: TColors.darkGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: TSizes.sm / 2),
                TextButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: TColors.primaryColor,
                  ),
                  child: Text(
                    "VIEW",
                    style: TextStyle(
                        fontSize: 12,
                        color: TColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}