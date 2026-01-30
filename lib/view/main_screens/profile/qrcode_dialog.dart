import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/bankaccounts_vm/bankaccounts_viewmodel.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrcodeDialog extends StatelessWidget {
  final String qrData;

  const QrcodeDialog({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10).r),
      insetPadding: EdgeInsets.all(30).r,
      child: Consumer<BankaccountsViewmodel>(
        builder: (context, bankvm, _) {
          final hasBank = bankvm.allBankAccounts.isNotEmpty;
          final bank = hasBank ? bankvm.allBankAccounts.first.bankName : '';
          final accountNumber = hasBank
              ? bankvm.allBankAccounts.first.bankAccountNumber
              : '';

          final last4 = accountNumber.length >= 4
              ? accountNumber.substring(accountNumber.length - 4)
              : accountNumber;

          return Container(
            height: height * 0.5,
            padding: EdgeInsets.all(20).r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16).r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$bank.... - $last4",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.tertiary,
                  ),
                ),

                SizedBox(height: 10.h),
                PrettyQrView.data(
                  data: qrData,
                  decoration: const PrettyQrDecoration(
                    background: Colors.white,
                    quietZone: PrettyQrQuietZone.standart,
                    image: PrettyQrDecorationImage(
                      image: AssetImage('assets/images/appicon_final.png'),
                    ),
                  ),
                ),

                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
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
