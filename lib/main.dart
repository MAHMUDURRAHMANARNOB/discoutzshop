import 'package:discountzshop/features/authentication/login/screens/LoginScreen.dart';
import 'package:discountzshop/screens/welcomeScreen.dart';
import 'package:discountzshop/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiscountZShop());
}

class DiscountZShop extends StatelessWidget {
  const DiscountZShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

