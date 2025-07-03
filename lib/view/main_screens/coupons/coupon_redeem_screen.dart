import 'package:fint/core/constants/exports.dart';

class CouponRedeemScreen extends StatefulWidget {
  const CouponRedeemScreen({super.key});

  @override
  State<CouponRedeemScreen> createState() => _CouponRedeemScreenState();
}

class _CouponRedeemScreenState extends State<CouponRedeemScreen> {
  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    // double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      backgroundColor: colorscheme.secondaryContainer,
      body: SingleChildScrollView(
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
                        Image.network(
                          "https://tse2.mm.bing.net/th?id=OIP.oXt4_1HIiaezAlVKLtnzEgHaGV&pid=Api&P=0&h=180",
                          height: 100.0.h,
                          width: 100.0.w,
                        ),
                        SizedBox(width: 20.0.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "McDonald's",
                                style: TextStyle(
                                  fontSize: 22.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              Text(
                                "Buy 1 \nGet 1 \n Free",
                                style: TextStyle(
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              Text(
                                "Purchase Any McDonald's Pizza and A Burger",
                              ),
                              Text("Complimentary Second Beverage"),
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
                          "- Redeem at all McDonald's outlets",
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "- Valid only on dine-in orders",
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "- Show this screen at counter",
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "- Not combinable with other offers",
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w500,
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
                          Icon(Icons.calendar_month),
                          SizedBox(width: 15.0.w),
                          Text(
                            "Expires on : 30 Jun 2025 , 2:00 PM",
                            style: TextStyle(
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ExpansionTile(
                      leading: Padding(
                        padding: EdgeInsets.only(top: 4.0.h),
                        child: Icon(Icons.info_outline, color: Colors.black),
                      ),
                      title: Text(
                        "Offer Details",
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      collapsedIconColor: Colors.black,
                      iconColor: Colors.black,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0.w,
                            vertical: 8.0.h,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "-Abcdefghijklmnopqrstuvwxyz anvjksnvkjnBKJKJ",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0.w,
                            vertical: 8.0.h,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "-Abcdefghijklmnopqrstuvwxyz anvjksnvkjnBKJKJ",
                              style: TextStyle(fontSize: 16.sp),
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
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "About McDonald's",
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      collapsedIconColor: Colors.black,
                      iconColor: Colors.black,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0.w,
                            vertical: 8.0.h,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "-Abcdefghijklmnopqrstuvwxyz anvjksnvkjnBKJKJ",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0.w,
                            vertical: 8.0.h,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "-Abcdefghijklmnopqrstuvwxyz anvjksnvkjnBKJKJ",
                              style: TextStyle(fontSize: 16.sp),
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
                    backgroundColor: colorscheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CLAIM & GENERATE QR CODE",
                    style: TextStyle(
                      color: Colors.white,
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
  }
}
