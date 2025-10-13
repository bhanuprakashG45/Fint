import 'package:fint/core/constants/exports.dart';

class BankAccountsScreen extends StatefulWidget {
  const BankAccountsScreen({super.key});

  @override
  State<BankAccountsScreen> createState() => _BankAccountsScreenState();
}

class _BankAccountsScreenState extends State<BankAccountsScreen> {
  List<Map<String, String>> bankAccounts = [
    {
      "bankName": "Bhanuprakash G",
      "accountNumber": "1234 5678 1234",
      "icon": "assets/icons/visa.png",
      "bank": "assets/icons/sbilogo.png",
    },
    {
      "bankName": "Sumukh Mohan",
      "accountNumber": "1234 5678 1234",
      "icon": "assets/icons/mastercard.png",
      "bank": "assets/icons/kotaklogo.png",
    },
    {
      "bankName": "Bal Sangram",
      "accountNumber": "1234 5678 1234",
      "icon": "assets/icons/rupay.png",
      "bank": "assets/icons/hdfclogo.png",
    },
  ];

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
        centerTitle: true,
        surfaceTintColor: colorScheme.tertiary,
        backgroundColor: colorScheme.tertiary,
        foregroundColor: colorScheme.onPrimary,
      ),
      backgroundColor: colorScheme.onSecondaryContainer,
      body: SafeArea(
        top: false,
        child: ListView.builder(
          itemCount: bankAccounts.length,
          padding: EdgeInsets.all(10).r,
          itemBuilder: (context, index) {
            final bank = bankAccounts[index];
            final isSelected = selectedCardIndex == index;

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
                  border: isSelected
                      ? Border.all(color: Colors.green, width: 3)
                      : null,
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
                          bank["bankName"]!,
                          style: TextStyle(
                            color: AppColor.secondaryBrown,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(flex: 9),
                        Image.asset(bank["icon"]!, height: 20.h),

                        PopupMenuButton<String>(
                          padding: EdgeInsets.all(0).r,
                          icon: Icon(
                            Icons.more_vert,
                            color: colorScheme.onPrimary,
                          ),
                          onSelected: (value) {
                            if (value == 'remove') {
                              setState(() {
                                bankAccounts.removeAt(index);
                                if (selectedCardIndex == index) {
                                  selectedCardIndex = -1;
                                } else if (selectedCardIndex > index) {
                                  selectedCardIndex -= 1;
                                }
                              });
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'remove',
                              child: Text(
                                'Remove Card',
                                style: TextStyle(
                                  color: colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
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
                        Image.asset(bank["bank"]!, height: 35.h),
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
                          bank["accountNumber"]!,
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
        ),
      ),
    );
  }
}
