import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/main_screens/payment/pay_to_bank_screen.dart';
import 'package:fint/view/main_screens/payment/pay_to_number_screen.dart';
import 'package:fint/view/main_screens/payment/pay_to_self_screen.dart';
import 'package:fint/view/main_screens/profile/add_bank_account_screen.dart';

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
          builder: (BuildContext context) =>
              CouponRedeemScreen(couponId: couponId),
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
      case RoutesName.payToNumberScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => PayToNumberScreen(),
        );
      case RoutesName.payToBankscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => PayToBankScreen(),
        );
      case RoutesName.payToSelfscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => PayToSelfScreen(),
        );
      case RoutesName.addbankAccountscreen:
        bool isComingFromLogin = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) =>
              AddBankAccountScreen(isComingFromLogin: isComingFromLogin),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
