import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) =>
    TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) =>
    json.encode(data.toJson());

class TransactionHistoryModel {
  final bool success;
  final Meta? meta;
  final List<TransactionHistoryData> data;

  TransactionHistoryModel({
    required this.success,
    required this.meta,
    required this.data,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TransactionHistoryModel(success: false, meta: null, data: []);
    }

    return TransactionHistoryModel(
      success: json["success"] ?? false,
      meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : null,
      data:
          (json["data"] as List?)
              ?.map((x) => TransactionHistoryData.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "meta": meta?.toJson(),
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class TransactionHistoryData {
  final String type;
  final int amount;
  final String paymentMethod;
  final String paymentStatus;
  final String from;
  final String to;
  final DateTime? date;

  TransactionHistoryData({
    required this.type,
    required this.amount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.from,
    required this.to,
    required this.date,
  });

  factory TransactionHistoryData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TransactionHistoryData(
        type: '',
        amount: 0,
        paymentMethod: '',
        paymentStatus: '',
        from: '',
        to: '',
        date: null,
      );
    }

    return TransactionHistoryData(
      type: json["type"] ?? '',
      amount: json["amount"] ?? 0,
      paymentMethod: json["paymentMethod"] ?? '',
      paymentStatus: json["paymentStatus"] ?? '',
      from: json["from"] ?? '',
      to: json["to"] ?? '',
      date: DateTime.tryParse(json["date"]?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "amount": amount,
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "from": from,
    "to": to,
    "date": date?.toIso8601String(),
  };
}

class Meta {
  final int totalcount;
  final int currentpage;
  final int limit;
  final int totalPages;

  Meta({
    required this.totalcount,
    required this.currentpage,
    required this.limit,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Meta(totalcount: 0, currentpage: 0, limit: 0, totalPages: 0);
    }

    return Meta(
      totalcount: json["totalcount"] ?? 0,
      currentpage: json["currentpage"] ?? 0,
      limit: json["limit"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "totalcount": totalcount,
    "currentpage": currentpage,
    "limit": limit,
    "totalPages": totalPages,
  };
}
