import 'package:talky_aplication_2/features/auth/models/user_model.dart';

class GroupMessageModel {
  GroupMessageModel({
    required this.id,
    required this.message,
    required this.type,
    required this.dateTime,
    required this.userModel,
  });
  factory GroupMessageModel.fromJson(Map<String, dynamic> json) {
    return GroupMessageModel(
      id: json['id'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      dateTime: json['dateTime'] as DateTime,
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
    );
  }

  final String id;
  final String message;
  final String type;
  final DateTime dateTime;
  final UserModel userModel;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': type,
      'dateTime': dateTime,
      'userModel': userModel.toJson(),
    };
  }
}
