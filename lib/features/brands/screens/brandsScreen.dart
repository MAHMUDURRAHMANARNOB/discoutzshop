import 'package:discountzshop/features/offers/screens/offerDetailsMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/colors.dart';
import '../Providers/BrandsProvider.dart';
import '../datamodels/BrandsDataModel.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BrandProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Brands"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.search),
            ),
          ],
        ),
        body: Consumer<BrandProvider>(
          builder: (context, provider, child) {
            return FutureBuilder(
              future: provider.initialFetch,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    provider.brandsByCategory.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
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
                      provider.loadMore();
                    }
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: provider.refresh,
                    child: ListView(
                      children: [
                        // Reintroduced Banner Image
                        Container(
                          width: double.infinity,
                          height: 150,
                          child: Image.network(
                            'https://www.discountzshop.com/storage/brands/banner_image/JGmM32QWW41748932077.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[300],
                                  height: 150,
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        // Brand Sections
                        ...provider.brandsByCategory.entries.map((entry) {
                          return _buildSection(
                            context: context,
                            title: entry.key,
                            brands: entry.value,
                          );
                        }).toList(),
                        if (provider.hasMore && provider.isLoading)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<Brand> brands,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: TColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: TColors.primaryColor, thickness: 2),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OfferDetailsScreen(id: brand.id, initialTab: 2,/*brand: brand*/),
                    ),
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
                      brand.logo ?? '',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 60,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}