import 'dart:convert';

ClaimEChangeModel claimEChangeModelFromJson(String str) =>
    ClaimEChangeModel.fromJson(json.decode(str));

String claimEChangeModelToJson(ClaimEChangeModel data) =>
    json.encode(data.toJson());

class ClaimEChangeModel {
  final bool success;
  final String message;
  final String paymentId;
  final String receiverType;

  ClaimEChangeModel({
    required this.success,
    required this.message,
    required this.paymentId,
    required this.receiverType,
  });

  factory ClaimEChangeModel.fromJson(Map<String, dynamic>? json) =>
      ClaimEChangeModel(
        success: json?["success"] ?? false,
        message: json?["message"] ?? '',
        paymentId: json?["paymentId"] ?? '',
        receiverType: json?["receiverType"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "paymentId": paymentId,
    "receiverType": receiverType,
  };
}
