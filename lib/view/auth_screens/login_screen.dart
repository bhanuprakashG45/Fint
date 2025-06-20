import 'package:fint/core/constants/color.dart';
import 'package:fint/core/utils/routes/routes_name.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phonecontroller = TextEditingController();
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
                      clipper: WaveClipperOne(),
                      child: Container(
                        height: 150.h,
                        color: AppColor.appcolor,
                        alignment: Alignment.center,
                        child: SafeArea(
                          child: Stack(
                            children: [
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: IconButton(
                              //     icon: Icon(
                              //       Icons.arrow_back,
                              //       color: Colors.white,
                              //       size: 28.sp,
                              //     ),
                              //     onPressed: () => Navigator.pop(context),
                              //   ),
                              // ),
                              Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: colorScheme.primaryContainer,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w600,
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
                    children: [
                      Text(
                        'SIGN IN TO FINT',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),

                      Text(
                        'Hi! Welcome back, you were missed!',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).r,
                        child: Text(
                          "ENTER PHONE NUMBER",
                          style: TextStyle(
                            fontSize: 15.0.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20).r,
                        child: TextFormField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.0.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).r,
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColor.appcolor,
                        // gradient: LinearGradient(
                        //   colors: [Colors.blue, colorScheme.secondary],
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        // ),
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
                            RoutesName.otpscreen,
                            arguments: phonecontroller.text.trim(),
                          );
                        },
                        child: Text(
                          'VERIFY',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0.w,
                          vertical: 24.0.h,
                        ),
                        child: Text.rich(
                          TextSpan(
                            text: "By proceeding , you are agreeing to Fint's ",
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        // launchUrls(
                                        //   'https://aoladmin.kods.app/terms-of-use',
                                        // );
                                      },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms of Conditions.',
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        // launchUrls(
                                        //   'https://aoladmin.kods.app/privacy-policy',
                                        // );
                                      },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: WaveClipperOne(flip: true, reverse: true),
              child: Container(
                height: 120.h,
                width: double.infinity,
                color: AppColor.appcolor,
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      color: colorScheme.primaryContainer,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.signupscreen,
                                );
                              },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
