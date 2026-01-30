import 'dart:async';
import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/repository/razorpay_rep/razorpay_repository.dart';
import 'package:fint/core/services/razorpay_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayViewmodel with ChangeNotifier {
  final RazorpayService _service = RazorpayService();
  final RazorpayRepository _paymentRepository = RazorpayRepository();
  final SharedPref prefs = SharedPref();

  Completer<RazorpayResult>? _completer;
  Completer<RazorpayResult>? get completer => _completer;
  String? _currentOrderId;
  String? get currentOrderId => _currentOrderId;
  String? razorpayKeyId;

  bool _isPaymentProcessing = false;
  bool get isPaymentProcessing => _isPaymentProcessing;

  void _setLoading(bool value) {
    _isPaymentProcessing = value;
    notifyListeners();
  }

  RazorpayViewmodel() {
    if (!_service.isInitialized) {
      _service.initialize();
    }

    _service.setCallbacks(
      onSuccess: _onSuccess,
      onError: _onError,
      onExternalWallet: _onExternalWallet,
    );
  }

  Future<RazorpayResult> createOrder(
    BuildContext context,
    String type,
    dynamic payload,
  ) async {
    _setLoading(true);

    _currentOrderId = null;
    razorpayKeyId = null;

    try {
      _completer = Completer<RazorpayResult>();
      final orderResp = await _paymentRepository.createOrder(type, payload);

      if (orderResp.success) {
        _currentOrderId = orderResp.razorpayOrderId;
        razorpayKeyId = orderResp.razorpayKeyId;
        debugPrint(
          "After Success Order Details :$_currentOrderId , $razorpayKeyId",
        );
        notifyListeners();
      } else {
        debugPrint("Failed Response Create Order :$orderResp");
        ToastHelper.show(
          context,
          orderResp.message,
          type: ToastificationType.error,
          duration: Duration(seconds: 4),
        );
        _setLoading(false);
      }

      if (!orderResp.success) {
        return RazorpayResult(success: false, error: "Order creation failed");
      }

      final contact = await prefs.getUserMobile();
      final userName = await prefs.getUserName();

      final options = {
        'key': orderResp.razorpayKeyId,
        'amount': orderResp.amount / 100,
        "currency": "INR",
        'name': 'Fint',
        'description': 'Order Payment',
        "order_id": orderResp.razorpayOrderId,
        'prefill': {
          'contact': contact ?? '1234567890',
          'name': userName ?? 'Customer',
        },
        'external': {
          'wallets': ['paytm'],
        },
        'theme': {'color': '#000033'},
        "timeout": 300,
      };

      try {
        _service.openPayment(options);
      } catch (e) {
        if (!(_completer?.isCompleted ?? true)) {
          _completer?.complete(
            RazorpayResult(success: false, error: e.toString()),
          );
        }
      }
    } catch (e) {
      if (!(_completer?.isCompleted ?? true)) {
        _completer?.complete(
          RazorpayResult(success: false, error: e.toString()),
        );
      }
    }

    _completer!.future.then((_) => _setLoading(false));

    return _completer!.future;
  }

  void _onSuccess(PaymentSuccessResponse response) async {
    try {
      debugPrint("Response:$response");
      debugPrint('OrderId:${response.orderId}');
      debugPrint("PaymentId:${response.paymentId}");
      debugPrint("Signature:${response.signature}");
      await _paymentRepository.verifyPayment(
        razorpayOrderId: response.orderId ?? '',
        razorpayPaymentId: response.paymentId ?? '',
        razorpaySignature: response.signature ?? '',
      );
      if (!(_completer?.isCompleted ?? true)) {
        _completer?.complete(RazorpayResult(success: true));
      }
    } catch (e) {
      if (!(_completer?.isCompleted ?? true)) {
        _completer?.complete(
          RazorpayResult(success: false, error: e.toString()),
        );
      }
    }
  }

  void _onError(PaymentFailureResponse response) async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      if (_currentOrderId != null && _currentOrderId!.isNotEmpty) {
        // final latest = await _paymentRepository.checkPaymentStatus(
        //   _currentOrderId!,
        // );

        // if (latest.success) {
        //   final status = latest.data.paymentStatus;
        //   final isFulfilled = latest.data.isFulfilled;

        //   if (status == "success" && !isFulfilled) {
        //     if (!(_completer?.isCompleted ?? true)) {
        //       _completer?.complete(RazorpayResult(success: true));
        //     }
        //     return;
        //   }
        // }
      }
      if (!(_completer?.isCompleted ?? true)) {
        _completer?.complete(
          RazorpayResult(
            success: false,
            error: response.message ?? "Payment cancelled",
          ),
        );
      }
    } catch (e) {
      if (!(_completer?.isCompleted ?? true)) {
        _completer?.complete(
          RazorpayResult(success: false, error: e.toString()),
        );
      }
    }
  }

  void _onExternalWallet(ExternalWalletResponse response) {}
}

class RazorpayResult {
  final bool success;
  final String? paymentId;
  final String? orderId;
  final String? signature;
  final String? error;

  RazorpayResult({
    required this.success,
    this.paymentId,
    this.orderId,
    this.signature,
    this.error,
  });
}
