import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../offers/screens/offerDetailsMainScreen.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brands"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              child: Image.asset(
                'assets/images/all_popular_brands.png', // Replace with actual banner URL
              ),
            ),
            // Beauty & Care Section 1
            _buildSection(
              title: 'Beauty & Care',
              items: [
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg', // Replace with actual URLs
                'https://news.sharetrip.net/wp-content/uploads/2024/09/cropped-full-logo.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Bata.svg/2560px-Bata.svg.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://news.sharetrip.net/wp-content/uploads/2024/09/cropped-full-logo.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Bata.svg/2560px-Bata.svg.png',
              ],
            ),
            // Fashion & Lifestyle Section
            _buildSection(
              title: 'Fashion & Lifestyle',
              items: [
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://news.sharetrip.net/wp-content/uploads/2024/09/cropped-full-logo.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Bata.svg/2560px-Bata.svg.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://news.sharetrip.net/wp-content/uploads/2024/09/cropped-full-logo.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Bata.svg/2560px-Bata.svg.png',
              ],
            ),
            // Beauty & Care Section 2
            _buildSection(
              title: 'Beauty & Care',
              items: [
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://news.sharetrip.net/wp-content/uploads/2024/09/cropped-full-logo.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Bata.svg/2560px-Bata.svg.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://news.sharetrip.net/wp-content/uploads/2024/09/cropped-full-logo.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Bata.svg/2560px-Bata.svg.png',
              ],
              showSeeMore: true,
            ),
            // Electronics & Gadgets Section
            _buildSection(
              title: 'Electronics & Gadgets',
              items: [
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://news.sharetrip.net/wp-content/uploads/2024/09/cropped-full-logo.png',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Foodpanda_logo_since_2017.jpeg/640px-Foodpanda_logo_since_2017.jpeg',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Bata.svg/2560px-Bata.svg.png',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> items,
    bool showSeeMore = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: TColors.primaryColor,
                ),
              ),
              if (showSeeMore)
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: TColors.primaryColor, thickness: 2),
          SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OfferDetailsScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.network(
                      items[index],
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
          if (showSeeMore) ...[
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(50, 20),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(60),
                  // ),
                  backgroundColor: TColors.primaryColor,
                ),
                child: Text(
                  "See More",
                  style: TextStyle(
                      fontSize: 12,
                      color: TColors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
