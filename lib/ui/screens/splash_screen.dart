import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    moveToNextScreen();
    super.initState();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreenBackground(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
