import 'package:flutter/material.dart';

import '../../offers/screens/offerDetailsMainScreen.dart';

class StoresScreen extends StatefulWidget {
  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final List<Map<String, String>> stores = [
    {
      'name': 'Vision Emporium',
      'location': 'Mirpur',
      'logo': 'https://vision.com.bd/images/logos/16/V.-logo-200x80.png'
    },
    {
      'name': 'Vision Emporium',
      'location': 'Rampura',
      'logo': 'https://vision.com.bd/images/logos/16/V.-logo-200x80.png'
    },
    {
      'name': 'Vision Emporium',
      'location': 'Krishi Market',
      'logo': 'https://vision.com.bd/images/logos/16/V.-logo-200x80.png'
    },
    {
      'name': 'Walton Plaza',
      'location': 'Rampura',
      'logo':
          'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Walton_Group.svg/2560px-Walton_Group.svg.png'
    },
    {
      'name': 'Walton Plaza',
      'location': 'Dhanmondi 27',
      'logo':
          'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Walton_Group.svg/2560px-Walton_Group.svg.png'
    },
    {
      'name': 'Walton Plaza',
      'location': 'Mirpur 1',
      'logo':
          'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Walton_Group.svg/2560px-Walton_Group.svg.png'
    },
    {
      'name': 'Walton Plaza',
      'location': 'Mirpur 11',
      'logo':
          'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Walton_Group.svg/2560px-Walton_Group.svg.png'
    },
    {
      'name': 'Walton Plaza',
      'location': 'Uttara',
      'logo':
          'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Walton_Group.svg/2560px-Walton_Group.svg.png'
    },
    {
      'name': 'Walton Plaza',
      'location': 'Mirpur 2',
      'logo':
          'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Walton_Group.svg/2560px-Walton_Group.svg.png'
    },
    {
      'name': 'Apex Plaza',
      'location': 'Mirpur 1',
      'logo':
          'https://mir-s3-cdn-cf.behance.net/projects/404/38db8c139830717.Y3JvcCwxMDgwLDg0NCwwLDExNw.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final iconHeight =
        screenWidth * 0.2;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ALL STORES',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.filter_list, size: 16),
                        label: Text('Filter'),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.orange),
                          foregroundColor: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.search, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
            // Grid of Stores
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  return StoreCard(
                    name: stores[index]['name']!,
                    location: stores[index]['location']!,
                    logo: stores[index]['logo']!, imageHeight: iconHeight,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreCard extends StatefulWidget {
  final String name;
  final String location;
  final String logo;

  final double imageHeight;

  const StoreCard({
    required this.name,
    required this.location,
    required this.logo, required this.imageHeight,
  });

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  OfferDetailsScreen(id: 1,)),
        );
      },
      child: Card(
        color: Color(0xFFFFF5F0), // Light peach background
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.store,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              SizedBox(height: 8),
              // Logo Placeholder (since we don't have actual logos)
              /*Container(
                height: 40,
                child: Text(
                  logo.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: logo == 'apex' ? Colors.red : Colors.black,
                  ),
                ),
              ),*/
              Expanded(
                child: Image.network(
                  widget.logo, width: double.infinity,
                  // height: imageHeight,
                  // Slightly increased height for better visuals
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    widget.location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
