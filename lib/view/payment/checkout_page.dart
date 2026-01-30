import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/main_screens/homescreen/ad_dialog.dart';
import 'package:fint/view/payment/expensetractor.dart';
import 'package:fint/view_model/advertisement_vm/advertisement_viewmodel.dart';
import 'package:fint/view_model/expense_tracker_vm/expensetracker_viewmodel.dart';
import 'package:fint/view_model/razorpay_vm/razorpay_viewmodel.dart';

class CheckoutPage extends StatefulWidget {
  final String userId;
  final String userName;

  const CheckoutPage({super.key, required this.userId, required this.userName});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String? selectedExpenseId;
  String? note;

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
    final advprovider = Provider.of<AdvertisementViewmodel>(
      context,
      listen: false,
    );
    try {
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
        "receiverId": widget.userId,
        "module": "P2P_TRANSFER",
        "expenseId": selectedExpenseId,
        "moduleData": {"note": "$note"},
      };

      debugPrint("PayLoad : $payload");

      final result = await _razorpayVM.createOrder(context, "qr", payload);
      await advprovider.fetchAds();

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
            imagePath: advprovider.advData.img,
            title: advprovider.advData.title,
            description: advprovider.advData.description,
          ),
        );
      } else {
        ToastHelper.show(
          context,
          "Payment Failed",
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
        debugPrint("Payment Failed: ${result.error}");
      }
    } catch (e) {
      ToastHelper.show(
        context,
        "Something went wrong",
        type: ToastificationType.error,
        duration: Duration(seconds: 3),
      );
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Page",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.tertiary,
        foregroundColor: colorScheme.onPrimary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: Consumer<RazorpayViewmodel>(
        builder: (context, razorpayvm, _) {
          return FloatingActionButton(
            backgroundColor: colorScheme.tertiary,
            onPressed: razorpayvm.isPaymentProcessing
                ? null
                : () {
                    startPayment(int.tryParse(_amountController.text) ?? 0);
                  },
            child: razorpayvm.isPaymentProcessing
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: colorScheme.onPrimary,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    Icons.arrow_forward,
                    color: colorScheme.onPrimary,
                    size: 28,
                  ),
          );
        },
      ),
      body: Consumer2<RazorpayViewmodel, ExpensetrackerViewmodel>(
        builder: (context, razorpayvm, expenseTrackervm, _) {
          return Padding(
            padding: const EdgeInsets.all(16).r,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10).r,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12).r,
                            border: Border.all(color: Colors.grey, width: 0.5),
                            color: colorScheme.onPrimary,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10).r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100).r,
                                  border: Border.all(
                                    color: Colors.grey.shade700,
                                    width: 0.1,
                                  ),
                                  color: colorScheme.onPrimary,
                                ),
                                child: Icon(Icons.person),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  "${widget.userName.toUpperCase()}",
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Choose the Facility for Which to Pay for",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        ExpenseBridgeWithInput(
                          categories: expenseTrackervm.expenseTrackerData,
                          onSelected: (id) {
                            selectedExpenseId = id;
                          },
                          onDataChanged: (data) {
                            selectedExpenseId = data.expenseId;
                            _amountController.text = data.amount;
                            note = data.note;
                          },
                        ),
                      ],
                    ),

                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     minimumSize: Size(double.infinity, 50.h),
                    //     backgroundColor: colorScheme.tertiary,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10.0).r,
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     startPayment(int.tryParse(_amountController.text) ?? 0);
                    //   },
                    //   child: razorpayvm.isPaymentProcessing
                    //       ? CircularProgressIndicator(
                    //           color: colorScheme.onPrimary,
                    //           strokeWidth: 2,
                    //         )
                    //       : Text(
                    //           "PROCEED TO PAY",
                    //           style: TextStyle(
                    //             color: colorScheme.onPrimary,
                    //             fontSize: 16.sp,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


 // SizedBox(height: 20.h),

                    // Text(
                    //   "Enter Transfer Amount",
                    //   style: TextStyle(
                    //     fontSize: 18.sp,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // SizedBox(height: 5.h),
                    // TextFormField(
                    //   controller: _amountController,
                    //   keyboardType: TextInputType.number,
                    //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    //   validator: (val) {
                    //     if (val == null || val.trim().isEmpty) {
                    //       return 'Please enter an amount';
                    //     }
                    //     if (int.tryParse(val.trim()) == null) {
                    //       return 'Enter a valid number';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(
                    //       Icons.currency_rupee,
                    //       color: colorScheme.tertiary,
                    //     ),
                    //     hintText: "Enter Amount",
                    //     hintStyle: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: colorScheme.onSecondary,
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10).r,
                    //       borderSide: const BorderSide(
                    //         color: Colors.grey,
                    //         width: 0.5,
                    //       ),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10).r,
                    //       borderSide: BorderSide(
                    //         color: colorScheme.tertiary,
                    //         width: 1.5,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 15.h),
                    // // Text(
                    // //   "Enter Description (Optional)",
                    // //   style: TextStyle(
                    // //     fontSize: 18.sp,
                    // //     fontWeight: FontWeight.w600,
                    // //   ),
                    // // ),
                    // // SizedBox(height: 5.h),
                    // TextFormField(
                    //   controller: _descriptionController,
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //     hintText: "Add a message (optional)",
                    //     hintStyle: TextStyle(
                    //       color: colorScheme.onSecondary,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10).r,
                    //       borderSide: const BorderSide(
                    //         color: Colors.grey,
                    //         width: 0.5,
                    //       ),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10).r,
                    //       borderSide: BorderSide(
                    //         color: colorScheme.tertiary,
                    //         width: 1.5,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 15.h),