import 'dart:convert';

AddBankAccountModel addBankAccountModelFromJson(String str) =>
    AddBankAccountModel.fromJson(json.decode(str));

String addBankAccountModelToJson(AddBankAccountModel data) =>
    json.encode(data.toJson());

class AddBankAccountModel {
  int statusCode;
  Data data;
  String message;
  bool success;

  AddBankAccountModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory AddBankAccountModel.fromJson(Map<String, dynamic> json) =>
      AddBankAccountModel(
        statusCode: json["statusCode"] ?? 0,
        data: Data.fromJson(json["data"] ?? {}),
        message: json["message"] ?? '',
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
  BankAccount bankAccount;

  Data({required this.bankAccount});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(bankAccount: BankAccount.fromJson(json["bankAccount"] ?? {}));

  Map<String, dynamic> toJson() => {"bankAccount": bankAccount.toJson()};
}

class BankAccount {
  String accountHolderName;
  String bankAccountNumber;
  String ifscCode;
  String bankName;
  String accountType;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  BankAccount({
    required this.accountHolderName,
    required this.bankAccountNumber,
    required this.ifscCode,
    required this.bankName,
    required this.accountType,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    accountHolderName: json["accountHolderName"] ?? '',
    bankAccountNumber: json["bankAccountNumber"] ?? '',
    ifscCode: json["ifscCode"] ?? '',
    bankName: json["bankName"] ?? '',
    accountType: json["accountType"] ?? '',
    id: json["_id"] ?? '',
    createdAt:
        DateTime.tryParse(json["createdAt"] ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt:
        DateTime.tryParse(json["updatedAt"] ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "accountHolderName": accountHolderName,
    "bankAccountNumber": bankAccountNumber,
    "ifscCode": ifscCode,
    "bankName": bankName,
    "accountType": accountType,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
