import 'dart:async';

import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/main_screens/homescreen/ad_dialog.dart';
import 'package:fint/view/payment/expensetractor.dart';
import 'package:fint/view_model/advertisement_vm/advertisement_viewmodel.dart';
import 'package:fint/view_model/expense_tracker_vm/expensetracker_viewmodel.dart';
import 'package:fint/view_model/razorpay_vm/razorpay_viewmodel.dart';

class PayToNumberScreen extends StatefulWidget {
  const PayToNumberScreen({super.key});

  @override
  State<PayToNumberScreen> createState() => _PayToNumberScreenState();
}

class _PayToNumberScreenState extends State<PayToNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  late final RazorpayViewmodel _razorpayVM;

  String? selectedExpenseId;
  String? note;

  @override
  void initState() {
    super.initState();
    _razorpayVM = Provider.of<RazorpayViewmodel>(context, listen: false);
    _razorpayVM.addListener(_paymentListener);
  }

  @override
  void dispose() {
    _razorpayVM.removeListener(_paymentListener);
    _amountController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  Timer? _debounce;

  void _onNoteChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final expenseVM = Provider.of<ExpensetrackerViewmodel>(
        context,
        listen: false,
      );
      expenseVM.updatePhone(value);
    });
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

  Future<void> startPayment(String phone, int amount) async {
    final advProvider = Provider.of<AdvertisementViewmodel>(
      context,
      listen: false,
    );
    try {
      if (phone.isEmpty || phone.length < 10) {
        ToastHelper.show(
          context,
          "Please enter valid phone number",
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
        "phoneNumber": phone,
        "expenseId": selectedExpenseId,
        "module": "P2P_TRANSFER",
        "moduleData": {"note": note},
      };

      final result = await _razorpayVM.createOrder(
        context,
        "payToNumber",
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
          result.error.toString().isNotEmpty
              ? result.error.toString()
              : "Payment Failed",
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
          duration: Duration(seconds: 3),
        );
        debugPrint('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay to Number",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.primaryContainer,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: Consumer<RazorpayViewmodel>(
        builder: (context, razorpayvm, _) {
          return FloatingActionButton(
            backgroundColor: colorscheme.tertiary,
            onPressed: razorpayvm.isPaymentProcessing
                ? null
                : () {
                    startPayment(
                      _phoneController.text,
                      int.tryParse(_amountController.text) ?? 0,
                    );
                  },
            child: razorpayvm.isPaymentProcessing
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: colorscheme.onPrimary,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    Icons.arrow_forward,
                    color: colorscheme.onPrimary,
                    size: 28,
                  ),
          );
        },
      ),
      body: SafeArea(
        top: false,
        child: Consumer<ExpensetrackerViewmodel>(
          builder: (context, expensevm, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(15).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 5.w,
                        decoration: BoxDecoration(
                          color: colorscheme.tertiary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Phone Number",
                        style: TextStyle(
                          color: colorscheme.primary,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0.h),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorscheme.tertiary,
                        width: 0.5,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 2.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: Colors.grey.withValues(alpha: 0.1),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                'https://tse4.mm.bing.net/th/id/OIP.3cv7kHxG_V0AvYNc8bUg9wHaE8?pid=Api&P=0&h=180',
                                width: 24.w,
                                height: 16.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "+91",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colorscheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (value) {
                              _onNoteChanged(value);
                            },
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: colorscheme.tertiary,
                              letterSpacing: 1.2,
                            ),
                            cursorColor: colorscheme.tertiary,
                            decoration: InputDecoration(
                              hintText: "Enter Phone Number",
                              hintStyle: TextStyle(
                                color: colorscheme.onSecondary.withValues(
                                  alpha: 0.5,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  expensevm.isPhoneValid
                      ? ExpenseBridgeWithInput(
                          key: const ValueKey("expense"),
                          categories: expensevm.expenseTrackerData,
                          onSelected: (id) {
                            selectedExpenseId = id;
                          },
                          onDataChanged: (data) {
                            selectedExpenseId = data.expenseId;
                            _amountController.text = data.amount;
                            note = data.note;
                          },
                        )
                      : Padding(
                          key: const ValueKey("hint"),
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text(
                              "Enter 10-digit mobile number to continue",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: colorscheme.tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
}


 // Text(
                  //   " Enter Amount",
                  //   style: TextStyle(
                  //     color: colorscheme.primary,
                  //     fontSize: 16.0.sp,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 5.0.h),
                  // TextField(
                  //   controller: _amountController,
                  //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  //   keyboardType: const TextInputType.numberWithOptions(
                  //     decimal: true,
                  //   ),
                  //   decoration: _inputDecoration(
                  //     "Amount",
                  //     "Enter amount in INR",
                  //   ),
                  // ),
                  // const SizedBox(height: 30),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //     onPressed: () async {
                  //       await startPayment(
                  //         _phoneController.text,
                  //         int.parse(_amountController.text),
                  //       );
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: colorscheme.tertiary,
                  //       foregroundColor: colorscheme.primaryContainer,
                  //       textStyle: TextStyle(
                  //         fontSize: 18.sp,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12).r,
                  //       ),
                  //     ),
                  //     child: Text(
                  //       "Proceed to Pay",
                  //       style: TextStyle(color: colorscheme.primaryContainer),
                  //     ),
                  //   ),
                  // ),