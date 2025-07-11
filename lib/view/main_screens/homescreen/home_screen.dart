import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/coupons_viewmodel/coupons_viewmodel.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final couponsViewmodel = Provider.of<CouponsViewmodel>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: colorScheme.tertiary,
      body: Skeletonizer(
        enabled: couponsViewmodel.isCouponsLoading,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(30).r,
                    height: screenHeight * 0.36,
                    width: screenWidth,
                    decoration: BoxDecoration(color: colorScheme.tertiary),
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
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ).r,
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
                                  Skeletonizer(
                                    enabled: couponsViewmodel.isCouponsLoading,
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
                                                  BorderRadius.circular(20).r,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "No coupons available.",
                                                style: TextStyle(
                                                  color:
                                                      colorScheme.onSecondary,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        final homecoupon = coupons[0];

                                        return Container(
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
                                                      "View All >",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: colorScheme
                                                            .secondary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10).r,
                                                decoration: BoxDecoration(
                                                  color: colorScheme.onPrimary,
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
                                                      arguments: homecoupon.id,
                                                    );
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      homecoupon.logo == null
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5.r,
                                                                  ),
                                                              child: Icon(
                                                                Icons
                                                                    .image_not_supported,
                                                                size: 30.h,
                                                                color: colorScheme
                                                                    .tertiary,
                                                              ),
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5.r,
                                                                  ),
                                                              child:
                                                                  Image.network(
                                                                    homecoupon
                                                                        .logo!,
                                                                    height:
                                                                        30.h,
                                                                    width: 30.h,
                                                                    fit: BoxFit
                                                                        .fill,
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
                                                                ).r,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.w),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              homecoupon.title,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: colorScheme
                                                                    .tertiary,
                                                                fontSize: 16.sp,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 4.h,
                                                            ),
                                                            Text(
                                                              homecoupon
                                                                  .offerTitle,
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: colorScheme
                                                                    .tertiary,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Text(
                                                              "Valid until: ${homecoupon.expiryDate.toLocal().toString().split(' ')[0]}",
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: colorScheme
                                                                    .tertiary,
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
                                        );
                                      },
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
              left: screenWidth * 0.39,
              right: screenWidth * 0.39,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.qrscanorgalleryscreen,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(),
                  child: Image.asset(
                    "assets/images/qr_home2.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildVerticalDivider(ColorScheme colorScheme) {
  return Container(height: 80.h, width: 1.5.w, color: colorScheme.tertiary);
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
