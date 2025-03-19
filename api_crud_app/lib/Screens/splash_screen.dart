import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/style.dart';
import 'product_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ProductHomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/tech_mart.png',
            width: 200,
            color: appPrimaryBackground,
          ),
          Text(
            'TechMart',
            style: GoogleFonts.baumans(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: appPrimaryForeground),
          ),
        ],
      )),
    );
  }
}
