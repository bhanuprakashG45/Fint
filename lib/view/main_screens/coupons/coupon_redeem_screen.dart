import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/main_screens/coupons/coupon_clipper.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 10,
                    left: 10,
                    bottom: 10,
                  ).r,
                  child: Column(
                    children: [
                      PhysicalModel(
                        color: Colors.transparent,
                        elevation: 6,
                        shadowColor: Colors.black54,
                        borderRadius: BorderRadius.circular(20).r,
                        child: ClipPath(
                          clipper: CouponClipper(),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 12,
                              left: 20,
                            ).r,
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
                                            height: 100.h,
                                            width: 100.h,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Icon(
                                              Icons.image_not_supported,
                                              size: 90.sp,
                                              color: Colors.grey.shade600,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ).r,
                                            child: Container(
                                              height: 100.0.h,
                                              width: 100.0.w,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              child: Image.network(
                                                reedemcoupon.logo,
                                                fit: BoxFit.cover,

                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Icon(
                                                      Icons.image_not_supported,
                                                      size: 90.sp,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
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
                                            reedemcoupon.couponTitle
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 22.0.sp,
                                              color: colorscheme.tertiary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5.0.h),
                                          Text(
                                            reedemcoupon.offerTitle,
                                            style: TextStyle(
                                              fontSize: 18.0.sp,
                                              color: colorscheme.secondary,
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

                                // SizedBox(height: 20.h),

                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       reedemcoupon.offerDetails,
                                //       style: TextStyle(
                                //         fontSize: 16.0.sp,
                                //         color: colorscheme.onSecondary,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Container(
                        padding: EdgeInsets.all(10).r,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade500,
                            width: 0.5,
                          ),
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
                                    "Expires on : ${DateFormat('dd MMM yyyy').format(reedemcoupon.expiryDate)}",
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

                            Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
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
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
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
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                          onPressed: () async {
                            final SharedPref _pref = SharedPref();
                            final userId = await _pref.getUserId();
                            final Map<String, dynamic> qrMap = {
                              "couponId": reedemcoupon.id,
                              "userId": userId,
                            };

                            final String qrData = jsonEncode(qrMap);
                            debugPrint("QRData : $qrData");
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (_) => _qrBottomSheet(context, qrData),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code,
                                color: colorscheme.primaryContainer,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Claim & Generate QR",
                                style: TextStyle(
                                  color: colorscheme.onPrimary,
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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

  Widget _qrBottomSheet(BuildContext context, dynamic data) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Scan to Approve Coupon",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            PrettyQrView.data(
              data: data,
              decoration: const PrettyQrDecoration(
                image: PrettyQrDecorationImage(
                  image: AssetImage('assets/images/appicon_final.png'),
                ),
                quietZone: PrettyQrQuietZone.standart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
