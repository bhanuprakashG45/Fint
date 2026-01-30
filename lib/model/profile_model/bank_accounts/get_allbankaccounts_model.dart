import 'dart:convert';

GetAllBankAccountsModel getAllBankAccountsModelFromJson(String str) =>
    GetAllBankAccountsModel.fromJson(json.decode(str));

String getAllBankAccountsModelToJson(GetAllBankAccountsModel data) =>
    json.encode(data.toJson());

class GetAllBankAccountsModel {
  int statusCode;
  BankAccountsData data;
  String message;
  bool success;

  GetAllBankAccountsModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetAllBankAccountsModel.fromJson(Map<String, dynamic> json) =>
      GetAllBankAccountsModel(
        statusCode: json["statusCode"] ?? 0,
        data: BankAccountsData.fromJson(json["data"] ?? {}),
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

class BankAccountsData {
  List<BankAccounts> bankAccounts;

  BankAccountsData({required this.bankAccounts});

  factory BankAccountsData.fromJson(Map<String, dynamic> json) =>
      BankAccountsData(
        bankAccounts: json["bankAccounts"] != null
            ? List<BankAccounts>.from(
                json["bankAccounts"].map((x) => BankAccounts.fromJson(x ?? {})),
              )
            : <BankAccounts>[],
      );

  Map<String, dynamic> toJson() => {
    "bankAccounts": List<dynamic>.from(bankAccounts.map((x) => x.toJson())),
  };
}

class BankAccounts {
  String id;
  String accountHolderName;
  String bankAccountNumber;
  String ifscCode;
  String bankName;
  String accountType;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;

  BankAccounts({
    required this.id,
    required this.accountHolderName,
    required this.bankAccountNumber,
    required this.ifscCode,
    required this.bankName,
    required this.accountType,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory BankAccounts.fromJson(Map<String, dynamic> json) => BankAccounts(
    id: json["_id"] ?? '',
    accountHolderName: json["accountHolderName"] ?? '',
    bankAccountNumber: json["bankAccountNumber"] ?? '',
    ifscCode: json["ifscCode"] ?? '',
    bankName: json["bankName"] ?? '',
    accountType: json["accountType"] ?? '',
    createdAt:
        DateTime.tryParse(json["createdAt"] ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt:
        DateTime.tryParse(json["updatedAt"] ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    isActive: json["isAcive"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "accountHolderName": accountHolderName,
    "bankAccountNumber": bankAccountNumber,
    "ifscCode": ifscCode,
    "bankName": bankName,
    "accountType": accountType,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isAcive": isActive,
  };
}
