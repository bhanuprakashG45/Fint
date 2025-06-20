import 'package:fint/core/utils/routes/routes_name.dart';
import 'package:fint/view/auth/login_screen.dart';
import 'package:fint/view/auth/otp_screen.dart';
import 'package:fint/view/auth/signup_screen.dart';
import 'package:fint/view/home_screen/coupons/coupon_redeem_screen.dart';
import 'package:fint/view/home_screen/coupons/coupons_analytics_screen.dart';
import 'package:fint/view/home_screen/coupons/coupons_screen.dart';
import 'package:fint/view/home_screen/homescreen/home_screen.dart';
import 'package:fint/view/home_screen/homescreen/qr_scan_or_galleryscreen.dart';
import 'package:fint/view/home_screen/insurance/pet_insurance_screen.dart';
import 'package:fint/view/home_screen/homescreen/notification_screen.dart';
import 'package:fint/view/home_screen/red_drop/red_drop_screen.dart';
import 'package:fint/view/home_screen/homescreen/transaction_history_screen.dart';
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
      case RoutesName.reddropscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => RedDropScreen(),
        );
      case RoutesName.petinsurancescreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => PetInsuranceScreen(),
        );
      case RoutesName.couponredeempage:
        return MaterialPageRoute(
          builder: (BuildContext context) => CouponRedeemScreen(),
        );
      case RoutesName.couponanalyticsscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => CouponsAnalyticsScreen(),
        );
      case RoutesName.qrscanorgalleryscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => QRScanOrGalleryScreen(),
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
