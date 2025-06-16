import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../providers/OfferDetailsProvider.dart';

class OfferDetailsScreen extends StatefulWidget {
  final String slug;

  OfferDetailsScreen({required this.slug});

  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<OfferDetailsProvider>(context, listen: false);
    provider.updateSlug(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Overview'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<OfferDetailsProvider>(context, listen: false)
              .fetchData(widget.slug),
          builder: (context, snapshot) {
            final provider = Provider.of<OfferDetailsProvider>(context);
            if (snapshot.connectionState == ConnectionState.waiting ||
                provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            final data = provider.offerDetails;
            if (data == null) return Center(child: Text('No data available'));

            return Column(
              children: [
                // Top Banner Image
                /*Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Image.network(
                        data.brand.banner_image ?? '',
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey[300]),
                      ),
                    ),
                    SizedBox(height: TSizes.sm),
                    // Logo
                    Positioned(
                      top: 60,
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Visibility(
                          visible: data.brand.logo!=null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.network(
                              data.brand.logo!,
                              height: 50,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
                // Top Banner with Logo Overlap
                SizedBox(
                  height: 130, // Adjust based on how much you want the logo to overlap
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Banner Image
                      Container(
                        width: double.infinity,
                        height: 100,
                        child: Image.network(
                          data.brand.banner_image ?? '',
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[300]),
                        ),
                      ),

                      // Logo Positioned
                      Positioned(
                        top: 70, // Adjust this to control overlap
                        left: 16,
                        child: Visibility(
                          visible: data.brand.logo != null,
                          child: Card(
                            elevation: 6,
                            child: Image.network(
                              data.brand.logo!,
                              width: 60,
                              height: 60, // Adjust size if needed
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => Container(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: TSizes.spaceBtwItems),
                // Tab Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: TColors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(64.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: TColors.black,
                    indicator: BoxDecoration(
                      color: TColors.primaryColor,
                      borderRadius: BorderRadius.circular(64.0),
                    ),
                    indicatorPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: -20),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Stores'),
                      Tab(text: 'Offers'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Overview Tab
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            // Middle Banners
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        data.brand.middle_banner_left ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(color: Colors.grey[300]),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: TSizes.spaceBtwItems),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        data.brand.middle_banner_right ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(color: Colors.grey[300]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.brand.name,
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    data.brand.about,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'More About ${data.brand.name}',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    data.brand.offerDescription,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Stores Tab (Placeholder)
                      Center(child: Text('Stores content will be added here')),
                      // Offers Tab
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Offer Details',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('Name: ${data.offer.name ?? 'N/A'}'),
                              SizedBox(height: 10),
                              Text('Badge: ${data.offer.badge ?? 'N/A'}'),
                              SizedBox(height: 10),
                              Text(
                                  'Price: ${data.offer.price?.toStringAsFixed(2) ?? 'N/A'}'),
                              SizedBox(height: 10),
                              Text(
                                  'Offer Price: ${data.offer.offerPrice?.toStringAsFixed(2) ?? 'N/A'}'),
                              SizedBox(height: 10),
                              Text(
                                  'Short Description: ${data.offer.shortDescription ?? 'N/A'}'),
                              SizedBox(height: 10),
                              if (data.offer.image != null)
                                Image.network(
                                  data.offer.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}