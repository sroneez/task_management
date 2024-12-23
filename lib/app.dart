import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_management/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_management/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_management/ui/screens/reset_password_screen.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/screens/splash_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            titleSmall: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            fillColor: Colors.white,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              fixedSize: const Size.fromWidth(double.maxFinite),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          late Widget widget;
          if (settings.name == SplashScreen.name) {
            widget = const SplashScreen();
          } else if (settings.name == SignInScreen.name) {
            widget = const SignInScreen();
          }else if(settings.name == SignUpScreen.name){
            widget = const SignUpScreen();
          }else if(settings.name == ForgotPasswordVerifyEmailScreen.name){
            widget = const ForgotPasswordVerifyEmailScreen();
          }else if(settings.name == ForgotPasswordVerifyOtpScreen.name){
            widget = const ForgotPasswordVerifyOtpScreen();
          }else if(settings.name == ResetPasswordScreen.name){
            widget = const ResetPasswordScreen();
          }else if(settings.name == MainBottomNavScreen.name){
            widget = MainBottomNavScreen();
          }
          return MaterialPageRoute(builder: (ctx) {
            return widget;
          });
        });
  }
}
