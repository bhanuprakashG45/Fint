import 'dart:convert';

PetInsuranceModel petInsuranceModelFromJson(String str) =>
    PetInsuranceModel.fromJson(json.decode(str));

String petInsuranceModelToJson(PetInsuranceModel data) =>
    json.encode(data.toJson());

class PetInsuranceModel {
  int statusCode;
  InsuranceData data;
  String message;
  bool success;

  PetInsuranceModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory PetInsuranceModel.fromJson(Map<String, dynamic> json) =>
      PetInsuranceModel(
        statusCode: json["statusCode"] ?? 0,
        data: InsuranceData.fromJson(json["data"] ?? {}),
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

class InsuranceData {
  SavedUser savedUser;

  InsuranceData({required this.savedUser});

  factory InsuranceData.fromJson(Map<String, dynamic> json) =>
      InsuranceData(savedUser: SavedUser.fromJson(json["savedUser"] ?? {}));

  Map<String, dynamic> toJson() => {"savedUser": savedUser.toJson()};
}

class SavedUser {
  String name;
  String email;
  String password;
  String phoneNumber;
  String address;
  String pinCode;
  String parentAge;
  List<Pet> pets;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SavedUser({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.pinCode,
    required this.parentAge,
    required this.pets,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SavedUser.fromJson(Map<String, dynamic> json) => SavedUser(
    name: json["name"] ?? '',
    email: json["email"] ?? '',
    password: json["password"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
    address: json["address"] ?? '',
    pinCode: json["pinCode"] ?? '',
    parentAge: json["parentAge"] ?? '',
    pets: json["pets"] != null
        ? List<Pet>.from(json["pets"].map((x) => Pet.fromJson(x ?? {})))
        : [],
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
    "name": name,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "address": address,
    "pinCode": pinCode,
    "parentAge": parentAge,
    "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Pet {
  String petName;
  String petBreed;
  String petAge;
  String petAddress;
  dynamic petNoseImg;
  String petId;

  Pet({
    required this.petName,
    required this.petBreed,
    required this.petAge,
    required this.petAddress,
    required this.petNoseImg,
    required this.petId,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    petName: json["petName"] ?? '',
    petBreed: json["petBreed"] ?? '',
    petAge: json["petAge"] ?? '',
    petAddress: json["petAddress"] ?? '',
    petNoseImg: json["petNoseImg"],
    petId: json["petId"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "petName": petName,
    "petBreed": petBreed,
    "petAge": petAge,
    "petAddress": petAddress,
    "petNoseImg": petNoseImg,
    "petId": petId,
  };
}
