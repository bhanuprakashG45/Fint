import 'package:fint/core/constants/theme.dart';
import 'package:fint/core/utils/routes/routes.dart';
import 'package:fint/core/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.43, 867.43),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final baseTextTheme = GoogleFonts.ptSerifTextTheme();
        final materialTheme = MaterialTheme(baseTextTheme);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FINT',
          theme: materialTheme.light(),
          initialRoute: RoutesName.splashscreen,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
