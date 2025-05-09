import 'package:hive_flutter/hive_flutter.dart';

part 'rate_model.g.dart'; // ضروري جدًا

@HiveType(typeId: 1)
class RateModel extends HiveObject {
  @HiveField(0)
  late String senderId;

  @HiveField(1)
  late String rate;

  RateModel({required this.senderId, required this.rate});

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      senderId: json['senderId'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'rate': rate,
    };
  }
}