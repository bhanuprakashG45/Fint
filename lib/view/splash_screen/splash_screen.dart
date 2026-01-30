import 'package:fint/core/constants/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPref pref = SharedPref();
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    Future.delayed(Duration(seconds: 5), () async {
      final accessToken = await pref.getAccessToken();
      if (accessToken.isEmpty) {
        Navigator.pushReplacementNamed(context, RoutesName.loginscreen);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.homescreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorscheme.primary,
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset("assets/images/fint_splash.jpg")],
      ),
    );
  }
}
