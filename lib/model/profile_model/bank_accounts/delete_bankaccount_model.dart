import 'dart:convert';

DeleteBankAccountModel deleteBankAccountModelFromJson(String str) =>
    DeleteBankAccountModel.fromJson(json.decode(str));

String deleteBankAccountModelToJson(DeleteBankAccountModel data) =>
    json.encode(data.toJson());

class DeleteBankAccountModel {
  int statusCode;
  Data data;
  String message;
  bool success;

  DeleteBankAccountModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory DeleteBankAccountModel.fromJson(Map<String, dynamic> json) =>
      DeleteBankAccountModel(
        statusCode: json["statusCode"] ?? 0,
        data: json["data"] != null ? Data.fromJson(json["data"]) : Data.empty(),
        message: json["message"] ?? "",
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data.toJson(),
    "message": message,
    "success": success,
  };
}

class Data {
  Data();

  factory Data.empty() => Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
