import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/bankaccounts_vm/bankaccounts_viewmodel.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class MyqrScreen extends StatelessWidget {
  final String userId;
  final String userName;

  const MyqrScreen({super.key, required this.userId, required this.userName});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    final qrData = jsonEncode({"userId": userId, "userName": userName});
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My QR Code",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.onPrimary,
      ),
      body: Consumer<BankaccountsViewmodel>(
        builder: (context, bankvm, _) {
          final bank = bankvm.allBankAccounts.isNotEmpty
              ? bankvm.allBankAccounts[0].bankId.bankName
              : '';
          final accountNumber = bankvm.allBankAccounts.isNotEmpty
              ? bankvm.allBankAccounts[0].bankAccountNumber
              : '';

          final last4 = accountNumber.length >= 4
              ? accountNumber.substring(accountNumber.length - 4)
              : accountNumber;
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20).r,
            child: Container(
              height: height * 0.5,
              padding: EdgeInsets.all(40).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12).r,
                color: Colors.white,
                border: Border.all(width: 2, color: Color(0xFFE6E6E6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${bank}.... - $last4",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: colorscheme.tertiary,
                    ),
                  ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
