import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/constants/route_tracker.dart';
import 'package:fint/core/network/globalkey.dart';
import 'package:fint/core/network/push_notifications.dart';
import 'package:fint/view_model/home_viewmodel/home_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initMessaging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.43, 867.43),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final baseTextTheme = ThemeData.light().textTheme;
        final materialTheme = MaterialTheme(
          GoogleFonts.ptSerifTextTheme(baseTextTheme),
        );

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SignupViewmodel()),
            ChangeNotifierProvider(create: (_) => LoginViewModel()),
            ChangeNotifierProvider(create: (_) => OtpViewModel()),
            ChangeNotifierProvider(create: (_) => ProfileViewmodel()),
            ChangeNotifierProvider(create: (_) => LogoutViewmodel()),
            ChangeNotifierProvider(create: (_) => PetInsuranceViewmodel()),
            ChangeNotifierProvider(create: (_) => CouponsViewmodel()),
            ChangeNotifierProvider(create: (_) => HomeViewmodel()),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            navigatorObservers: [RouteTracker()],
            debugShowCheckedModeBanner: false,
            title: 'FINT',

            theme: materialTheme.light(),
            darkTheme: materialTheme.light(),
            themeMode: ThemeMode.light,

            initialRoute: RoutesName.splashscreen,
            onGenerateRoute: Routes.generateRoute,
          ),
        );
      },
    );
  }
}
