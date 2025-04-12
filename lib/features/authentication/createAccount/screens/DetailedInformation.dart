import 'package:discountzshop/features/authentication/createAccount/screens/otpVerification.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class DetailedInformation extends StatefulWidget {
  const DetailedInformation({super.key});

  @override
  State<DetailedInformation> createState() => _DetailedInformationState();
}

class _DetailedInformationState extends State<DetailedInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Get Started Title
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // Subtitle
                Text(
                  'By creating a free account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                // Full Name TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: 20),
                // Valid Email TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Valid Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 20),
                // Phone Number TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                SizedBox(height: 20),
                // Strong Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Strong Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                SizedBox(height: 20),
                // Repeat Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Repeat Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                SizedBox(height: 20),
                // Terms and Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                    Expanded(
                      child: Text(
                        'By checking the box you agree to our Terms and Conditions.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Submit & Get OTP Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OTPVerification()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SUBMIT & GET OTP',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Already a member? Log In
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        text: 'Already a member? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(color: TColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: TColors.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Highlight the second item (location icon)
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: '',
          ),
        ],
      ),
    );

  }
}
