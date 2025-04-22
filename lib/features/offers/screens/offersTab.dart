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
