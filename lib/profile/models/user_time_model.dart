import 'package:cloud_firestore/cloud_firestore.dart';

class UserTimeModel {
  final bool? isOnline;
  final DateTime? closingTime;

  UserTimeModel({this.isOnline, this.closingTime});

  factory UserTimeModel.fromJson(Map<String, dynamic> json) {
    return UserTimeModel(
      isOnline: json['isOnline'],
      closingTime: (json['closingTime'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isOnline': isOnline,
      'closingTime':
          closingTime != null ? Timestamp.fromDate(closingTime!) : null,
    };
  }
}
