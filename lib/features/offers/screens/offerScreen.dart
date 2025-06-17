import 'package:discountzshop/features/brands/screens/BrandsDetailsMainScreen.dart';
import 'package:discountzshop/features/offers/screens/OfferDetailsScreen.dart';
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "All Offers",
                      style: TextStyle(color: TColors.darkerGrey),
                    ),
                    SizedBox(width: TSizes.sm / 2),
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      size: 18,
                      color: TColors.primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              TextButton(
                style: TextButton.styleFrom(
                  // backgroundColor: TColors.white.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(
                    color: TColors.grey,
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(color: TColors.black),
                    ),
                    SizedBox(width: TSizes.sm / 2),
                    Icon(
                      Iconsax.filter_copy,
                      size: 18,
                      color: TColors.primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(width: TSizes.sm),
              Expanded(
                child: TextField(

                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      CupertinoIcons.search,
                      color: TColors.darkGrey,
                    ),
                    hintText: "Search here...",
                    hintStyle: TextStyle(color: TColors.darkGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
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
              return Center(
                  child: CircularProgressIndicator(
                color: TColors.primaryColor,
              ));
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
                    itemCount:
                        provider.offers.length + (provider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == provider.offers.length) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: TColors.primaryColor,
                        ));
                      }
                      final offer = provider.offers[index];
                      return GestureDetector(
                        onTap: () {
                          print("sending slug from offertab - ${offer.slug}");
                          if(offer.slug!=null)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfferDetailsScreen(
                                slug: offer.slug!,
                              ),
                            ),
                          );
                          else{
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Oops!!"),
                                content: const Text("Sorry, this item is not available right now"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("okay"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: OfferCard(
                          imageUrl: offer.image??"",
                          brand: offer.brandName??"",
                          title: offer.name,
                          discount: offer.badge,
                          timeLeft: offer.expiryDate!=null?_calculateTimeLeft(offer.expiryDate!):"",
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
  final String? imageUrl;
  final String? brand;
  final String? title;
  final String? discount;
  final String timeLeft;
  final double imageHeight;

  OfferCard({
    this.imageUrl,
    this.brand,
    this.title,
    this.discount,
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
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Stack(
              children: [
                Image.network(
                  imageUrl ?? '', // Fallback to empty string if null
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey[300]),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand ?? 'Unknown Brand', // Fallback text
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: TSizes.sm / 2),
                Text(
                  title ?? 'No Title', // Fallback text
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: TSizes.sm / 2),
                Text(
                  discount ?? 'No Discount', // Fallback text
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
