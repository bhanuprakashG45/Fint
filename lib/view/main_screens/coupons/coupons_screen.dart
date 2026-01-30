import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/main_screens/coupons/coupon_clipper.dart';
import 'package:intl/intl.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final couponprovider = Provider.of<CouponsViewmodel>(
        context,
        listen: false,
      );
      await couponprovider.fetchCoupons(context);
    });
  }

  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Coupons",
            style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
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
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: colorScheme.tertiary,
          foregroundColor: colorScheme.onPrimary,
        ),
        backgroundColor: colorScheme.secondaryContainer,
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceTint,
                    borderRadius: BorderRadius.circular(15).r,
                    border: Border.all(width: 0.3, color: colorScheme.tertiary),
                  ),
                  child: Row(
                    children: [
                      _buildToggleButton("Active", 0),
                      _buildToggleButton("Inactive", 1),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(child: _buildCouponList(active: _selectedTabIndex == 0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, int index) {
    final isSelected = _selectedTabIndex == index;
    final colorscheme = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? colorscheme.tertiary : Colors.transparent,
            borderRadius: BorderRadius.circular(15).r,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? colorscheme.onPrimary : colorscheme.tertiary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCouponList({required bool active}) {
    final colorscheme = Theme.of(context).colorScheme;
    return Consumer<CouponsViewmodel>(
      builder: (context, couponprovider, child) {
        final coupons = couponprovider.coupons;

        final filtered = coupons.where((c) {
          final status = c.status.toLowerCase();
          if (active) {
            return status == 'active';
          } else {
            return status == 'expired' || status == 'deleted';
          }
        }).toList();

        if (filtered.isEmpty) {
          return Center(
            child: Text(
              "No ${active ? "active" : "inactive"} coupons.",
              style: TextStyle(
                fontSize: 18.sp,
                color: colorscheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16).r,
          itemCount: filtered.length,
          separatorBuilder: (context, index) => SizedBox(height: 10.0.h),
          itemBuilder: (context, index) {
            final coupon = filtered[index];
            return Stack(
              children: [
                PhysicalModel(
                  color: Colors.transparent,
                  elevation: 6,
                  shadowColor: Colors.black26,
                  child: ClipPath(
                    clipper: CouponClipper(),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 10,
                        right: 10,
                        bottom: 10,
                      ).r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (coupon.status.toLowerCase() == 'active') {
                            Navigator.pushNamed(
                              context,
                              RoutesName.couponredeempage,
                              arguments: coupon.id,
                            );
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            coupon.logo == null
                                ? Container(
                                    height: 100.h,
                                    width: 100.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 90.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12).r,
                                    child: Image.network(
                                      coupon.logo!,
                                      height: 100.h,
                                      width: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                            SizedBox(width: 15.w),

                            Column(
                              children: List.generate(
                                14,
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
                                    coupon.title.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    coupon.offerTitle.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: colorscheme.secondary,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    coupon.offerDescription,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  coupon.status.toLowerCase() == 'active'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Valid until:",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              DateFormat(
                                                'dd MMM yyyy',
                                              ).format(coupon.expiryDate),
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.green.shade400,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (coupon.status.toLowerCase() == 'deleted' ||
                    coupon.status.toLowerCase() == 'expired')
                  Positioned(
                    top: 20.r,
                    right: 20.r,
                    child: Image.asset(
                      coupon.status.toLowerCase() == 'deleted'
                          ? 'assets/icons/deleted.png'
                          : 'assets/icons/rejected.png',
                      width: 70.w,
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
