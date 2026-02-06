import 'dart:convert';

BankNamesAndTypesModel bankNamesAndTypesModelFromJson(String str) =>
    BankNamesAndTypesModel.fromJson(json.decode(str));

String bankNamesAndTypesModelToJson(BankNamesAndTypesModel data) =>
    json.encode(data.toJson());

class BankNamesAndTypesModel {
  bool success;
  String message;
  List<BankNames> banks;
  List<CardType> cardTypes;

  BankNamesAndTypesModel({
    required this.success,
    required this.message,
    required this.banks,
    required this.cardTypes,
  });

  factory BankNamesAndTypesModel.fromJson(Map<String, dynamic> json) =>
      BankNamesAndTypesModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",

        banks: json["banks"] != null
            ? List<BankNames>.from(
                json["banks"].map((x) => BankNames.fromJson(x)),
              )
            : [],

        cardTypes: json["cardTypes"] != null
            ? List<CardType>.from(
                json["cardTypes"].map((x) => CardType.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "banks": banks.map((x) => x.toJson()).toList(),
    "cardTypes": cardTypes.map((x) => x.toJson()).toList(),
  };
}

class BankNames {
  String id;
  String bankName;
  String bankImage;

  DateTime? createdAt;
  DateTime? updatedAt;

  int v;

  BankNames({
    required this.id,
    required this.bankName,
    required this.bankImage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BankNames.fromJson(Map<String, dynamic> json) => BankNames(
    id: json["_id"] ?? "",
    bankName: json["bankName"] ?? "",
    bankImage: json["bankImage"] ?? "",

    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"])
        : null,

    updatedAt: json["updatedAt"] != null
        ? DateTime.tryParse(json["updatedAt"])
        : null,

    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bankName": bankName,
    "bankImage": bankImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class CardType {
  String id;
  String name;
  String image;

  DateTime? createdAt;
  DateTime? updatedAt;

  int v;

  CardType({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CardType.fromJson(Map<String, dynamic> json) => CardType(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    image: json["image"] ?? "",

    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"])
        : null,

    updatedAt: json["updatedAt"] != null
        ? DateTime.tryParse(json["updatedAt"])
        : null,

    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
