import 'package:fint/core/constants/exports.dart';
import 'package:intl/intl.dart';

class CouponsAnalyticsScreen extends StatefulWidget {
  const CouponsAnalyticsScreen({super.key});

  @override
  State<CouponsAnalyticsScreen> createState() => _CouponsAnalyticsScreenState();
}

class _CouponsAnalyticsScreenState extends State<CouponsAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Color> colorList = [
    Color(0xFF8DBCC7),
    Color(0xFFA4CCD9),
    Color(0xFFC4E1E6),
  ];

  int _selectedTabIndex = 0;

  final List<String> _tabTitles = ["CLAIMED", "ACTIVE", "EXPIRED"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final couponsViewModel = Provider.of<CouponsViewmodel>(
        context,
        listen: false,
      );
      await couponsViewModel.fetchCoupons(context);
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "COUPONS",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.tertiary,
        foregroundColor: colorScheme.onPrimary,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: SafeArea(
        top: false,
        child: Consumer<CouponsViewmodel>(
          builder: (context, coupons, _) {
            final count = coupons.allCoupons.data.statusSummary;
            final Map<String, double> dataMap = {
              "Claimed": count.claimed.toDouble(),
              "Active": count.active.toDouble(),
              "Expired": count.expired.toDouble(),
            };

            final colorList = [
              Color(0xFF8DBCC7),
              Color(0xFFA4CCD9),
              Color(0xFFC4E1E6),
            ];

            return Skeletonizer(
              enabled: coupons.isCouponsLoading,
              child: Column(
                children: [
                  Container(
                    height: screenheight * 0.4,
                    width: screenwidth,
                    padding: EdgeInsets.all(20).r,
                    decoration: BoxDecoration(
                      color: Color(0xFFFDFAF6),
                      borderRadius: BorderRadius.circular(20).r,
                    ),
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: dataMap,
                          colorList: colorList,
                          chartType: ChartType.disc,
                          ringStrokeWidth: 32,
                          chartRadius: screenwidth / 2,
                          legendOptions: LegendOptions(showLegends: false),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValues: false,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildLegendItem(
                              "Claimed",
                              count.claimed,
                              colorList[0],
                            ),
                            _buildLegendItem(
                              "Active",
                              count.active,
                              colorList[1],
                            ),
                            _buildLegendItem(
                              "Expired",
                              count.expired,
                              colorList[2],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5.0,
                    ).r,
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15).r,
                        color: colorScheme.surfaceTint,
                        border: Border.all(
                          width: 1,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          final isSelected = _selectedTabIndex == index;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTabIndex = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? colorScheme.tertiary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  _tabTitles[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: isSelected
                                        ? colorScheme.onPrimary
                                        : colorScheme.tertiary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final coupons = Provider.of<CouponsViewmodel>(
                          context,
                        ).coupons;
                        switch (_selectedTabIndex) {
                          case 0:
                            return _buildCouponsList(
                              coupons,
                              "claimed",
                              Colors.green.shade400,
                            );
                          case 1:
                            return _buildCouponsList(
                              coupons,
                              "active",
                              Colors.blue.shade400,
                            );
                          case 2:
                            return _buildCouponsList(
                              coupons,
                              "expired",
                              Colors.red.shade400,
                            );
                          default:
                            return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCouponsList(List<Coupon> all, String type, Color iconColor) {
    final filtered = all.where((c) => c.status.toLowerCase() == type).toList();
    final colorscheme = Theme.of(context).colorScheme;

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          "No ${type.toUpperCase()} Coupons Found.",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: colorscheme.onSecondary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(16).r,
      itemCount: filtered.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final c = filtered[index];
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10).r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: c.logo == null
                        ? Icon(Icons.image_not_supported, size: 30.h)
                        : Image.network(
                            c.logo!,
                            height: 30.h,
                            width: 30.h,
                            fit: BoxFit.fill,
                          ),
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    children: List.generate(
                      10,
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
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(c.offerTitle, style: TextStyle(fontSize: 14.sp)),
                        SizedBox(height: 5.h),
                        type == "active"
                            ? Text(
                                "Valid until: ${DateFormat("dd MMM yyyy").format(c.expiryDate)}",
                                style: TextStyle(color: Colors.green),
                              )
                            : type == "expired"
                            ? SizedBox()
                            : Text(
                                "Status: ${c.status.toUpperCase()}",
                                style: TextStyle(color: iconColor),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (type == "expired")
              Positioned(
                top: 10,
                right: 10,
                child: Image.asset(
                  "assets/icons/expired.png",
                  height: 60.h,
                  width: 60.h,
                ),
              ),
          ],
        );
      },
    );
  }
}

Widget _buildLegendItem(String label, int count, Color color) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            width: 14.w,
            height: 14.h,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          SizedBox(width: 10.h),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ],
      ),

      Text(
        "$count",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}
