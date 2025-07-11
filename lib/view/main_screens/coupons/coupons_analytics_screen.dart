import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/coupon_model/all_coupon_model.dart';
import 'package:fint/view_model/coupons_viewmodel/coupons_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
          style: TextStyle(
            color: AppColor.appcolor,
            fontSize: 22.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: Consumer<CouponsViewmodel>(
        builder: (context, coupons, _) {
          // if (coupons.isCouponsLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }
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

                SizedBox(height: 30.h),

                // Tabs
                TabBar(
                  controller: _tabController,
                  labelColor: colorScheme.secondary,
                  unselectedLabelColor: colorScheme.onSurface,
                  indicatorColor: colorScheme.secondary,
                  tabs: const [
                    Tab(text: "CLAIMED"),
                    Tab(text: "ACTIVE"),
                    Tab(text: "EXPIRED"),
                  ],
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildCouponsList(
                        coupons.coupons,
                        "claimed",
                        Colors.green,
                      ),
                      _buildCouponsList(coupons.coupons, "active", Colors.blue),
                      _buildCouponsList(coupons.coupons, "expired", Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCouponsList(List<Coupon> all, String type, Color iconColor) {
    final filtered = all.where((c) => c.status.toLowerCase() == type).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          "No ${type.toUpperCase()} coupons found.",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
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
        return Container(
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
                        : Text(
                            "Status: ${c.status.toUpperCase()}",
                            style: TextStyle(color: iconColor),
                          ),
                  ],
                ),
              ),
            ],
          ),
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
