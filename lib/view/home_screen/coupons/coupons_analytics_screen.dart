import 'package:fint/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

class CouponsAnalyticsScreen extends StatefulWidget {
  const CouponsAnalyticsScreen({super.key});

  @override
  State<CouponsAnalyticsScreen> createState() => _CouponsAnalyticsScreenState();
}

class _CouponsAnalyticsScreenState extends State<CouponsAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, double> dataMap = {"Claimed": 8, "Active": 2, "Expired": 2};

  final List<Color> colorList = [
    Color(0xFF8DBCC7),
    Color(0xFFA4CCD9),
    Color(0xFFC4E1E6),
  ];

  @override
  void initState() {
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.all(15.0).r,
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
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    // centerText: "Coupons",
                    legendOptions: LegendOptions(
                      showLegends: false,
                      // legendPosition: LegendPosition.bottom,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      // showChartValuesInPercentage: true,
                      // showChartValuesOutside: true,
                      showChartValues: false,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegendItem(
                        "Claimed",
                        dataMap["Claimed"]!.toInt(),
                        Color(0xFF8DBCC7),
                      ),
                      _buildLegendItem(
                        "Active",
                        dataMap["Active"]!.toInt(),
                        Color(0xFFA4CCD9),
                      ),
                      _buildLegendItem(
                        "Expired",
                        dataMap["Expired"]!.toInt(),
                        Color(0xFFC4E1E6),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            TabBar(
              controller: _tabController,
              labelColor: colorScheme.secondary,
              unselectedLabelColor: colorScheme.onSurface.withValues(),

              indicatorColor: colorScheme.secondary,
              tabs: [
                Text(
                  "CLAIMED",
                  style: TextStyle(
                    fontSize: 17.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "ACTIVE",
                  style: TextStyle(
                    fontSize: 17.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "EXPIRED",
                  style: TextStyle(
                    fontSize: 17.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCouponsList("Claimed", Colors.green),
                  _buildCouponsList("Active", Colors.blue),
                  _buildCouponsList("Expired", Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponsList(String type, Color iconColor) {
    final coupons = List.generate(
      5,
      (i) => {
        "title": "$type Coupon",
        "description": "Sample offer details here",
        "validTill": "30 Jun 2025",
      },
    );

    return ListView.builder(
      padding: EdgeInsets.all(16).r,
      itemCount: coupons.length,
      itemBuilder: (context, i) {
        final c = coupons[i];
        return Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8).r,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12).r,
          ),
          child: ListTile(
            leading: Icon(Icons.local_offer, color: iconColor),
            title: Text(
              c["title"]!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              c["description"]!,
              style: TextStyle(color: Colors.green),
            ),

            trailing: Text(
              "Until ${c["validTill"]!}",
              style: TextStyle(color: Colors.green),
            ),
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
