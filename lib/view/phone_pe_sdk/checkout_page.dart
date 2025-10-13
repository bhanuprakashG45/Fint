import 'package:fint/core/constants/exports.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    this.success = false,
    this.error,
    this.upiUri,
  });

  final String? upiUri;
  final bool success;
  final String? error;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phonePe = PhonepePg();

  bool _isLoading = false;
  String? _paymentStatus;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _paymentStatus = null;
    });

    try {
      final initialized = await _phonePe.initialize();
      if (!initialized) {
        throw Exception('Failed to initialize PhonePe SDK');
      }

      final amount = int.parse(_amountController.text.trim());
      final description = _descriptionController.text.trim();

      final response = await _phonePe.startPayment(
        amountInRupees: amount,
        mobileNumber: "9999999999",
        description: description.isNotEmpty ? description : null,
      );

      setState(() {
        if (response != null && response['status'] == 'SUCCESS') {
          _paymentStatus = ' Payment Successful!';
        } else {
          final reason =
              response?['error'] ?? response?['message'] ?? 'Unknown error';
          _paymentStatus = 'Payment Failed: $reason';
        }
      });
    } catch (e) {
      setState(() {
        _paymentStatus = ' Payment Error: ${e.toString()}';
      });

      ToastHelper.show(
        context,
        "Payment failed. Please try again.",
        type: ToastificationType.error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PAYMENT PAGE",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.tertiary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_paymentStatus != null) ...[
                  Text(
                    _paymentStatus!,
                    style: TextStyle(
                      color: _paymentStatus!.contains('Successful')
                          ? Colors.green.shade400
                          : Colors.red.shade400,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
                Text(
                  "Choose the Facility for which to Pay for",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),

                /// Amount Input
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (int.tryParse(val.trim()) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10).r,
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10).r,
                      borderSide: BorderSide(
                        color: colorScheme.secondary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                /// Description Input
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Add a Message (Optional)',
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10).r,
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10).r,
                      borderSide: BorderSide(
                        color: colorScheme.secondary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    backgroundColor: colorScheme.tertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0).r,
                    ),
                  ),
                  onPressed: () {
                    _processPayment();
                  },
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: colorScheme.onPrimary,
                          strokeWidth: 2,
                        )
                      : Text(
                          "PROCEED TO PAY",
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
