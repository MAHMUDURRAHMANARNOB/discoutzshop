/*
import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OffersTab extends StatefulWidget {
  @override
  _OffersTabState createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Offer Card
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network(
                      'https://rajshahitech.com/wp-content/uploads/2024/08/Oraimo-Watch-4-plus-2.jpg',
                      // Replace with actual image URL
                      // width: 100,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '38% DISCOUNT',
                          style: TextStyle(
                              color: TColors.primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Oraimo Watch 4',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Experience a new era of connectivity with the Oraimo Watch 4 Plus BT Calling Smartwatch. Designed for seamless communication, this innovative device redefines how you stay connected on the go.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: TSizes.sm),
                        Divider(color: TColors.primaryColor),
                        SizedBox(height: TSizes.sm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: TColors.primaryColor.withOpacity(0.3)
                          ),
                          child: Text(
                            'EXPIRE: STILL AVAILABLE',
                            style: TextStyle(color: TColors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../datamodels/offersDataModel.dart';
import '../providers/offerProvider.dart'; // Ensure this import matches your file

class OffersTab extends StatefulWidget {
  final int brandId; // Kept for now, will remove if not needed

  const OffersTab({super.key, required this.brandId});

  @override
  _OffersTabState createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<OfferProvider>();
    if (provider.offers.isEmpty) {
      provider.refreshOffers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OfferProvider>();
    final offers = provider.offers; // Removed brandId filter until confirmed

    if (provider.isLoading && offers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return Center(child: Text('Error: ${provider.error}'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (offers.isNotEmpty) ...[
            for (var offer in offers)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: TColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.network(
                          offer.image ?? '', // Adjust to your field name
                          height: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${offer.offerPrice ?? '0%'} DISCOUNT', // Adjust to your field name
                              style: TextStyle(
                                color: TColors.primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              offer.name ?? 'Offer Name', // Adjust to your field name
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              offer.shortDescription ?? 'No description available.', // Adjust to your field name
                              style: const TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: TSizes.sm),
                            Divider(color: TColors.primaryColor),
                            SizedBox(height: TSizes.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: TColors.primaryColor.withOpacity(0.3),
                              ),
                              child: Text(
                                'EXPIRE: ${offer.expiryDate ?? 'STILL AVAILABLE'}', // Adjust to your field name
                                style: const TextStyle(color: TColors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ] else if (offers.isEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: Text('No offers available.')),
            ),
          ],
        ],
      ),
    );
  }
}
