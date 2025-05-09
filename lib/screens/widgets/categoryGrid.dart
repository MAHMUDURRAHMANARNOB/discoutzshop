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
    {'icon': Icons.toys, 'label': 'Babies & Toys'},
    {'icon': Icons.chair, 'label': 'Home & Decor'},
    {'icon': Icons.electrical_services, 'label': 'Electrical & Gadget'},
    {'icon': Icons.face_retouching_natural, 'label': 'Beauty & Care'},
    {'icon': Icons.flight, 'label': 'Travel & Tourism'},
    {'icon': Icons.sports_baseball, 'label': 'Sports & Outdoors'},
    {'icon': Icons.subscriptions, 'label': 'Subscriptions'},
    {'icon': Icons.restaurant, 'label': 'Food & Restaurant'},
    {'icon': Icons.local_hospital, 'label': 'Health & Wellness'},
    {'icon': Icons.book, 'label': 'Books & Media'},
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
            physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
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
              ? ElevatedButton(
            onPressed: () {
              setState(() {
                _showAll = false; // Collapse back to 8 items
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primaryColor, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 32.0, vertical: 12.0),
            ),
            child: const Text(
              'COLLAPSE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
              : (_categories.length > 8
              ? ElevatedButton(
            onPressed: () {
              setState(() {
                _showAll = true; // Show all items
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primaryColor, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 32.0, vertical: 12.0),
            ),
            child: const Text(
              'SEE MORE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100], // Light background color
            shape: BoxShape.circle, // Circular shape
            border: Border.all(color: Colors.grey[300]!, width: 1.0), // Border
          ),
          padding: const EdgeInsets.all(12.0), // Padding inside the circle
          child: Icon(
            icon,
            size: 30.0,
            color: TColors.primaryColor, // Icon color updated to TColors.primaryColor
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