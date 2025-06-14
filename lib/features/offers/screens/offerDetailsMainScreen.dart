/*
import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'offerOverviewTab.dart';
import 'offerStoreTab.dart';
import 'offersTab.dart';

class OfferDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String appbarName = "Overview";
    return Scaffold(
      appBar: AppBar(
        
        title: Text(appbarName),
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
*/
import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../brands/Providers/BrandsProvider.dart';
import '../providers/offerProvider.dart';
import 'offerOverviewTab.dart';
import 'offerStoreTab.dart';
import 'offersTab.dart';

class OfferDetailsScreen extends StatefulWidget {
  final int id;
  final int initialTab; // 0 for Overview (BrandsScreen), 2 for Offers (OfferScreen)

  const OfferDetailsScreen({super.key, required this.id, this.initialTab = 0});

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _initialTab;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
    _tabController.addListener(_handleTabChange);
    _initialTab = widget.initialTab;
    _initializeData();
  }

  void _initializeData() {
    final brandProvider = context.read<BrandProvider>();
    final offerProvider = context.read<OfferProvider>();
    if (widget.initialTab == 0 && brandProvider.brandsByCategory.isEmpty) {
      brandProvider.refresh();
    }
    if (widget.initialTab == 2 && offerProvider.offers.isEmpty) {
      offerProvider.refreshOffers();
    }
  }

  void _handleTabChange() {
    if (_tabController.index != widget.initialTab) {
      setState(() {
        _initialTab = _tabController.index;
      });
      _initializeData();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BrandProvider()),
        ChangeNotifierProvider(create: (_) => OfferProvider()),
      ],
      child: Consumer2<BrandProvider, OfferProvider>(
        builder: (context, brandProvider, offerProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_tabController.index == 0 ? 'Overview' : _tabController.index == 1 ? 'Stores' : 'Offers'),
              centerTitle: true,
              actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
            ),
            body: Column(
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
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: TColors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(64.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: TColors.black,
                    indicator: BoxDecoration(
                      color: TColors.primaryColor,
                      borderRadius: BorderRadius.circular(64.0),
                    ),
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: -20),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Stores'),
                      Tab(text: 'Offers'),
                    ],
                  ),
                ),
                // TabBarView for dynamic content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      OverviewTab(brandId: widget.id),
                      StoresTab(),
                      OffersTab(brandId: widget.id),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}