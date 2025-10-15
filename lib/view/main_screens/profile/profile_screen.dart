import 'package:fint/core/constants/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final profileprovider = Provider.of<ProfileViewmodel>(
        context,
        listen: false,
      );
      await profileprovider.fetchProfileDetails(context);
    });
  }

  Future<void> launchAppUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    // final profileprovider = Provider.of<ProfileViewmodel>(
    //   context,
    //   listen: false,
    // );
    final logoutprovider = Provider.of<LogoutViewmodel>(context, listen: false);
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer<ProfileViewmodel>(
          builder: (context, profiledetails, child) {
            final profile = profiledetails.profileData;

            return Skeletonizer(
              enabled: profiledetails.isFetchingProfile,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(10).r,
                    decoration: BoxDecoration(color: colorscheme.tertiary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.0.h),
                        SafeArea(
                          top: false,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: colorscheme.onPrimary,
                                    size: 28.sp,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 28.sp,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => UpdateProfileDialog(
                                        currentName: profile.name,

                                        currentPincode: profile.pinCode,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 130.0.h,
                          width: 130.0.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25).r,
                            color: colorscheme.onPrimary,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25).r,
                            child: Image.asset(
                              "assets/images/profile.jpg",
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.error,
                                    size: 30.sp,
                                    color: AppColor.danger,
                                  ),
                            ),
                          ),
                        ),
                        Text(
                          profile.name,
                          style: TextStyle(
                            color: colorscheme.primaryContainer,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        _profileInfo(colorscheme, "UPI ID : abcd123@ybl"),
                        _profileInfo(
                          colorscheme,
                          "Pin code : ${profile.pinCode}",
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 40.h),
                          child: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20).r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20).r,
                                  topRight: Radius.circular(20).r,
                                ),
                                color: colorscheme.primaryContainer,
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RoutesName.bankaccountsscreen,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14.h,
                                        horizontal: 16.w,
                                      ),
                                      margin: EdgeInsets.only(bottom: 15.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        color: colorscheme.secondaryContainer,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40.h,
                                            width: 40.h,
                                            decoration: BoxDecoration(
                                              color: colorscheme.tertiary,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .buildingColumns,
                                                color: colorscheme.onPrimary,
                                                size: 18.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Text(
                                            "Bank Accounts",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16.sp,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  ProfileOptionsWidget(
                                    leadingIcon: Icons.water_drop_outlined,
                                    text: "Be a Donor",
                                    trailingWidget: Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        activeColor: colorscheme.tertiary,
                                        inactiveThumbColor:
                                            colorscheme.onSecondary,
                                        inactiveTrackColor:
                                            colorscheme.onSecondaryContainer,
                                        value: profile.beADonor,
                                        onChanged: (value) async {
                                          await profiledetails.updateProfile(
                                            context,
                                            beADonor: !profile.beADonor,
                                          );
                                          await profiledetails
                                              .fetchProfileDetails(context);
                                        },
                                      ),
                                    ),
                                  ),
                                  ProfileOptionsWidget(
                                    leadingIcon: FontAwesomeIcons.fingerprint,
                                    text: "Bio Metric & Screen Lock",
                                    trailingWidget: Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        activeColor: colorscheme.secondary,
                                        inactiveThumbColor:
                                            colorscheme.onSecondary,
                                        inactiveTrackColor:
                                            colorscheme.onSecondaryContainer,
                                        value: isBiometricEnabled,
                                        onChanged: (value) {
                                          setState(() {
                                            isBiometricEnabled = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.0.h),
                                  ProfileOptionsWidget(
                                    leadingIcon: Icons.key,
                                    text: "Change Password",
                                    trailingIcon: Icons.arrow_forward_ios,
                                  ),
                                  SizedBox(height: 15.0.h),
                                  InkWell(
                                    onTap: () {
                                      launchAppUrl(
                                        'https://projectf0724.com/privacy-policy',
                                      );
                                    },
                                    child: ProfileOptionsWidget(
                                      leadingIcon:
                                          FontAwesomeIcons.shieldHalved,
                                      text: "Privacy and Security",
                                      trailingIcon: Icons.arrow_forward_ios,
                                    ),
                                  ),
                                  SizedBox(height: 15.0.h),
                                  InkWell(
                                    onTap: () async {
                                      await _makePhoneCall("9631445521");
                                    },
                                    child: ProfileOptionsWidget(
                                      leadingIcon: FontAwesomeIcons.phone,
                                      text: "Contact Us",
                                      trailingIcon: Icons.arrow_forward_ios,
                                    ),
                                  ),
                                  SizedBox(height: 15.0.h),
                                  ProfileOptionsWidget(
                                    leadingIcon: Icons.help_center_outlined,
                                    text: "Help Center",
                                    trailingIcon: Icons.arrow_forward_ios,
                                  ),
                                  SizedBox(height: 15.0.h),
                                  ProfileOptionsWidget(
                                    leadingIcon: Icons.info_outline,
                                    text: "About Fint",
                                    trailingIcon: Icons.arrow_forward_ios,
                                  ),
                                  SizedBox(height: 20.0.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10.h,
                          left: 20.w,
                          right: 20.w,
                          child: SizedBox(
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorscheme.tertiary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12).r,
                                ),
                              ),
                              onPressed: () async {
                                final result = await logoutprovider.userLogout(
                                  context,
                                );
                                if (result == true) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutesName.loginscreen,
                                    (route) => false,
                                  );
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: colorscheme.onPrimary,
                                    weight: 30.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Log out",
                                    style: TextStyle(
                                      color: colorscheme.onPrimary,
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _profileInfo(ColorScheme colorscheme, String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
        color: colorscheme.onPrimary,
      ),
      // textAlign: TextAlign.start,
    );
  }
}
