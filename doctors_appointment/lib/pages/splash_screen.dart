import 'package:doctors_appointment/constants/strings.dart';
import 'package:doctors_appointment/pages/home_page.dart';
import 'package:doctors_appointment/pages/onboarding_screen.dart';
import 'package:doctors_appointment/utilities/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        User? user = FirebaseAuth.instance.currentUser;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => user == null ?
            const OnboardingScreen() :
            const HomePage()),
            (route) => false);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          splashIcon,
          theme: SvgTheme(
            currentColor: Provider.of<ThemeProvider>(context).currentThemeData!.primaryColor,
            xHeight: 36
          ),
          color: Provider.of<ThemeProvider>(context).currentThemeData!.primaryColor,
          height: 128,
          width: 128,
        ),
      ),
    );
  }
}
