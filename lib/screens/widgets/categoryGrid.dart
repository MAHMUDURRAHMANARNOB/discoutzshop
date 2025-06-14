import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  bool _showAll = false; // Controls whether all items are shown

  // Full list of categories
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.toys_outlined, 'label': 'Babies & Toys'},
    {'icon': Icons.chair_outlined, 'label': 'Home & Decor'},
    {'icon': Icons.electrical_services, 'label': 'Electrical & Gadget'},
    {'icon': Icons.face_retouching_natural, 'label': 'Beauty & Care'},
    {'icon': Icons.flight_outlined, 'label': 'Travel & Tourism'},
    {'icon': Icons.sports_baseball_outlined, 'label': 'Sports & Outdoors'},
    {'icon': Icons.subscriptions_outlined, 'label': 'Subscriptions'},
    {'icon': Icons.restaurant_outlined, 'label': 'Food & Restaurant'},
    {'icon': Icons.local_hospital_outlined, 'label': 'Health & Wellness'},
    {'icon': Icons.book_outlined, 'label': 'Books & Media'},
  ];

  @override
  Widget build(BuildContext context) {
    // Show 8 items initially, or all if "See More" is pressed
    final displayedCategories =
        _showAll ? _categories : _categories.take(8).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: GridView.count(
            crossAxisCount: 4, // 4 items per row
            crossAxisSpacing: 16.0, // Horizontal spacing
            mainAxisSpacing: 16.0, // Vertical spacing
            childAspectRatio: 0.7, // Width-to-height ratio
            shrinkWrap: true, // Takes only the space needed
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView scrolling
            children: displayedCategories
                .map((category) => _buildCategoryItem(
                      category['icon'] as IconData,
                      category['label'] as String,
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _showAll
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      _showAll = false; // Collapse back to 8 items
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: TColors.primaryColor, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  child: const Text(
                    'Collapse',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              : (_categories.length > 8
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          _showAll = true; // Show all items
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: TColors.primaryColor, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(64.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      child: Text(
                        'See More',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()), // Hide button if no more items
        ),
      ],
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 2,
          color: Colors.grey[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(64.0)),
          child: Container(
            padding: const EdgeInsets.all(12.0), // Padding inside the circle
            child: Icon(
              icon,
              size: 30.0,
              color: TColors
                  .primaryColor, // Icon color updated to TColors.primaryColor
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
