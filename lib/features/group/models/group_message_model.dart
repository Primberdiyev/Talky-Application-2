import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMessageModel {
  GroupMessageModel({
    required this.message,
    required this.type,
    required this.dateTime,
    required this.id,
    required this.imageUrl,
  });
  factory GroupMessageModel.fromJson(Map<String, dynamic> json) {
    return GroupMessageModel(
      message: json['message'] as String,
      type: json['type'] as String,
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  final String message;
  final String type;
  final DateTime dateTime;
  final String? imageUrl;
  final String id;
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'dateTime': dateTime,
      'id': id,
      'imageUrl': imageUrl,
    };
  }
}
