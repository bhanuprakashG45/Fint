import 'package:fint/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Coupons",
          style: TextStyle(
            color: AppColor.appcolor,
            fontSize: 20.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.onSecondaryContainer,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: Center(child: Text("Coupons Screen")),
    );
  }
}
