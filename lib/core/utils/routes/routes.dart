import 'package:fint/core/utils/routes/routes_name.dart';
import 'package:fint/view/auth/login_screen.dart';
import 'package:fint/view/auth/otp_screen.dart';
import 'package:fint/view/auth/signup_screen.dart';
import 'package:fint/view/home_screen/coupons_screen.dart';
import 'package:fint/view/home_screen/home_screen.dart';
import 'package:fint/view/home_screen/notification_screen.dart';
import 'package:fint/view/home_screen/transaction_history_screen.dart';
import 'package:fint/view/profile/profile_screen.dart';
import 'package:fint/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );
      case RoutesName.homescreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        );
      case RoutesName.loginscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        );
      case RoutesName.signupscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => SignupScreen(),
        );
      case RoutesName.otpscreen:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (BuildContext context) => OtpScreen(phoneNumber: phoneNumber),
        );
      case RoutesName.couponsscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => CouponsScreen(),
        );
      case RoutesName.profilescreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => ProfileScreen(),
        );
      case RoutesName.transactionhistoty:
        return MaterialPageRoute(
          builder: (BuildContext context) => TransactionHistoryScreen(),
        );
      case RoutesName.notificationscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => NotificationScreen(),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
