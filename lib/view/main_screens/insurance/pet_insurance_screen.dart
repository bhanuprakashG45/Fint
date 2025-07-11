import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/insurance_viewmodel/pet_insurance_viewmodel.dart';

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
  bool isPetDetailsRegistering = false;

  final petNameController = TextEditingController();
  final petBreedController = TextEditingController();
  final petAgeController = TextEditingController();
  final petAddressController = TextEditingController();

  Future<void> handlePetOwnerInfo() async {
    if (fullNameController.text.trim().isEmpty ||
        emailController.text.trim().toLowerCase().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        phoneNumberController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        pincodeController.text.trim().isEmpty ||
        parentAgeController.text.trim().isEmpty) {
      setState(() {
        isPetDetailsRegistering = false;
      });
      return ToastHelper.show(
        context,
        "All Owner fields are required",
        type: ToastificationType.warning,
        duration: Duration(seconds: 3),
      );
    } else {
      setState(() {
        isPetDetails = true;
      });
    }
  }

  Future<void> handlePetInfo() async {
    final petInsuranceProvider = Provider.of<PetInsuranceViewmodel>(
      context,
      listen: false,
    );
    setState(() {
      isPetDetailsRegistering = true;
    });
    if (petNameController.text.trim().isEmpty ||
        petBreedController.text.trim().isEmpty ||
        petAgeController.text.trim().isEmpty ||
        petAddressController.text.trim().isEmpty) {
      setState(() {
        isPetDetailsRegistering = false;
      });
      return ToastHelper.show(
        context,
        "All Pet fields are required",
        type: ToastificationType.warning,
        duration: Duration(seconds: 3),
      );
    } else {
      await handlePetOwnerInfo();

      final ownerName = fullNameController.text.trim();
      final ownerEmail = emailController.text.toLowerCase().trim();
      final ownerPassword = passwordController.text.trim();
      final ownerPhoneNumber = phoneNumberController.text.trim();
      final ownerAddress = addressController.text.trim();
      final pincode = pincodeController.text.trim();
      final parentAge = parentAgeController.text.trim();
      final petName = petNameController.text.trim();
      final petBreed = petBreedController.text.trim();
      final petAge = petAgeController.text.trim();
      final petAddress = petAddressController.text.trim();

      if (passwordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        if (passwordController.text.length <= 5) {
          setState(() {
            isPetDetailsRegistering = false;
          });
          return ToastHelper.show(
            context,
            "Password must be at least 6 characters",
            type: ToastificationType.warning,
            duration: Duration(seconds: 3),
          );
        }

        await petInsuranceProvider.applyPetInsurance(
          context,
          ownerName,
          ownerEmail,
          ownerPassword,
          ownerPhoneNumber,
          ownerAddress,
          pincode,
          parentAge,
          petName,
          petBreed,
          petAge,
          petAddress,
        );
        setState(() {
          isPetDetailsRegistering = false;
        });
      } else {
        setState(() {
          isPetDetailsRegistering = false;
        });
      }
    }
  }

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
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    hintText: "Password",
                    prefixIcon: Icons.lock_outline,
                  ),
                  SizedBox(height: 10.0.h),
                  PetownerInputField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
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
                        onPressed: () async {
                          await handlePetOwnerInfo();
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
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 8.0,
                                      ).r,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ).r,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ).r,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ).r,
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
                                  onPressed: () async {
                                    await handlePetInfo();
                                  },
                                  child: isPetDetailsRegistering
                                      ? CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          color: colorScheme.primaryContainer,
                                        )
                                      : Text(
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
