

import 'package:fint/core/constants/exports.dart';

class ViewAllBloodrequestsScreen extends StatefulWidget {
  const ViewAllBloodrequestsScreen({super.key});

  @override
  State<ViewAllBloodrequestsScreen> createState() =>
      _ViewAllBloodrequestsScreenState();
}

class _ViewAllBloodrequestsScreenState
    extends State<ViewAllBloodrequestsScreen> {
  int count = 10;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ALL BLOOD REQUESTS",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10).r,
          child: Column(
            children: List.generate(
              count,
              (index) => _buildBloodRequestCard(colorScheme, screenWidth),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBloodRequestCard(ColorScheme colorScheme, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(bottom: 15).r,
      width: screenWidth,
      padding: EdgeInsets.all(10).r,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20).r,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth,
            margin: EdgeInsets.only(top: 10).r,
            padding: EdgeInsets.all(5).r,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(15).r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "URGENT",
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://media.istockphoto.com/id/1136879204/vector/creative-vector-illustration-of-blood-type-group-isolated-on-transparent-background-art.jpg?s=612x612&w=0&k=20&c=zhrVB6wXtIFkpgWk5IpnU5eqTNYoAG99SmiBa-LLjao=",
                      height: 80.0.h,
                      width: 90.0.w,
                    ),
                    SizedBox(width: 15.0.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jackie John",
                          style: TextStyle(
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0.h),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.kitMedical, size: 20.0.sp),
                            SizedBox(width: 10.0.w),
                            Text(
                              "ABC Hospital",
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0.h),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.locationDot, size: 20.0.sp),
                            SizedBox(width: 15.0.w),
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0.h),
                        SizedBox(
                          height: 30.0.h,
                          width: 120.0.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.all(0).r,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15).r,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                count = count--;
                              });
                            },
                            child: Text(
                              "Stop Request",
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
