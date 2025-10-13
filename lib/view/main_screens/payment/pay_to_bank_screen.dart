import 'package:fint/core/constants/exports.dart';

class PayToBankScreen extends StatefulWidget {
  const PayToBankScreen({super.key});

  @override
  State<PayToBankScreen> createState() => _PayToBankScreenState();
}

class _PayToBankScreenState extends State<PayToBankScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool _isProcessing = false;

  Future<void> _launchPhonePeToBank() async {
    final account = _accountController.text.trim();
    final ifsc = _ifscController.text.trim();
    final name = _nameController.text.trim();
    final amount = _amountController.text.trim();

    if (account.isEmpty || ifsc.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final upiId = "$account@$ifsc";
    final txnNote = Uri.encodeComponent("Bank Transfer to $name");
    final callbackUrl = 'com.fint.app://upi-response';

    final urlString =
        "upi://pay?pa=$upiId&pn=${Uri.encodeComponent(name.isEmpty ? 'Receiver' : name)}"
        "&am=$amount&cu=INR&tn=$txnNote&url=$callbackUrl";

    final Uri uri = Uri.parse(urlString);

    if (await canLaunchUrl(uri)) {
      setState(() => _isProcessing = true);
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to open PhonePe: $e")));
      } finally {
        setState(() => _isProcessing = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PhonePe or UPI app not found")),
      );
    }
  }

  @override
  void dispose() {
    _accountController.dispose();
    _ifscController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, String hint) {
    final colorscheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hint,
      filled: true,
      hintStyle: TextStyle(
        color: colorscheme.primary,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12).r),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorscheme.primary),
        borderRadius: BorderRadius.circular(12).r,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorscheme.tertiary, width: 2),
        borderRadius: BorderRadius.circular(12).r,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay to Bank Account",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                " Enter Bank A/c Number",
                style: TextStyle(
                  color: colorscheme.primary,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0.h),
              TextField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  "Account Number",
                  "Enter bank account number",
                ),
              ),

              SizedBox(height: 16.h),
              Text(
                " Enter IFSC Code",
                style: TextStyle(
                  color: colorscheme.primary,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0.h),

              TextField(
                controller: _ifscController,
                textCapitalization: TextCapitalization.characters,
                decoration: _inputDecoration("IFSC Code", "e.g., SBIN0001234"),
              ),
              SizedBox(height: 16.h),
              Text(
                " Enter A/c holder Name",
                style: TextStyle(
                  color: colorscheme.primary,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0.h),
              TextField(
                controller: _nameController,
                decoration: _inputDecoration(
                  "Account Holder Name",
                  "Optional, but recommended",
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                " Enter Amount",
                style: TextStyle(
                  color: colorscheme.primary,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0.h),
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _inputDecoration("Amount", "Enter amount in INR"),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: _isProcessing
                    ? Center(
                        child: CircularProgressIndicator(
                          color: colorscheme.primaryContainer,
                          strokeWidth: 2.0,
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: _launchPhonePeToBank,
                        icon: const Icon(Icons.account_balance),
                        label: Text(
                          "Pay to Bank",
                          style: TextStyle(color: colorscheme.primaryContainer),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorscheme.tertiary,
                          foregroundColor: colorscheme.primaryContainer,
                          textStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12).r,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
