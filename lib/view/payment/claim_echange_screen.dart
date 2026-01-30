import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/home_viewmodel/home_viewmodel.dart';

class ClaimExchangeScreen extends StatefulWidget {
  final String orderId;
  final String amount;

  const ClaimExchangeScreen({
    super.key,
    required this.orderId,
    required this.amount,
  });

  @override
  State<ClaimExchangeScreen> createState() => _ClaimExchangeScreenState();
}

class _ClaimExchangeScreenState extends State<ClaimExchangeScreen> {
  Future<void> _onClaimExchange(HomeViewmodel homevm) async {
    if (widget.orderId.trim().isEmpty) {
      ToastHelper.show(
        context,
        "Order Id is empty",
        type: ToastificationType.error,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (homevm.isEchangeClaiming) return;

    final body = {"razorpay_order_id": widget.orderId};

    await homevm.claimEChange(context, body);
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Claim E-change",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.onPrimary,
      ),
      body: Consumer<HomeViewmodel>(
        builder: (context, homevm, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(12).r,
                    color: Color(0xFFF5F2F2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Amount : ${widget.amount}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorscheme.tertiary,
                      foregroundColor: colorscheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                    ),
                    onPressed: homevm.isEchangeClaiming
                        ? null
                        : () {
                            _onClaimExchange(homevm);
                          },
                    child: homevm.isEchangeClaiming
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Claim E-Change",
                            style: TextStyle(
                              fontSize: 18.sp,
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
    );
  }
}
