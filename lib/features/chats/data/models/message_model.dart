import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late String senderId;
  late String receiverId;
  late String message;
  late Timestamp time;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.time,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': time,
    };
  }
}
