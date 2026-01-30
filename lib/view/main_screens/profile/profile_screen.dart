import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/main_screens/profile/qrcode_dialog.dart';
import 'package:fint/view_model/bankaccounts_vm/bankaccounts_viewmodel.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewmodel>().fetchProfileDetails(context);
    });
  }

  Future<void> _launchUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> _launchEmail({
    required String toEmail,
    String? subject,
    String? body,
  }) async {
    final uri = Uri.parse(
      'mailto:$toEmail'
      '?subject=${Uri.encodeComponent(subject ?? '')}'
      '&body=${Uri.encodeComponent(body ?? '')}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _makePhoneCall(String phone) async {
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final logoutVm = context.read<LogoutViewmodel>();
    final profileProvider = context.read<ProfileViewmodel>();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: cs.tertiary,
        backgroundColor: cs.tertiary,
        foregroundColor: cs.onPrimary,
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => UpdateProfileDialog(
                  currentName: profileProvider.profileData.name,
                  currentPincode: profileProvider.profileData.pinCode,
                ),
              );
            },
            child: profileProvider.isFetchingProfile
                ? SizedBox()
                : Icon(Icons.edit),
          ),
          SizedBox(width: 20.w),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              final profileprovider = Provider.of<ProfileViewmodel>(
                context,
                listen: false,
              );
              final userId = profileprovider.profileData.id;
              final userName = profileprovider.profileData.name;
              final qrData = jsonEncode({
                "userId": userId,
                "userName": userName,
              });

              showDialog(
                context: context,
                builder: (_) => QrcodeDialog(qrData: qrData),
              );
            },
            child: Icon(Icons.qr_code),
          ),
          SizedBox(width: 30.w),
        ],
      ),
      body: Consumer2<ProfileViewmodel, BankaccountsViewmodel>(
        builder: (context, profileVm, bankVm, _) {
          final profile = profileVm.profileData;
          final banks = bankVm.allBankAccounts;

          return Skeletonizer(
            enabled:
                profileVm.isFetchingProfile || bankVm.isAllBankAccountsLoading,
            child: Column(
              children: [
                _ProfileHeader(profile: profile),
                banks.isEmpty
                    ? _AddBankAccountCard(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.addbankAccountscreen,
                            arguments: false,
                          );
                        },
                      )
                    : _BankAccountsList(banks: banks),

                // _QrCard(userId: profile.id, userName: profile.name),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 80.h),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: cs.primaryContainer,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10).r,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              ProfileOptionsWidget(
                                leadingIcon: Icons.water_drop_outlined,
                                text: "Be a Donor",
                                trailingWidget: Switch(
                                  value: profile.beADonor,
                                  activeColor: cs.tertiary,
                                  onChanged: (_) async {
                                    await profileVm.updateProfile(
                                      context,
                                      beADonor: !profile.beADonor,
                                    );
                                    await profileVm.fetchProfileDetails(
                                      context,
                                    );
                                  },
                                ),
                              ),
                              ProfileOptionsWidget(
                                leadingIcon: FontAwesomeIcons.fingerprint,
                                text: "Bio Metric & Screen Lock",
                                trailingWidget: Switch(
                                  value: isBiometricEnabled,
                                  activeColor: cs.secondary,
                                  onChanged: (v) =>
                                      setState(() => isBiometricEnabled = v),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              _NavTile(
                                icon: FontAwesomeIcons.shieldHalved,
                                text: "Privacy and Security",
                                onTap: () => _launchUrl(
                                  'https://projectf0724.com/privacy-policy',
                                ),
                              ),
                              SizedBox(height: 15.h),
                              _NavTile(
                                icon: FontAwesomeIcons.phone,
                                text: "Contact Us",
                                onTap: () => _makePhoneCall("8147441592"),
                              ),
                              SizedBox(height: 15.h),
                              _NavTile(
                                icon: Icons.help_center_outlined,
                                text: "Help Center",
                                onTap: () => _launchEmail(
                                  toEmail: 'projectf0724@gmail.com',
                                  subject: 'Help Required',
                                  body: 'Hello, I need assistance with...',
                                ),
                              ),
                              SizedBox(height: 80.h),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 10.w,
                        right: 10.w,
                        child: _LogoutButton(
                          onLogout: () async {
                            final result = await logoutVm.userLogout(context);
                            if (result == true) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesName.loginscreen,
                                (_) => false,
                              );
                            }
                          },
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
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.22,
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.tertiary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ).r,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10).r,
            child: Image.asset(
              'assets/images/profile.jpg',
              height: 90.h,
              width: 90.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Text(
                  profile.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: cs.primaryContainer,
                  ),
                ),
                Text(
                  "+91-${profile.phoneNumber}",
                  style: TextStyle(color: cs.secondaryContainer),
                ),
                Text(
                  " ${profile.pinCode}",
                  style: TextStyle(color: cs.secondaryContainer),
                ),
                // SizedBox(height: 10.h)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BankAccountsList extends StatelessWidget {
  final List banks;
  const _BankAccountsList({required this.banks});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bankVm = context.read<BankaccountsViewmodel>();

    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10).r,
        itemCount: banks.length,
        itemBuilder: (_, i) {
          final bank = banks[i];

          return Container(
            height: 210.h,
            margin: EdgeInsets.only(bottom: 16.h),
            padding: const EdgeInsets.all(10).r,
            decoration: BoxDecoration(
              color: cs.tertiary,
              borderRadius: BorderRadius.circular(10).r,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      bank.accountHolderName,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: cs.onPrimary,
                      ),
                    ),
                    const Spacer(),
                    bank.isActive
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ).r,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                'PRIMARY',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : PopupMenuButton<String>(
                            padding: EdgeInsets.zero,
                            color: Colors.black.withValues(alpha: 0.5),
                            icon: Icon(Icons.more_vert, color: cs.onPrimary),
                            onSelected: (value) {
                              if (value == 'primary') {
                                bankVm.updateBankAccount(context, bank.id);
                              } else if (value == 'delete') {
                                bankVm.deleteBankAccount(context, bank.id);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'primary',
                                child: Row(
                                  children: [
                                    Icon(Icons.push_pin, color: Colors.green),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'Make Primary',
                                      style: TextStyle(
                                        color: cs.primaryContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'Delete Bank',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    'assets/images/bankcard_logo.png',
                    height: 100.h,
                  ),
                ),
                Spacer(),
                Text(
                  bank.bankAccountNumber,
                  style: TextStyle(
                    fontSize: 25.sp,
                    letterSpacing: 4,
                    color: cs.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class _QrCard extends StatelessWidget {
//   final String userId;
//   final String userName;

//   const _QrCard({required this.userId, required this.userName});
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final qrData = jsonEncode({"userId": userId, "userName": userName});

//     return InkWell(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (_) => QrcodeDialog(qrData: qrData),
//         );
//       },
//       child: Container(
//         width: 180.w,
//         margin: EdgeInsets.all(10).r,
//         padding: EdgeInsets.all(10).r,
//         decoration: BoxDecoration(
//           color: cs.secondaryContainer,
//           borderRadius: BorderRadius.circular(10).r,
//         ),
//         child: Column(
//           children: [
//             Icon(Icons.qr_code, size: 100.sp),
//             Text(
//               "Tap to View",
//               style: TextStyle(color: cs.tertiary, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _NavTile({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ProfileOptionsWidget(
        leadingIcon: icon,
        text: text,
        trailingIcon: Icons.arrow_forward_ios,
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;
  const _LogoutButton({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: SizedBox(
        height: 50.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cs.tertiary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10).r,
            ),
          ),
          onPressed: onLogout,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: cs.onPrimary),
              SizedBox(width: 10.w),
              Text(
                "Log out",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddBankAccountCard extends StatelessWidget {
  final VoidCallback onTap;

  const _AddBankAccountCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(10).r,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10).r,
        child: Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: cs.tertiary,
            boxShadow: [
              BoxShadow(
                color: cs.tertiary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.onPrimary.withValues(alpha: 0.15),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 36.sp,
                  color: cs.onPrimary,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                "Add Bank Account",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimary,
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                "Link your bank to receive payments",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: cs.onPrimary.withValues(alpha: 0.85),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
