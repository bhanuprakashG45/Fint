import 'package:fint/core/constants/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CouponsViewmodel>(
        context,
        listen: false,
      ).fetchCoupons(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        final couponsViewmodel = Provider.of<CouponsViewmodel>(
          context,
          listen: false,
        );

        return Scaffold(
          backgroundColor: colorScheme.tertiary,
          body: SafeArea(
            top: false,
            child: Skeletonizer(
              enabled: couponsViewmodel.isCouponsLoading,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(30).r,
                        height: (screenHeight * 0.32).clamp(150, 300),
                        width: screenWidth,
                        decoration: BoxDecoration(color: colorScheme.tertiary),
                        child: Column(
                          children: [
                            SizedBox(height: 25.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: colorScheme.primaryContainer,
                                      width: 2,
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
                            SizedBox(height: 20.h),
                            Center(
                              child: Image.asset(
                                "assets/images/homelogo2.png",
                                height: (screenHeight * 0.22).clamp(50, 100),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ).r,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: (screenHeight * 0.09).clamp(50, 100),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: EdgeInsets.all(15).r,
                                      constraints: BoxConstraints(
                                        maxWidth: screenWidth * 0.9,
                                      ),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 3,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: colorScheme.primaryContainer,
                                          width: 2.r,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(80),
                                          bottomLeft: Radius.circular(80),
                                          bottomRight: Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                        ).r,
                                        color: colorScheme.secondaryContainer,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.qr_code_scanner,
                                            color: colorScheme.tertiary,
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "UPI ID : abcde12345@ybl",
                                            style: TextStyle(
                                              color: colorScheme.tertiary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 10.w),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20.sp,
                                            color: colorScheme.tertiary,
                                          ),
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
                                            color: colorScheme
                                                .onSecondaryContainer,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ).r,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Insurance",
                                                style: TextStyle(
                                                  color:
                                                      colorScheme.onSecondary,
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
                                                        RoutesName
                                                            .petinsurancescreen,
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
                                              color: colorScheme
                                                  .onSecondaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(20).r,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Red Drop",
                                                  style: TextStyle(
                                                    color:
                                                        colorScheme.onSecondary,
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
                                        Skeletonizer(
                                          enabled:
                                              couponsViewmodel.isCouponsLoading,
                                          child: Consumer<CouponsViewmodel>(
                                            builder: (context, homecouponprovider, child) {
                                              final coupons =
                                                  homecouponprovider.coupons;

                                              if (coupons.isEmpty) {
                                                return Container(
                                                  padding: EdgeInsets.all(20).r,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: colorScheme
                                                        .onSecondaryContainer,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ).r,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No coupons available.",
                                                      style: TextStyle(
                                                        color: colorScheme
                                                            .onSecondary,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }

                                              final homecoupon = coupons[0];

                                              return Container(
                                                padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10,
                                                ).r,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: colorScheme
                                                      .onSecondaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20,
                                                      ).r,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Spacer(flex: 2),
                                                        Text(
                                                          "Coupons",
                                                          style: TextStyle(
                                                            color: colorScheme
                                                                .onSecondary,
                                                            fontSize: 20.0.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                              context,
                                                              RoutesName
                                                                  .couponsscreen,
                                                            );
                                                          },
                                                          child: Text(
                                                            "view All",
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: colorScheme
                                                                  .tertiary,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                        10,
                                                      ).r,
                                                      decoration: BoxDecoration(
                                                        color: colorScheme
                                                            .onPrimary,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              15.r,
                                                            ),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                            context,
                                                            RoutesName
                                                                .couponredeempage,
                                                            arguments:
                                                                homecoupon.id,
                                                          );
                                                        },
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            homecoupon.logo ==
                                                                    null
                                                                ? ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          5,
                                                                        ).r,
                                                                    child: Icon(
                                                                      Icons
                                                                          .image_not_supported,
                                                                      size:
                                                                          30.h,
                                                                      color: colorScheme
                                                                          .tertiary,
                                                                    ),
                                                                  )
                                                                : ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          5.r,
                                                                        ),
                                                                    child: Image.network(
                                                                      homecoupon
                                                                          .logo!,
                                                                      height:
                                                                          30.h,
                                                                      width:
                                                                          30.h,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                            SizedBox(
                                                              width: 15.w,
                                                            ),
                                                            Column(
                                                              children: List.generate(
                                                                8,
                                                                (
                                                                  index,
                                                                ) => Container(
                                                                  width: 1.5,
                                                                  height: 3,
                                                                  margin:
                                                                      EdgeInsets.symmetric(
                                                                        vertical:
                                                                            2,
                                                                      ).r,
                                                                  color: Colors
                                                                      .orange,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    homecoupon
                                                                        .title,
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: colorScheme
                                                                          .tertiary,
                                                                      fontSize:
                                                                          16.sp,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4.h,
                                                                  ),
                                                                  Text(
                                                                    homecoupon
                                                                        .offerTitle,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: colorScheme
                                                                          .tertiary,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  Text(
                                                                    "Valid until: ${homecoupon.expiryDate.toLocal().toString().split(' ')[0]}",
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: colorScheme
                                                                          .tertiary,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
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
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 120.0.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    top: (screenHeight * 0.26).clamp(120, 250),
                    left: 20.w,
                    right: 20.w,
                    child: Container(
                      height: (screenHeight * 0.13).clamp(80, 120),
                      constraints: BoxConstraints(maxWidth: screenWidth - 40.w),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        border: Border.all(
                          color: colorScheme.primaryContainer,
                          width: 2,
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
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(1).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TransferOptionWidget(
                              icon: FontAwesomeIcons.phone,
                              label: 'Pay to Phone Number',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.payToNumberScreen,
                                );
                              },
                            ),
                            _buildVerticalDivider(colorScheme),
                            TransferOptionWidget(
                              icon: FontAwesomeIcons.buildingColumns,
                              label: 'Pay to Bank A/c',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.payToBankscreen,
                                );
                              },
                            ),
                            _buildVerticalDivider(colorScheme),
                            TransferOptionWidget(
                              icon: FontAwesomeIcons.solidUser,
                              label: 'Pay to Self',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.payToSelfscreen,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: (screenWidth * 0.39).clamp(50, 150),
                    right: (screenWidth * 0.39).clamp(50, 150),
                    child: SafeArea(
                      top: false,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.qrscanorgalleryscreen,
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 100.w,
                            maxHeight: 100.h,
                          ),
                          child: Image.asset(
                            "assets/images/qr_home2.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
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

Widget _buildVerticalDivider(ColorScheme colorScheme) {
  return Container(height: 75.h, width: 1.5.w, color: colorScheme.tertiary);
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
        Icon(icon, color: colorscheme.tertiary),
        Text(
          text,
          style: TextStyle(
            color: colorscheme.tertiary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
