import 'package:fint/core/constants/exports.dart';

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
          builder: (BuildContext context) =>
              OtpScreen(phoneNumber: phoneNumber),
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
      final couponId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => CouponRedeemScreen(couponId: couponId)
        );
      case RoutesName.couponanalyticsscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => CouponsAnalyticsScreen(),
        );
      case RoutesName.qrscanorgalleryscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => QRScanOrGalleryScreen(),
        );
      case RoutesName.viewallbloodrequestsscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => ViewAllBloodrequestsScreen(),
        );
      case RoutesName.bankaccountsscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => BankAccountsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
