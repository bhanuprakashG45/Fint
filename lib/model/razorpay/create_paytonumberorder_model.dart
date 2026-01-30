import 'dart:convert';

CreatePayToNumberOrderModel createPayToNumberOrderModelFromJson(String str) =>
    CreatePayToNumberOrderModel.fromJson(json.decode(str));

String createPayToNumberOrderModelToJson(CreatePayToNumberOrderModel data) =>
    json.encode(data.toJson());

class CreatePayToNumberOrderModel {
  final bool success;
  final String message;
  final String razorpayOrderId;
  final String paymentId;
  final int amount;
  final String currency;
  final String razorpayKeyId;

  CreatePayToNumberOrderModel({
    required this.success,
    required this.message,
    required this.razorpayOrderId,
    required this.paymentId,
    required this.amount,
    required this.currency,
    required this.razorpayKeyId,
  });

  factory CreatePayToNumberOrderModel.fromJson(Map<String, dynamic>? json) {
    return CreatePayToNumberOrderModel(
      success: json?['success'] ?? false,
      message: json?['message']?.toString() ?? '',
      razorpayOrderId: json?['razorpayOrderId']?.toString() ?? '',
      paymentId: json?['paymentId']?.toString() ?? '',
      amount: _parseInt(json?['amount']),
      currency: json?['currency']?.toString() ?? 'INR',
      razorpayKeyId: json?['razorpayKeyId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'razorpayOrderId': razorpayOrderId,
    'paymentId': paymentId,
    'amount': amount,
    'currency': currency,
    'razorpayKeyId': razorpayKeyId,
  };

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}
