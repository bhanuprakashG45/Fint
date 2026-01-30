import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/bankaccounts_vm/bankaccounts_viewmodel.dart';

class BankAccountsScreen extends StatefulWidget {
  const BankAccountsScreen({super.key});

  @override
  State<BankAccountsScreen> createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {});
  }

  int selectedCardIndex = -1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Bank Accounts",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: InkWell(
        //       onTap: () {
        //         Navigator.pushNamed(
        //           context,
        //           RoutesName.addbankAccountscreen,
        //           arguments: false,
        //         );
        //       },
        //       child: FaIcon(FontAwesomeIcons.plus),
        //     ),
        //   ),
        // ],
        centerTitle: true,
        surfaceTintColor: colorScheme.tertiary,
        backgroundColor: colorScheme.tertiary,
        foregroundColor: colorScheme.onPrimary,
      ),
      backgroundColor: colorScheme.onSecondaryContainer,
      body: SafeArea(
        top: false,
        child: Consumer<BankaccountsViewmodel>(
          builder: (context, provider, _) {
            final bankaccounts = provider.allBankAccounts;
            return ListView.builder(
              itemCount: bankaccounts.length,
              padding: EdgeInsets.all(10).r,
              itemBuilder: (context, index) {
                final bank = bankaccounts[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCardIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: 0,
                      left: 10,
                    ).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: colorScheme.tertiary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
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
                                color: AppColor.secondaryBrown,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(flex: 9),

                            // Image.asset(bank["icon"]!, height: 20.h),
                            bank.isActive
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ).r,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
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
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: colorScheme.onPrimary,
                                    ),
                                    onSelected: (value) {
                                      if (value == 'primary') {
                                        provider.updateBankAccount(
                                          context,
                                          bank.id,
                                        );
                                      } else if (value == 'delete') {
                                        provider.deleteBankAccount(
                                          context,
                                          bank.id,
                                        );
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 'primary',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.push_pin,
                                              color: Colors.green,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              'Make Primary',
                                              style: TextStyle(
                                                color: colorScheme
                                                    .primaryContainer,
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
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
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

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(bank["bank"]!, height: 35.h),
                            Spacer(),
                            Center(
                              child: Image.asset(
                                'assets/images/bankcard_logo.png',
                                height: 80.0.h,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              bank.bankAccountNumber,
                              style: TextStyle(
                                color: AppColor.secondaryBrown,
                                fontSize: 25.sp,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
