import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/constants/route_tracker.dart';
import 'package:fint/view_model/auth_viewmodel/login_viewmodel.dart';
import 'package:fint/view_model/auth_viewmodel/logout_viewmodel.dart';
import 'package:fint/view_model/auth_viewmodel/otp_viewmodel.dart';
import 'package:fint/view_model/coupons_viewmodel/coupons_viewmodel.dart';
import 'package:fint/view_model/insurance_viewmodel/pet_insurance_viewmodel.dart';
import 'package:fint/view_model/profile_viewmodel/profile_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.43, 867.43),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final baseTextTheme = GoogleFonts.ptSerifTextTheme();
        final materialTheme = MaterialTheme(baseTextTheme);

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SignupViewmodel()),
            ChangeNotifierProvider(create: (_) => LoginViewModel()),
            ChangeNotifierProvider(create: (_) => OtpViewModel()),
            ChangeNotifierProvider(create: (_) => ProfileViewmodel()),
            ChangeNotifierProvider(create: (_) => LogoutViewmodel()),
            ChangeNotifierProvider(create: (_) => PetInsuranceViewmodel()),
            ChangeNotifierProvider(create: (_) => CouponsViewmodel()),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            navigatorObservers: [RouteTracker()],
            debugShowCheckedModeBanner: false,
            title: 'FINT',
            theme: materialTheme.light(),
            initialRoute: RoutesName.splashscreen,
            onGenerateRoute: Routes.generateRoute,
          ),
        );
      },
    );
  }
}
