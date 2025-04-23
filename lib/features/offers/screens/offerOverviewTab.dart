import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OverviewTab extends StatefulWidget {
  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXPLORE MORE WITH ORAIMO\nINNOVATIVE SMART ACCESSORIES FOR\nTHE ADVENTUROUS SPIRIT!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Keep exploring with oraimo, a brand dedicated to creating innovative and stylish smart accessories for young, adventurous individuals worldwide. Each product is thoughtfully designed to inspire creativity and add excitement to everyday life. Whether you\'re staying connected, enhancing your tech experience, or exploring new possibilities, oraimo empowers you to embrace every moment with style and functionality.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://app-area.riointernational.com.bd/productImages/1735124163iPe3e.webp', // Replace with actual image URL
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: TSizes.spaceBtwItems/2),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://www.startech.com.bd/image/cache/catalog/smart-watch/oraimo/watch-5/oraimo-watch-5-berry-grey-500x500.webp', // Replace with actual image URL
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'DIVE INTO THE DYNAMIC WORLD OF ORAIMO\nSEE THE POWER, FEEL THE BEAT!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Oraimo Fans! We are absolutely thrilled to invite you to an exclusive journey into the dynamic world of Oraimo! Get ready to immerse yourself in an unforgettable experience as you SEE THE POWER of our cutting-edge innovations and FEEL THE BEAT of unmatched quality and performance. Be part of this extraordinary adventure and discover the heart and soul of what makes Oraimo truly exceptional. Don\'t miss out - let\'s dive in together!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}