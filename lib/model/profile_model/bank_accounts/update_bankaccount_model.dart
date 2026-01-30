import 'dart:convert';

UpdateBankAccountModel updateBankAccountModelFromJson(String str) =>
    UpdateBankAccountModel.fromJson(json.decode(str));

String updateBankAccountModelToJson(UpdateBankAccountModel data) =>
    json.encode(data.toJson());

class UpdateBankAccountModel {
  int statusCode;
  UpdateBankData data;
  String message;
  bool success;

  UpdateBankAccountModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory UpdateBankAccountModel.fromJson(Map<String, dynamic> json) =>
      UpdateBankAccountModel(
        statusCode: json["statusCode"] ?? 0,
        data: UpdateBankData.fromJson(json["data"] ?? {}),
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

class UpdateBankData {
  BankAccount bankAccount;

  UpdateBankData({required this.bankAccount});

  factory UpdateBankData.fromJson(Map<String, dynamic> json) => UpdateBankData(
    bankAccount: BankAccount.fromJson(json["bankAccount"] ?? {}),
  );

  Map<String, dynamic> toJson() => {"bankAccount": bankAccount.toJson()};
}

class BankAccount {
  bool isAcive;
  String id;
  String accountHolderName;
  String bankAccountNumber;
  String ifscCode;
  String bankName;
  String accountType;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  BankAccount({
    required this.isAcive,
    required this.id,
    required this.accountHolderName,
    required this.bankAccountNumber,
    required this.ifscCode,
    required this.bankName,
    required this.accountType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    isAcive: json["isAcive"] ?? false,
    id: json["_id"] ?? "",
    accountHolderName: json["accountHolderName"] ?? "",
    bankAccountNumber: json["bankAccountNumber"] ?? "",
    ifscCode: json["ifscCode"] ?? "",
    bankName: json["bankName"] ?? "",
    accountType: json["accountType"] ?? "",
    createdAt:
        DateTime.tryParse(json["createdAt"] ?? "") ??
        DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt:
        DateTime.tryParse(json["updatedAt"] ?? "") ??
        DateTime.fromMillisecondsSinceEpoch(0),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "isAcive": isAcive,
    "_id": id,
    "accountHolderName": accountHolderName,
    "bankAccountNumber": bankAccountNumber,
    "ifscCode": ifscCode,
    "bankName": bankName,
    "accountType": accountType,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
