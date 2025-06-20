import 'package:fint/core/utils/widgets/pet_insurance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PetInsuranceScreen extends StatefulWidget {
  const PetInsuranceScreen({super.key});

  @override
  State<PetInsuranceScreen> createState() => _PetInsuranceScreenState();
}

class _PetInsuranceScreenState extends State<PetInsuranceScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();
  final parentAgeController = TextEditingController();

  bool isPetDetails = false;

  final petNameController = TextEditingController();
  final petBreedController = TextEditingController();
  final petAgeController = TextEditingController();
  final petAddressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pet Owner info",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        surfaceTintColor: colorScheme.surfaceTint,
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0.h),
                  PetownerInputField(
                    controller: fullNameController,
                    keyboardType: TextInputType.name,
                    hintText: "Full Name",
                    prefixIcon: Icons.person_outline,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email Address",
                    prefixIcon: Icons.email_outlined,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Password",
                    prefixIcon: Icons.lock_outline,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Confirm Password",
                    prefixIcon: Icons.lock_outline,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    hintText: "Phone Number",
                    prefixIcon: Icons.phone_outlined,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,

                    hintText: "Address",
                    prefixIcon: Icons.home_outlined,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    hintText: "PinCode",
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: parentAgeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    hintText: "Pet Parent Age",
                    prefixIcon: Icons.calendar_month_outlined,
                  ),
                  SizedBox(height: 10.0.h),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary,
                        ),
                        onPressed: () {
                          setState(() {
                            isPetDetails = true;
                          });
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  isPetDetails
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Pet Details",
                              style: TextStyle(
                                fontSize: 20.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0.h),
                          PetInputField(
                            controller: petNameController,
                            hintText: "Pet Name",
                          ),
                          SizedBox(height: 10.0.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 15.0.w),
                              Text(
                                "Pet Breed",
                                style: TextStyle(
                                  fontSize: 17.0.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0.w),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: petBreedController,
                                  decoration: InputDecoration(
                                    hint: Text(
                                      "Ex: Husky",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 8.0,
                                        ).r,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0).r,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0).r,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0).r,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.0.w),
                            ],
                          ),
                          SizedBox(height: 10.0.h),
                          PetInputField(
                            controller: petAgeController,
                            hintText: "Pet Age",
                          ),
                          SizedBox(height: 10.0.h),
                          PetInputField(
                            controller: petAddressController,
                            hintText: "Pet Address",
                          ),
                          SizedBox(height: 10.0.h),
                          Text(
                            "    Upload a Photo of your Pet's nose print",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 10).r,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.secondary,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Upload Nose Print",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0.h),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: SizedBox(
                              width: screenWidth * 0.8,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
