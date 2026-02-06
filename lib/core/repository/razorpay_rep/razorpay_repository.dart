import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/razorpay/create_paytonumberorder_model.dart';

class RazorpayRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  Future<CreatePayToNumberOrderModel> createOrder(
    String type,
    Map<String, dynamic> body,
  ) async {
    try {
      final url;

      if (type == 'payToNumber') {
        url = AppUrls.paytoNumberUrl;
      } else if (type == 'qr') {
        url = AppUrls.qrscanpaymentUrl;
      } else {
        url = AppUrls.paytoBankAccountUrl;
      }

      debugPrint("Url : $url");
      debugPrint("Payload : $body");

      final response = await _apiServices.postApiResponse(url, body);
      return CreatePayToNumberOrderModel.fromJson(response);
    } catch (e) {
      debugPrint("Unexpected error in Creating order: $e");
      rethrow;
    }
  }

  Future<void> verifyPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    try {
      var body = {
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_order_id": razorpayOrderId,
        "razorpay_signature": razorpaySignature,
      };

      final response = await _apiServices.postApiResponse(
        AppUrls.verifyPaymentUrl,
        body,
      );
      debugPrint("Response Verify Payment :$response");
    } catch (e) {
      debugPrint("Response :$e");
      rethrow;
    }
  }

  // Future<PaymentStatusModel> checkPaymentStatus(String paymentId) async {
  //   try {
  //     final url = "${AppUrls.checkPaymentStatus}/$paymentId";
  //     final response = await _apiServices.getApiResponse(url);
  //     debugPrint(" Response Payment Status :$response");
  //     return PaymentStatusModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
