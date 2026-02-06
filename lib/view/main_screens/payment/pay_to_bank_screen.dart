import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/main_screens/homescreen/ad_dialog.dart';
import 'package:fint/view_model/advertisement_vm/advertisement_viewmodel.dart';
import 'package:fint/view_model/razorpay_vm/razorpay_viewmodel.dart';

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
  late final RazorpayViewmodel _razorpayVM;

  @override
  void initState() {
    super.initState();
    _razorpayVM = Provider.of<RazorpayViewmodel>(context, listen: false);

    _razorpayVM.addListener(_paymentListener);
  }

  @override
  void dispose() {
    _razorpayVM.removeListener(_paymentListener);
    _accountController.dispose();
    _ifscController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool _isPaymentDialogVisible = false;

  void _paymentListener() {
    if (!mounted) return;

    if (_razorpayVM.isPaymentProcessing) {
      if (_isPaymentDialogVisible) return;

      _isPaymentDialogVisible = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.6),
        builder: (_) => const PopScope(
          canPop: false,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text(
                    "Processing payment...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      if (_isPaymentDialogVisible &&
          Navigator.of(context, rootNavigator: true).canPop()) {
        _isPaymentDialogVisible = false;
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  Future<void> startPayment(int amount) async {
    final advProvider = Provider.of<AdvertisementViewmodel>(
      context,
      listen: false,
    );
    try {
      if (_accountController.text.trim().isEmpty) {
        ToastHelper.show(
          context,
          "Please enter valid Account number",
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
        return;
      }
      if (_ifscController.text.trim().isEmpty) {
        ToastHelper.show(
          context,
          "Please enter valid IFSC code",
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
        return;
      }

      if (amount <= 0) {
        ToastHelper.show(
          context,
          "Please enter valid amount",
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
        return;
      }

      final payload = {
        "amount": amount,
        "accountHolderName": _nameController.text,
        "bankAccountNumber": _accountController.text,
        "ifscCode": _ifscController.text,
        "accountType": "Savings",
        "module": "P2P_TRANSFER",
        "moduleData": {"note": "Rent share"},
      };

      final result = await _razorpayVM.createOrder(
        context,
        "payToBank",
        payload,
      );
      await advProvider.fetchAds();

      if (result.success) {
        Navigator.pop(context);
        ToastHelper.show(
          context,
          "Payment Successful",
          type: ToastificationType.success,
          duration: Duration(seconds: 3),
        );
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AdDialog(
            imagePath: advProvider.advData.img,
            title: advProvider.advData.title,
            description: advProvider.advData.description,
          ),
        );
      } else {
        ToastHelper.show(
          context,
          result.error ?? "Payment Failed",
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
        debugPrint("Payment Failed: ${result.error}");
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.userFriendlyMessage,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      } else {
        ToastHelper.show(
          context,
          "Something went wrong",
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
      debugPrint('Error: $e');
    }
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
              Row(
                children: [
                  Container(
                    height: 16.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      color: colorscheme.tertiary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Enter Bank A/c Number",
                    style: TextStyle(
                      color: colorscheme.primary,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
              Row(
                children: [
                  Container(
                    height: 16.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      color: colorscheme.tertiary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Enter IFSC Code",
                    style: TextStyle(
                      color: colorscheme.primary,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0.h),

              TextField(
                controller: _ifscController,
                textCapitalization: TextCapitalization.characters,
                decoration: _inputDecoration("IFSC Code", "e.g., SBIN0001234"),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Container(
                    height: 16.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      color: colorscheme.tertiary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Enter A/c holder Name",
                    style: TextStyle(
                      color: colorscheme.primary,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
              Row(
                children: [
                  Container(
                    height: 16.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      color: colorscheme.tertiary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Enter Amount",
                    style: TextStyle(
                      color: colorscheme.primary,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0.h),
              TextField(
                controller: _amountController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _inputDecoration("Amount", "Enter amount in INR"),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await startPayment(
                      int.tryParse(_amountController.text) ?? 0,
                    );
                  },
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
