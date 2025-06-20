import 'package:fint/core/constants/color.dart';
import 'package:fint/core/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Coupons",
            style: TextStyle(
              color: AppColor.appcolor,
              fontSize: 22.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.couponanalyticsscreen);
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0).r,
                child: FaIcon(
                  FontAwesomeIcons.chartSimple,
                  color: colorScheme.onSecondary,
                ),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: colorScheme.secondaryContainer,
        ),
        backgroundColor: colorScheme.secondaryContainer,
        body: Column(
          children: [
            Container(
              color: colorScheme.secondaryContainer,
              child: TabBar(
                labelColor: AppColor.appcolor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColor.appcolor,
                tabs: const [Tab(text: "Active"), Tab(text: "Inactive")],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.couponredeempage);
                    },
                    child: _buildCouponList(active: true),
                  ),
                  _buildCouponList(active: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponList({required bool active}) {
    final coupons = [
      {
        "title": "McDonald's Coupon",
        "description": "₹50 OFF on orders above ₹299",
        "validTill": "30 Jun 2025",
        "isActive": true,
      },
      {
        "title": "Domino's Pizza",
        "description": "Flat ₹100 OFF on ₹499",
        "validTill": "15 Jul 2025",
        "isActive": true,
      },
      {
        "title": "Zomato Deal",
        "description": "20% OFF (Max ₹80)",
        "validTill": "Expired",
        "isActive": false,
      },
      {
        "title": "McDonald's Coupon",
        "description": "₹50 OFF on orders above ₹299",
        "validTill": "30 Jun 2025",
        "isActive": true,
      },
      {
        "title": "McDonald's Coupon",
        "description": "₹50 OFF on orders above ₹299",
        "validTill": "30 Jun 2025",
        "isActive": true,
      },
      {
        "title": "McDonald's Coupon",
        "description": "₹50 OFF on orders above ₹299",
        "validTill": "Expired",
        "isActive": false,
      },
      {
        "title": "McDonald's Coupon",
        "description": "₹50 OFF on orders above ₹299",
        "validTill": "30 Jun 2025",
        "isActive": true,
      },
      {
        "title": "McDonald's Coupon",
        "description": "₹50 OFF on orders above ₹299",
        "validTill": "Expired",
        "isActive": false,
      },
    ];

    final filtered = coupons.where((c) => c["isActive"] == active).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text("No ${active ? "active" : "inactive"} coupons."),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(16).r,
      itemCount: filtered.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.0.h),
      itemBuilder: (context, index) {
        final coupon = filtered[index];
        return ClipPath(
          clipper: _CouponClipper(),
          child: Container(
            padding: EdgeInsets.all(10).r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.couponredeempage);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Image.network(
                      'https://tse2.mm.bing.net/th?id=OIP.oXt4_1HIiaezAlVKLtnzEgHaGV&pid=Api&P=0&h=180',
                      height: 30.h,
                      width: 30.h,
                      fit: BoxFit.fill,
                    ),
                  ),

                  SizedBox(width: 15.w),

                  Column(
                    children: List.generate(
                      8,
                      (index) => Container(
                        width: 1.5,
                        height: 3,
                        margin: EdgeInsets.symmetric(vertical: 2).r,
                        color: Colors.orange,
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coupon["title"].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          coupon["description"].toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Valid until:",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              coupon["validTill"].toString(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.red.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CouponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double cutRadius = 10;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - cutRadius);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(cutRadius),
      clockwise: false,
    );
    path.lineTo(0, size.height);
    path.lineTo(0, cutRadius);
    path.arcToPoint(
      Offset(0, 0),
      radius: Radius.circular(cutRadius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
