import 'dart:convert';

GetAllBankAccountsModel getAllBankAccountsModelFromJson(String str) =>
    GetAllBankAccountsModel.fromJson(json.decode(str));

String getAllBankAccountsModelToJson(GetAllBankAccountsModel data) =>
    json.encode(data.toJson());

class GetAllBankAccountsModel {
  int statusCode;
  BankAccountData data;
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

        data: json["data"] != null
            ? BankAccountData.fromJson(json["data"])
            : BankAccountData(bankAccounts: []),

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

class BankAccountData {
  List<BankAccounts> bankAccounts;

  BankAccountData({required this.bankAccounts});

  factory BankAccountData.fromJson(Map<String, dynamic> json) =>
      BankAccountData(
        bankAccounts: json["bankAccounts"] != null
            ? List<BankAccounts>.from(
                json["bankAccounts"].map((x) => BankAccounts.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
    "bankAccounts": bankAccounts.map((x) => x.toJson()).toList(),
  };
}

class BankAccounts {
  String id;
  String accountHolderName;
  String bankAccountNumber;
  String ifscCode;

  BankId bankId;
  CardTypeId cardTypeId;

  String accountType;
  bool isActive;

  DateTime? createdAt;
  DateTime? updatedAt;

  BankAccounts({
    required this.id,
    required this.accountHolderName,
    required this.bankAccountNumber,
    required this.ifscCode,
    required this.bankId,
    required this.cardTypeId,
    required this.accountType,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankAccounts.fromJson(Map<String, dynamic> json) => BankAccounts(
    id: json["_id"] ?? "",

    accountHolderName: json["accountHolderName"] ?? "",

    bankAccountNumber: json["bankAccountNumber"] ?? "",

    ifscCode: json["ifscCode"] ?? "",

    bankId: json["bankId"] != null
        ? BankId.fromJson(json["bankId"])
        : BankId(id: "", bankName: "", bankImage: ""),

    cardTypeId: json["cardTypeId"] != null
        ? CardTypeId.fromJson(json["cardTypeId"])
        : CardTypeId(id: "", name: "", image: ""),

    accountType: json["accountType"] ?? "",

    isActive: json["isActive"] ?? false,

    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"])
        : null,

    updatedAt: json["updatedAt"] != null
        ? DateTime.tryParse(json["updatedAt"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "accountHolderName": accountHolderName,
    "bankAccountNumber": bankAccountNumber,
    "ifscCode": ifscCode,
    "bankId": bankId.toJson(),
    "cardTypeId": cardTypeId.toJson(),
    "accountType": accountType,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class BankId {
  String id;
  String bankName;
  String bankImage;

  BankId({required this.id, required this.bankName, required this.bankImage});

  factory BankId.fromJson(Map<String, dynamic> json) => BankId(
    id: json["_id"] ?? "",
    bankName: json["bankName"] ?? "",
    bankImage: json["bankImage"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bankName": bankName,
    "bankImage": bankImage,
  };
}

class CardTypeId {
  String id;
  String name;
  String image;

  CardTypeId({required this.id, required this.name, required this.image});

  factory CardTypeId.fromJson(Map<String, dynamic> json) => CardTypeId(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "image": image};
}
