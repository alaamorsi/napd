import 'package:hive_flutter/hive_flutter.dart';
import 'package:nabd/features/chats/data/models/rate_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String specialty;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late int image;

  @HiveField(4)
  late String about;

  @HiveField(5)
  late String uId;

  @HiveField(6)
  late List<RateModel> rates = [];

  @HiveField(7)
  late List<String> clientsId = [];

  @HiveField(8)
  late String rating;

  UserModel({
    required this.name,
    required this.specialty,
    required this.email,
    required this.image,
    required this.about,
    required this.uId,
    required this.rates,
    required this.clientsId,
    required this.rating,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    specialty = json['specialty'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? 3;
    about = json['about'] ?? '';
    uId = json['uId'] ?? '';

    // 🛠️ تحويل الريتس
    rates = (json['rates'] as List<dynamic>?)
            ?.map((e) => RateModel.fromJson(Map<String, dynamic>.from(e)))
            .toList() 
            ?? [];

    clientsId = List<String>.from(json['clientsId'] ?? []);

    rating = json['rating'] ?? '0.0';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialty': specialty,
      'email': email,
      'image': image,
      'about': about,
      'uId': uId,
      'rates': rates.map((e) => e.toJson()).toList(), // 🛠️ تحويل قائمة الريتس
      'clientsId': clientsId,
      'rating': rating,
    };
  }
}