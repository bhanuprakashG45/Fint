import 'package:fint/core/constants/color.dart';
import 'package:fint/core/utils/routes/routes_name.dart';
import 'package:fint/core/utils/widgets/transfer_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colorScheme.tertiary,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(30).r,
                  height: screenHeight * 0.36,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [colorScheme.primary, colorScheme.secondary],
                    // ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colorScheme.primaryContainer,
                                width: 2.r,
                              ),
                              borderRadius: BorderRadius.circular(20).r,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.profilescreen,
                                );
                              },
                              child: Icon(
                                Icons.person_outline,
                                color: colorScheme.primaryContainer,
                                size: 25.0.sp,
                              ),
                            ),
                          ),
                          const Spacer(flex: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.notificationscreen,
                              );
                            },
                            child: FaIcon(
                              FontAwesomeIcons.solidBell,
                              color: colorScheme.primaryContainer,
                              size: 30.0.sp,
                            ),
                          ),
                          const Spacer(flex: 1),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.transactionhistoty,
                              );
                            },
                            child: FaIcon(
                              FontAwesomeIcons.clockRotateLeft,
                              color: colorScheme.primaryContainer,
                              size: 25.0.sp,
                            ),
                          ),
                        ],
                      ),

                      Image.asset(
                        "assets/images/homelogo2.png",
                        height: screenHeight * 0.25,
                        width: screenWidth,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: screenHeight * 0.64,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.09),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(15).r,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: colorScheme.primaryContainer,
                                  width: 2.r,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(80.r),
                                  bottomLeft: Radius.circular(80.r),
                                  bottomRight: Radius.circular(5.r),
                                  topLeft: Radius.circular(5.r),
                                ),
                                color: colorScheme.secondaryContainer,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.qr_code_scanner),
                                  SizedBox(width: 10.w),
                                  Text("UPI ID : abcde12345@ybl"),
                                  SizedBox(width: 10.w),
                                  Icon(Icons.arrow_forward_ios, size: 20.sp),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20.0.h),
                          Container(
                            width: screenWidth * 0.9,
                            padding: EdgeInsets.all(20).r,
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(20).r,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10).r,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: colorScheme.onSecondaryContainer,
                                    borderRadius: BorderRadius.circular(20).r,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Insurance",
                                        style: TextStyle(
                                          color: colorScheme.onSecondary,
                                          fontSize: 20.0.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RoutesName.petinsurancescreen,
                                              );
                                            },
                                            child: _buildInsuranceCard(
                                              Icons.pets,
                                              "Pet Insurance",
                                              colorScheme,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0.h),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.reddropscreen,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10).r,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: colorScheme.onSecondaryContainer,
                                      borderRadius: BorderRadius.circular(20).r,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Red Drop",
                                          style: TextStyle(
                                            color: colorScheme.onSecondary,
                                            fontSize: 20.0.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        _buildInsuranceCard(
                                          Icons.water_drop_outlined,
                                          "A DROP OF HOPE, A LIFE OF MANY",
                                          colorScheme,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0.h),
                                Container(
                                  padding: EdgeInsets.all(10).r,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: colorScheme.onSecondaryContainer,
                                    borderRadius: BorderRadius.circular(20).r,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Spacer(flex: 2),
                                          Text(
                                            "Coupons",
                                            style: TextStyle(
                                              color: colorScheme.onSecondary,
                                              fontSize: 20.0.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                RoutesName.couponsscreen,
                                              );
                                            },
                                            child: Text(
                                              "View All >",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: colorScheme.secondary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(10).r,
                                        decoration: BoxDecoration(
                                          color: colorScheme.onPrimary,
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              RoutesName.couponredeempage,
                                            );
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
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
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                          vertical: 2,
                                                        ),
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(width: 10.w),

                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "McDonald's Coupon",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Text(
                                                      "₹50 OFF on orders above ₹299",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors
                                                            .grey
                                                            .shade700,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    Text(
                                                      "Valid until: 30 Jun 2025",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 100.0.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: screenHeight * 0.28,
            left: 20,
            right: 20,
            child: Container(
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                border: Border.all(
                  color: colorScheme.primaryContainer,
                  width: 2.r,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80.r),
                  bottomLeft: Radius.circular(80.r),
                  bottomRight: Radius.circular(5.r),
                  topLeft: Radius.circular(5.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(5.0).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TransferOptionWidget(
                      icon: FontAwesomeIcons.phone,
                      label: 'Pay to Phone Number',
                      onTap: () {},
                    ),
                    _buildVerticalDivider(colorScheme),
                    TransferOptionWidget(
                      icon: FontAwesomeIcons.buildingColumns,
                      label: 'Pay to Bank A/c',
                    ),
                    _buildVerticalDivider(colorScheme),
                    TransferOptionWidget(
                      icon: FontAwesomeIcons.user,
                      label: 'Pay to Self',
                    ),
                    _buildVerticalDivider(colorScheme),
                    TransferOptionWidget(
                      icon: FontAwesomeIcons.creditCard,
                      label: 'Check Balance',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: screenWidth * 0.4,
            right: screenWidth * 0.4,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.qrscanorgalleryscreen);
              },
              child: Container(
                height: 80.0.h,
                width: 80.0.w,
                // padding: EdgeInsets.all(7).r,
                decoration: BoxDecoration(
                  color: colorScheme.tertiary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(30),
                  ).r,
                ),
                child: Padding(
                  padding: EdgeInsets.all(18.0.r),
                  child: Image.asset(
                    "assets/images/qr.png",
                    fit: BoxFit.cover,
                    color: colorScheme.primaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildVerticalDivider(ColorScheme colorScheme) {
  return Container(
    height: 80.h,
    width: 1.5.w,
    color: colorScheme.primaryContainer,
  );
}

Widget _buildInsuranceCard(
  IconData icon,
  String text,
  ColorScheme colorscheme,
) {
  return Container(
    padding: EdgeInsets.all(10).r,
    decoration: BoxDecoration(
      color: colorscheme.onPrimary,
      borderRadius: BorderRadius.circular(10).r,
    ),
    child: Column(
      children: [
        Icon(icon),
        Text(text, textAlign: TextAlign.center),
      ],
    ),
  );
}
