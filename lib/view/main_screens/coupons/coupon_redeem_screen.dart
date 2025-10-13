import 'package:fint/core/constants/exports.dart';

class CouponRedeemScreen extends StatefulWidget {
  final String couponId;
  const CouponRedeemScreen({super.key, required this.couponId});

  @override
  State<CouponRedeemScreen> createState() => _CouponRedeemScreenState();
}

class _CouponRedeemScreenState extends State<CouponRedeemScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final couponProvider = Provider.of<CouponsViewmodel>(
        context,
        listen: false,
      );
      await couponProvider.fetchCouponById(context, widget.couponId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Redeem Coupon",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.onPrimary,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: colorscheme.secondaryContainer,
      body: SafeArea(
        top: false,
        child: Consumer<CouponsViewmodel>(
          builder: (context, couponprovider, child) {
            final reedemcoupon = couponprovider.reedemCoupon;
            return Skeletonizer(
              enabled: couponprovider.isReedemCouponLoading,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0).r,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10).r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).r,

                          color: colorscheme.onPrimary,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                reedemcoupon.logo == null
                                    ? Container(
                                        height: 30.h,
                                        width: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 20.sp,
                                          color: Colors.grey.shade600,
                                        ),
                                      )
                                    : Image.network(
                                        reedemcoupon.logo,
                                        height: 100.0.h,
                                        width: 100.0.w,

                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  height: 100.0.h,
                                                  width: 100.0.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5.r,
                                                        ),
                                                  ),
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 20.sp,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                      ),
                                SizedBox(width: 20.0.w),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reedemcoupon.couponTitle,
                                        style: TextStyle(
                                          fontSize: 22.0.sp,
                                          color: colorscheme.tertiary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.0.h),
                                      Text(
                                        reedemcoupon.offerTitle,
                                        style: TextStyle(
                                          fontSize: 18.0.sp,
                                          color: colorscheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.0.h),
                                      Text(
                                        reedemcoupon.offerDescription,
                                        style: TextStyle(
                                          fontSize: 16.0.sp,
                                          color: colorscheme.onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.h),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reedemcoupon.offerDetails,
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    color: colorscheme.onSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Container(
                        padding: EdgeInsets.all(10).r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).r,

                          color: colorscheme.onPrimary,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: colorscheme.tertiary,
                                  ),
                                  SizedBox(width: 15.0.w),
                                  Text(
                                    "Expires on : ${reedemcoupon.expiryDate.toLocal().toString().split(' ')[0]}",
                                    style: TextStyle(
                                      fontSize: 18.0.sp,
                                      color: colorscheme.tertiary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),

                            ExpansionTile(
                              leading: Padding(
                                padding: EdgeInsets.only(top: 3.0.h),
                                child: Icon(
                                  Icons.info_outline,
                                  color: colorscheme.tertiary,
                                ),
                              ),
                              title: Text(
                                "Offer Details",
                                style: TextStyle(
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colorscheme.tertiary,
                                ),
                              ),

                              collapsedIconColor: colorscheme.tertiary,
                              iconColor: colorscheme.tertiary,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.0.w,
                                    vertical: 8.0.h,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      reedemcoupon.offerDetails,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: colorscheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ExpansionTile(
                              leading: Padding(
                                padding: EdgeInsets.only(top: 4.0.h),
                                child: FaIcon(
                                  FontAwesomeIcons.fileLines,
                                  color: colorscheme.tertiary,
                                ),
                              ),
                              title: Text(
                                reedemcoupon.aboutCompany.isNotEmpty
                                    ? "About Company"
                                    : "Terms & Conditions",
                                style: TextStyle(
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colorscheme.tertiary,
                                ),
                              ),

                              collapsedIconColor: colorscheme.tertiary,
                              iconColor: colorscheme.tertiary,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.0.w,
                                    vertical: 8.0.h,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      reedemcoupon.aboutCompany.isNotEmpty
                                          ? reedemcoupon.aboutCompany
                                          : reedemcoupon.termsAndConditions,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: colorscheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0.h),
                      SizedBox(
                        width: screenwidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorscheme.tertiary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15).r,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "CLAIM & GENERATE QR CODE",
                            style: TextStyle(
                              color: colorscheme.onPrimary,
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
