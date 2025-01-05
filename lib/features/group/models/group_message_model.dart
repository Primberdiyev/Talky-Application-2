import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talky_aplication_2/features/auth/models/user_model.dart';

class GroupMessageModel {
  GroupMessageModel({
    required this.message,
    required this.type,
    required this.dateTime,
    required this.userModel,
    required this.id,
  });
  factory GroupMessageModel.fromJson(Map<String, dynamic> json) {
    return GroupMessageModel(
      message: json['message'] as String,
      type: json['type'] as String,
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      id: json['id'],
    );
  }

  final String message;
  final String type;
  final DateTime dateTime;
  final UserModel? userModel;
  final String id;
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'dateTime': dateTime,
      'userModel': userModel?.toJson(),
      'id': id,
    };
  }
}
