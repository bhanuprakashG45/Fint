import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/auth_viewmodel/login_viewmodel.dart';
import 'package:fint/view_model/auth_viewmodel/otp_viewmodel.dart';
import 'package:fint/view_model/profile_viewmodel/profile_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      navigatorKey.currentState?.pushNamed(RoutesName.homescreen);
    }
  }

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
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
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
