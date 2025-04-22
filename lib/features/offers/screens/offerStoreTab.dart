import 'package:discountzshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class StoresTab extends StatefulWidget {
  @override
  _StoresTabState createState() => _StoresTabState();
}

class _StoresTabState extends State<StoresTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store List
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  title: Text('Oraimo Brand Shop, Bashundhara city shopping complex'),
                  subtitle: Text('BASEMENT #01 SHOP #76, Bashundhara City, Shopping Complex, DHAKA 1215, 017/281/8361'),
                ),
                Divider(),
                ListTile(
                  title: Text('Oraimo Brand Shop'),
                  subtitle: Text('LEVEL-04, SHOP NO-4C-20/A3, JAMUNA FUTURE PARK, DHAKA 1229 01310230969'),
                ),
                Divider(),
                ListTile(
                  title: Text('Oraimo Brand Shop, Mirpur 1'),
                  subtitle: Text('SHOP NO-1/9, 1ST FLOOR, CAPITAL TOWER, SHOPPING COMPLEX BUS STAND, DHAKA 1216, 01762181123'),
                ),
                Divider(),
                ListTile(
                  title: Text('Oraimo Brand Shop Mirpur 10'),
                  subtitle: Text('SHOP#46, 2ND FLOOR, SHAH ALI PLAZA, MIRPUR 10 ROUNDOUT, DHAKA 1216, 01324536753'),
                ),
                Divider(),
                SizedBox(height: TSizes.spaceBtwItems),
                // Map Placeholder
                Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: Text('Map Placeholder')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}