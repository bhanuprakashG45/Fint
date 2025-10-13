import 'package:fint/core/constants/exports.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isOtpVerifying = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final otpprovider = Provider.of<OtpViewModel>(context, listen: false);
    final loginprovider = Provider.of<LoginViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    Future<void> checkOTP() async {
      setState(() {
        isOtpVerifying = true;
      });
      final phone = widget.phoneNumber;
      final otp = otpController.text;
      if (otp.isEmpty) {
        ToastHelper.show(
          context,
          'OTP is required',
          type: ToastificationType.error,
          duration: Duration(seconds: 5),
        );
        setState(() {
          isOtpVerifying = false;
        });
      } else {
        await otpprovider.verifyOtp(phone, otp, context);
        otpprovider.isOtpLoading
            ? setState(() {
                isOtpVerifying = true;
              })
            : setState(() {
                isOtpVerifying = false;
              });
      }
    }

    Future<void> resendOTP() async {
      final phone = widget.phoneNumber;
      await loginprovider.loginUser(phone, context);
      loginprovider.isLoginLoading
          ? setState(() {
              isOtpVerifying = true;
            })
          : setState(() {
              isOtpVerifying = false;
            });
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
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
                            bottom: false,
                            top: false,
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
                        SizedBox(height: 10.h),
                        Text(
                          'Enter OTP sent to your mobile',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          'assets/images/otp.png',
                          height: size.height * 0.2,
                          width: size.width * 0.4,
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

                              activeColor: colorScheme.onSecondary,
                              selectedColor: AppColor.appcolor,
                              inactiveColor: colorScheme.onSecondary,
                            ),
                            onChanged: (value) {},
                            autoDisposeControllers: false,
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
                              onPressed: () async {
                                await checkOTP();
                              },
                              child: isOtpVerifying
                                  ? SizedBox(
                                      height: 20.0.h,
                                      width: 20.0.w,
                                      child: CircularProgressIndicator(
                                        color: colorScheme.onPrimary,
                                        strokeWidth: 3.0,
                                      ),
                                    )
                                  : Text(
                                      'VERIFY',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't Receive the OTP ? ",
                              style: TextStyle(
                                color: colorScheme.onSecondary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await resendOTP();
                              },
                              child: Text(
                                "RESEND OTP",
                                style: TextStyle(
                                  color: AppColor.appcolor,
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
