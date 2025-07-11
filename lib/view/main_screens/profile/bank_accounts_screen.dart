import 'package:fint/core/constants/exports.dart';

class BankAccountsScreen extends StatelessWidget {
  const BankAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bankAccounts = [
      {"bankName": "SBI", "accountNumber": "**** 1234"},
      {"bankName": "HDFC", "accountNumber": "**** 5678"},
      {"bankName": "ICICI", "accountNumber": "**** 9012"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Bank Accounts",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bankAccounts.length,
        padding: EdgeInsets.all(16).r,
        itemBuilder: (context, index) {
          final bank = bankAccounts[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: colorScheme.secondaryContainer,
              border: Border.all(color: colorScheme.outline),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance,
                  size: 28.sp,
                  color: colorScheme.secondary,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bank["bankName"]!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Account: ${bank["accountNumber"]}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
