import 'package:fint/core/constants/color.dart';
import 'package:fint/core/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 80.h),
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: Size.fromHeight(180.h),
                    child: ClipPath(
                      clipper: WaveClipperOne(flip: true),
                      child: Container(
                        height: 150.h,
                        color: AppColor.appcolor,
                        alignment: Alignment.center,
                        child: SafeArea(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: colorScheme.primaryContainer,
                                    size: 28.sp,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Verification Code',
                                  style: TextStyle(
                                    color: colorScheme.primaryContainer,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        'Verify Your Mobile Number',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Enter OTP sent to +91 ${widget.phoneNumber}',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 30.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40).r,
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          cursorColor: AppColor.appcolor,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            borderRadius: BorderRadius.circular(5).r,
                            fieldHeight: 70.h,
                            fieldWidth: 70.w,

                            activeColor: Colors.grey,
                            selectedColor: AppColor.appcolor,
                            inactiveColor: Colors.grey.shade400,
                          ),
                          onChanged: (value) {},
                          autoDisposeControllers: false,
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        "RESEND OTP >",
                        style: TextStyle(
                          color: AppColor.appcolor,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).r,
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColor.appcolor,
                            borderRadius: BorderRadius.circular(10.0).r,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.homescreen,
                              );
                            },
                            child: Text(
                              'VERIFY',
                              style: TextStyle(
                                fontSize: 18.0.sp,
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
