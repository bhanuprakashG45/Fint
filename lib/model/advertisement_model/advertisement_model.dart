import 'dart:convert';

AdvertisementModel advertisementModelFromJson(String str) =>
    AdvertisementModel.fromJson(json.decode(str));

String advertisementModelToJson(AdvertisementModel data) =>
    json.encode(data.toJson());

class AdvertisementModel {
  int statusCode;
  AdvData data;
  String message;
  bool success;

  AdvertisementModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        statusCode: json["statusCode"] ?? 0,
        data: AdvData.fromJson(json["data"] ?? {}),
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

class AdvData {
  String title;
  String img;
  String description;

  AdvData({required this.title, required this.img, required this.description});

  factory AdvData.fromJson(Map<String, dynamic> json) => AdvData(
    title: json["title"] ?? "",
    img: json["img"] ?? "",
    description: json["description"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "img": img,
    "description": description,
  };
}
