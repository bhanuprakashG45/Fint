import 'package:fint/core/constants/exports.dart';

class PayToSelfScreen extends StatefulWidget {
  const PayToSelfScreen({super.key});

  @override
  State<PayToSelfScreen> createState() => _PayToSelfScreenState();
}

class _PayToSelfScreenState extends State<PayToSelfScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _isProcessing = false;

  final String _selfUpiId = 'yourname@upi';

  Future<void> _launchSelfPayment() async {
    final amount = _amountController.text.trim();

    if (amount.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter amount")));
      return;
    }

    final txnNote = Uri.encodeComponent("Payment to Self");
    final callbackurl = 'com.fint.app://upi-response';
    final urlString =
        "upi://pay?pa=$_selfUpiId&pn=Myself&am=$amount&cu=INR&tn=$txnNote&url=$callbackurl";
    final Uri uri = Uri.parse(urlString);

    if (await canLaunchUrl(uri)) {
      setState(() => _isProcessing = true);

      try {
        final response = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        print("Transaction response :$response");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not launch payment app: $e")),
        );
        print("Transaction Failed: $e");
      } finally {
        setState(() => _isProcessing = false);
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("UPI app not found")));
    }
  }

  @override
  void dispose() {
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
          "Pay to Self",
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
              const SizedBox(height: 30),
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
                        onPressed: _launchSelfPayment,
                        icon: const Icon(Icons.account_balance_wallet),
                        label: Text(
                          "Pay to Self",
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
