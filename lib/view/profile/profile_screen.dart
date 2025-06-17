import 'package:fint/core/constants/color.dart';
import 'package:fint/core/utils/widgets/profile_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          Container(
            // height: screenHeight * 0.4,
            width: screenWidth,
            padding: EdgeInsets.all(10).r,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColor.appcolor, colorscheme.secondary],
              ),
            ),
            child: Column(
              children: [
                SafeArea(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10).r,
                  child: Image.network(
                    "https://randomuser.me/api/portraits/men/10.jpg",
                    height: 120.h,
                    width: 120.h,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 10.0.h),
                Container(
                  padding: EdgeInsets.all(5).r,
                  decoration: BoxDecoration(
                    // color: Colorscheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                  child: Text(
                    "BhanuPrakash",
                    style: TextStyle(
                      color: colorscheme.primaryContainer,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                _profileInfo(colorscheme, "UPI ID : abcd123@ybl"),
                SizedBox(height: 5.0.h),
                _profileInfo(colorscheme, "Pin code : 123456"),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20).r,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ).r,
            ),
            child: Column(
              children: [
                ProfileOptionsWidget(
                  leadingIcon: Icons.water_drop_outlined,
                  text: "Be a Donar",
                  trailingIcon: Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _profileInfo(ColorScheme colorscheme, String text) {
  return Container(
    padding: EdgeInsets.all(5).r,
    decoration: BoxDecoration(
      color: colorscheme.secondaryContainer,
      borderRadius: BorderRadius.circular(10).r,
    ),
    child: Text(text),
  );
}
