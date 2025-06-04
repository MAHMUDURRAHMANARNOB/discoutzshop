import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:discountzshop/features/authentication/login/screens/LoginScreen.dart';
import 'package:discountzshop/features/homeDashboard/screens/widgets/AvaiableCouponWidget.dart';
import 'widgets/DottedContainer.dart';
import 'package:discountzshop/screens/widgets/categoryGrid.dart';
import 'package:discountzshop/utils/constants/colors.dart';
import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:discountzshop/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../providers/firstSliderProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final ScrollController _firstSliderScrollController = ScrollController();

  //First slider
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // Timer? _firstSliderTimer;
  // int _firstSliderCurrentIndex = 0;
  Future<void>? _fetchSlidersFuture;

  @override
  void initState() {
    super.initState();
    // Start auto-scrolling after the first frame to ensure sliders are loaded
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FirstSliderProvider>(context, listen: false);
      if (provider.sliders.isNotEmpty) {
        startAutoScrollFirstSlider(provider.sliders.length);
      }
    });*/
    final provider = Provider.of<FirstSliderProvider>(context, listen: false);
    _fetchSlidersFuture = provider.fetchSliders();
  }

  /*void startAutoScrollFirstSlider(int itemCount) {
    _firstSliderTimer?.cancel();
    _firstSliderTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _firstSliderCurrentIndex = (_firstSliderCurrentIndex + 1) % itemCount; // Loop back to 0
        });
        // Animate to the next item (width: 300 + 12 margin)
        _firstSliderScrollController.animateTo(
          _firstSliderCurrentIndex * (300 + 12),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }*/
  /*void startAutoScrollFirstSlider(int itemCount) {
    _firstSliderTimer?.cancel(); // Cancel any existing timer
    _firstSliderTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        _firstSliderCurrentIndex = (_firstSliderCurrentIndex + 1) % itemCount; // Loop back to 0
        // Animate to the next item (width: 300 + 12 margin)
        _firstSliderScrollController.animateTo(
          _firstSliderCurrentIndex * (300 + 12),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }*/

  @override
  void dispose() {
    // _firstSliderTimer?.cancel();
    // _firstSliderScrollController.dispose();

    _currentIndex.dispose(); // FirstSlider
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstSliderProvider =
        Provider.of<FirstSliderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: TColors.primaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: TColors.white,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.heart,
                  color: TColors.white,
                  size: 30,
                ),
              ),
              Positioned(
                right: 5,
                bottom: 5,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: TColors.white, // Badge background color
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    '3', // Replace with dynamic count if needed
                    style: TextStyle(
                      color: TColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(64),
                  color: TColors.white),
              child: Icon(
                Icons.person_2_outlined,
                color: TColors.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search store here...',
                      suffixIcon: Icon(Icons.search, color: TColors.darkGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: TColors.darkGrey),
                      ),
                      filled: true,
                      fillColor: TColors.white,
                    ),
                  ),
                ),

                // Banners
                /*FutureBuilder<void>(
                  future: _fetchSlidersFuture, // Use stored future
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitThreeInOut(
                          color: Colors.blue, // Replace with TColors.primaryColor if defined
                          size: 18,
                        ),
                      );
                    } else if (snapshot.hasError || firstSliderProvider.error != null) {
                      return Center(child: Text('Error: ${firstSliderProvider.error ?? snapshot.error}'));
                    } else if (firstSliderProvider.sliders.isEmpty) {
                      return const Center(child: Text('No sliders available'));
                    }

                    // Start auto-scrolling once sliders are loaded
                    if (_firstSliderTimer == null) {
                      startAutoScrollFirstSlider(firstSliderProvider.sliders.length);
                    }

                    return Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _firstSliderScrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: firstSliderProvider.sliders.length,
                        itemBuilder: (context, index) {
                          final slider = firstSliderProvider.sliders[index];
                          return _buildBanner(slider.image);
                        },
                      ),
                    );
                  },
                ),*/
                // --Top Carousel
                FutureBuilder<void>(
                  future: _fetchSlidersFuture, // Use stored future
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitThreeInOut(
                          color: TColors.primaryColor,
                          // Replace with TColors.primaryColor if defined
                          size: 18,
                        ),
                      );
                    } else if (snapshot.hasError ||
                        firstSliderProvider.error != null) {
                      return Center(
                          child: Text(
                              'Error: ${firstSliderProvider.error ?? snapshot.error}'));
                    } else if (firstSliderProvider.sliders.isEmpty) {
                      return const Center(child: Text('No sliders available'));
                    }

                    return Column(
                      children: [
                        CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              // Update the current index for the indicator
                              _currentIndex.value = index;
                            },
                          ),
                          items: firstSliderProvider.sliders.map((slider) {
                            return _buildBanner(slider.image);
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<int>(
                          valueListenable: _currentIndex,
                          builder: (context, currentIndex, child) {
                            return SmoothPageIndicator(
                              controller:
                                  PageController(initialPage: currentIndex),
                              // Still needed for animation
                              count: firstSliderProvider.sliders.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: TColors.primaryColor,
                                // Replace with TColors.primaryColor
                                dotColor: TColors.grey,
                                spacing: 8,
                              ),
                              onDotClicked: (index) {
                                // Navigate to the clicked page
                                _carouselController.animateToPage(index);
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),

                // Categories
                CategoryGrid(),

                // Available Coupon Search
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: TColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const CouponHeader(),
                      SizedBox(height: TSizes.sm),
                      // Coupons
                      Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          // padding: EdgeInsets.symmetric(horizontal: 16.0),
                          children: [
                            _buildCoupon('25% OFF', 'promo360',
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Grameenphone_Logo_GP_Logo.svg/1200px-Grameenphone_Logo_GP_Logo.svg.png'),
                            _buildCoupon('25% OFF', 'promo360',
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Grameenphone_Logo_GP_Logo.svg/1200px-Grameenphone_Logo_GP_Logo.svg.png'),
                            _buildCoupon('25% OFF', 'promo360',
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Grameenphone_Logo_GP_Logo.svg/1200px-Grameenphone_Logo_GP_Logo.svg.png'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                // -- 20% on App type coupon
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(color: Colors.pink),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Get 20% on App",
                        style: TextStyle(color: TColors.white),
                      ),
                      // SizedBox(width: TSizes.sm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: TColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text("ramadan20"),
                      ),
                      // SizedBox(width: TSizes.sm),
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: TColors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Image.network(
                            "https://img.icons8.com/?size=512&id=6PPJuxkGUHti&format=png",
                            height: 20,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                // Deals Tabs
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: TColors.primaryColor.withOpacity(0.05),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          children: [
                            _buildTab('Hot Deals', true),
                            _buildTab('Cashback', false),
                            _buildTab('Flat %', false),
                            _buildTab('Buy 1 Get 1', false),
                            _buildTab('Upto 50% Off', false),
                            _buildTab('More', false),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 230,
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 columns
                            crossAxisSpacing: 6.0, // Spacing between columns
                            mainAxisSpacing: 6.0, // Spacing between rows
                            childAspectRatio: 1.5, // Square cells
                          ),
                          itemCount: 9, // 2 rows * 3 columns = 6 items
                          itemBuilder: (context, index) {
                            return DottedCustomContainer(
                              imageString:
                                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Flogotyp.us%2Flogo%2Fbata%2F&psig=AOvVaw0fFHUJCuRup4-KP6zzon-v&ust=1748513889810000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCKjo6v33xY0DFQAAAAAdAAAAABAJ",
                              offerPercentage: "offerPercentage",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                //-- 2nd carousel
                /*Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      _buildFeaturedDeal('WONDER', '25% OFF',
                          'https://images.unsplash.com/photo-1723905103369-eec5339e0fe7?q=80&w=1149&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildFeaturedDeal('WONDER', '25% OFF',
                          'https://images.unsplash.com/photo-1590228232524-6776f2d6f84b?q=80&w=1178&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ],
                  ),
                ),*/
                FutureBuilder<void>(
                  future: _fetchSlidersFuture, // Use stored future
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitThreeInOut(
                          color: TColors.primaryColor,
                          // Replace with TColors.primaryColor if defined
                          size: 18,
                        ),
                      );
                    } else if (snapshot.hasError ||
                        firstSliderProvider.error != null) {
                      return Center(
                          child: Text(
                              'Error: ${firstSliderProvider.error ?? snapshot.error}'));
                    } else if (firstSliderProvider.sliders.isEmpty) {
                      return const Center(child: Text('No sliders available'));
                    }

                    return Column(
                      children: [
                        CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              // Update the current index for the indicator
                              _currentIndex.value = index;
                            },
                          ),
                          items: firstSliderProvider.sliders.map((slider) {
                            return _buildBanner(slider.image);
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<int>(
                          valueListenable: _currentIndex,
                          builder: (context, currentIndex, child) {
                            return SmoothPageIndicator(
                              controller:
                              PageController(initialPage: currentIndex),
                              // Still needed for animation
                              count: firstSliderProvider.sliders.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: TColors.primaryColor,
                                // Replace with TColors.primaryColor
                                dotColor: TColors.grey,
                                spacing: 8,
                              ),
                              onDotClicked: (index) {
                                // Navigate to the clicked page
                                _carouselController.animateToPage(index);
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                // Deals of the Day
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Text(
                    'Deals of the Day',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      _buildTab('Hot Deals', true),
                      _buildTab('Cashback', false),
                      _buildTab('Flat %', false),
                      _buildTab('Buy 1 Get 1', false),
                      _buildTab('Upto 50% Off', false),
                      _buildTab('More', false),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                Container(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.sm),
                Container(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildDeal('Flat 30% OFF', '25 April 2024',
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ],
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwItems),

                // Additional Banners
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      _buildBanner(
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      _buildBanner(
                          'https://plus.unsplash.com/premium_photo-1674815329488-c4fc6bf4ced8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ],
                  ),
                ),
                // Product Listings
                /*Container(
                  width: double.infinity,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.7, // Adjust the aspect ratio to fit content
                      ),
                      itemCount: 4, // Number of items
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image at the top
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0),
                                ),
                                child: Image.network(
                                  'https://via.placeholder.com/150', // Placeholder image URL
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    Text(
                                      'Syltherine',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Subtitle
                                    Text(
                                      'Stylish cafe chair',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Price
                                    Text(
                                      'BDT 2,500',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'BDT 3,500',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // Buy Now Button
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: Text('Buy Now'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),*/
                SizedBox(height: TSizes.spaceBtwItems),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0XFFffebfd),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: _buildProduct(
                          'Sytherine',
                          'Stylish cafe chair',
                          'BDT 2,500',
                          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        flex: 3,
                        child: Column(
                          children: [
                            _buildProductHorizontal(
                              'Sytherine',
                              'Stylish cafe chair',
                              'BDT 2,500',
                              'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ),
                            SizedBox(height: 16),
                            _buildProductHorizontal(
                              'Sytherine',
                              'Stylish cafe chair',
                              'BDT 2,500',
                              'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Monitors
                SizedBox(height: TSizes.spaceBtwItems),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildProduct(
                          'Sytherine',
                          'Stylish cafe chair',
                          'BDT 2,500',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyTBVZKemRyQpZxelXzx2NHgsF_IgLx3j_1w&s',
                        ),
                      ),
                      SizedBox(width: TSizes.sm),
                      Expanded(
                        child: _buildProduct(
                          'Sytherine',
                          'Stylish cafe chair',
                          'BDT 2,500',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyTBVZKemRyQpZxelXzx2NHgsF_IgLx3j_1w&s',
                        ),
                      ),
                      SizedBox(width: TSizes.sm),
                      Expanded(
                        child: _buildProduct(
                          'Sytherine',
                          'Stylish cafe chair',
                          'BDT 2,500',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyTBVZKemRyQpZxelXzx2NHgsF_IgLx3j_1w&s',
                        ),
                      ),
                    ],
                  ),
                ),

                // Belts
                SizedBox(height: TSizes.spaceBtwItems),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildProduct(
                          'Sytherine',
                          'Stylish cafe chair',
                          'BDT 2,500',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV6VgPuMyIJlOK5goJCGjDS4NR4wxYyDNMmQ&s',
                        ),
                      ),
                      SizedBox(width: TSizes.sm),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://fabrilife.com/products/6505bbdf8f0c2-square.png",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 320,
                          ),
                        ),
                      ),
                      SizedBox(width: TSizes.sm),
                      Expanded(
                        child: _buildProduct(
                          'Sytherine',
                          'Stylish cafe chair',
                          'BDT 2,500',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkEFQeYkfSQ23-Dc92oeQI4abxDcrpRpHUYw&s',
                        ),
                      ),
                    ],
                  ),
                ),

                // Smarphones
                SizedBox(height: TSizes.spaceBtwItems),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: _buildProduct(
                          'iPhone',
                          'iPhone 16 Pro Max',
                          'BDT 1,21,500',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwnjRu2piR1q7hR_dy4OVQsuY2aPXU8rOhpg&s',
                        ),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildProductHorizontal(
                              'Samsung',
                              'Samsung S25 Ultra 5g',
                              'BDT 1,22,000',
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_Fz1YScUkysiCy8G54_iNRiKag6nGHxN__Q&s',
                            ),
                            SizedBox(height: 16),
                            _buildProductHorizontal(
                              'Sytherine',
                              'Stylish cafe chair',
                              'BDT 2,500',
                              'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Partner Brands
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Text(
                    'Partner Brands',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      _buildPartnerBrand(
                          'https://e7.pngegg.com/pngimages/117/377/png-clipart-kfc-logo-kfc-icon-food-kentucky-fried-chicken.png'),
                      _buildPartnerBrand(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKw3Ssk8L6gEiq0L0kVMqVpcTxcJvLTR2Mnw&s'),
                      _buildPartnerBrand(
                          'https://bdtickets.com/images/logo-new-2.png'),
                      _buildPartnerBrand(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2r5G0CBdTUTOTURkzMYwhHmXl7lxilcK_Hw&s'),
                      _buildPartnerBrand(
                          'https://w7.pngwing.com/pngs/207/567/png-transparent-bata-hd-logo-thumbnail.png'),
                      _buildPartnerBrand(
                          'https://mir-s3-cdn-cf.behance.net/projects/404/38db8c139830717.Y3JvcCwxMDgwLDg0NCwwLDExNw.jpg'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar
    );
  }

  Widget _buildBanner(String imageUrl) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Set banner width to 90% of screen width, accounting for margins
    final bannerWidth = screenWidth * 0.8;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(right: 12.0),
      width: bannerWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.orange,
            size: 30,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.black),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCoupon(String discount, String code, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0XFFf3faff),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: TColors.info.withOpacity(0.5),
        ),
      ),
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFf4f4f5),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                discount,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Text(
                      code,
                      style: TextStyle(
                        color: TColors.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Chip(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(64),
            side: BorderSide(
                color: isSelected ? TColors.primaryColor : TColors.grey)),
        label: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: isSelected ? TColors.primaryColor : TColors.white,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildFeaturedDeal(String title, String discount, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      width: 300,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 300,
              height: 200,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Text(
              discount,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeal(String discount, String date, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TColors.grey),
        color: Color(0XFFf8f8f8),
      ),
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(height: 8),
          Text(
            discount,
            style: TextStyle(
              color: TColors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Daraz Free Delivery Festival",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              color: TColors.primaryColor.withOpacity(0.1),
              border: Border.all(color: TColors.primaryColor.withOpacity(0.5))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.ticket_discount_copy, size: 18),
                SizedBox(width: 5),
                Text(
                  'FREEDEL24',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: TColors.darkerGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Expires on: $date",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProduct(
    String brand,
    String name,
    String price,
    String imageUrl,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      // height: 315,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  brand,
                  style: TextStyle(
                    color: TColors.darkerGrey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    color: TColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: TColors.darkerGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                TextButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.black,
                    minimumSize: Size(10, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductHorizontal(
      String brand, String name, String price, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 150,
      width: double.infinity, // Adjust for padding and spacing
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand,
                    style: TextStyle(
                      color: TColors.darkerGrey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 10,
                      color: TColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      color: TColors.darkerGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.black,
                      minimumSize: Size(10, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(64),
                      ),
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerBrand(String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
