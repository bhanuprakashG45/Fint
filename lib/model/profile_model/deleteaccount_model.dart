import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) =>
    DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) =>
    json.encode(data.toJson());

class DeleteAccountModel {
  int statusCode;
  dynamic data;
  String message;
  bool success;

  DeleteAccountModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) =>
      DeleteAccountModel(
        statusCode: json["statusCode"] ?? 0,
        data: json["data"] ?? null,
        message: json["message"] ?? "",
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data,
    "message": message,
    "success": success,
  };
}
