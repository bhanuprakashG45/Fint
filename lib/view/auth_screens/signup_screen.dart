import 'package:fint/core/constants/exports.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final pincodeController = TextEditingController();
  bool isSignUpLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    bloodGroupController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  Future<void> _userSignUp() async {
    setState(() {
      isSignUpLoading = true;
    });
    final signupprovider = Provider.of<SignupViewmodel>(context, listen: false);
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final blood = bloodGroupController.text.toUpperCase().trim();
    final pincode = pincodeController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        blood.isEmpty ||
        pincode.isEmpty) {
      ToastHelper.show(
        context,
        "All Fields are Required",
        type: ToastificationType.info,
        duration: Duration(seconds: 5),
      );
      setState(() {
        isSignUpLoading = false;
      });
    } else {
      await signupprovider.signup(name, phone, email, blood, pincode, context);
      signupprovider.isSignupLoading
          ? setState(() {
              isSignUpLoading = true;
            })
          : setState(() {
              isSignUpLoading = false;
            });
      // if (success) {
      //   ToastHelper.show(
      //     context,
      //     "SignUp successfully",
      //     type: ToastificationType.success,
      //     duration: Duration(seconds: 5),
      //   );
      //   Navigator.pushNamed(context, RoutesName.loginscreen);
      // } else {
      //   ToastHelper.show(
      //     context,
      //     "SignUp Failed",
      //     type: ToastificationType.error,
      //     duration: Duration(seconds: 5),
      //   );
      //   setState(() {
      //     isSignUpLoading = false;
      //   });
      // }
    }
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
                      clipper: WaveClipperOne(),
                      child: Container(
                        height: 140.h,
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
                                    color: Colors.white,
                                    size: 28.sp,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: colorScheme.primaryContainer,
                                    fontSize: 28.sp,
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
                    children: [
                      Text(
                        'SIGN UP TO CONTINUE',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("NAME"),
                      _buildInputField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(height: 10.h),
                      _buildLabel("PHONE NUMBER"),
                      _buildInputField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      _buildLabel("EMAIL ID"),
                      _buildInputField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 10.h),
                      _buildLabel("BLOOD GROUP"),
                      _buildInputField(controller: bloodGroupController),

                      SizedBox(height: 10.h),
                      _buildLabel("PINCODE"),
                      _buildInputField(
                        controller: pincodeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20.0.h),

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
                            borderRadius: BorderRadius.circular(10.0).r,
                          ),
                        ),
                        onPressed: () {
                          _userSignUp();
                        },
                        child: isSignUpLoading
                            ? SizedBox(
                                height: 20.0.h,
                                width: 20.0.w,
                                child: CircularProgressIndicator(
                                  color: colorScheme.onPrimary,
                                  strokeWidth: 3.0,
                                ),
                              )
                            : Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
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
                    text: "Already Have an account? ",
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      color: colorScheme.primaryContainer,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                              context,
                              RoutesName.loginscreen,
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

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15).r,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14.0.sp,
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget _buildInputField({
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15).r,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0).r,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0).r,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0).r,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    ),
  );
}
