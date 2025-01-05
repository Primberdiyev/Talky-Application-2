import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talky_aplication_2/utils/profile_state.dart';

class UserModel {
  const UserModel({
    this.email,
    this.name,
    this.imgUrl,
    this.description,
    this.id,
    this.profileState,
    this.lastTime,
    this.chattingUsersId,
    this.groupsId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] as String?,
        name: json['name'] as String?,
        imgUrl: json['imgUrl'] as String?,
        description: json['description'] as String?,
        id: json['id'] as String?,
        profileState:
            (json['profile_state'] != null && json['profile_state'] is String)
                ? ProfileState.fromString(json['profile_state'] as String)
                : null,
        lastTime: json['lastTime'] is Timestamp
            ? (json['lastTime'] as Timestamp).toDate()
            : json['lastTime'] is int
                ? DateTime.fromMillisecondsSinceEpoch(
                    json['lastTime'] as int,
                  )
                : null,
        chattingUsersId: (json['chattingUsersId'] as List?)
            ?.map((item) => item as String)
            .toList(),
        groupsId:
            (json['groupsId'] as List?)?.map((item) => item as String).toList(),
      );

  final String? email;
  final String? name;
  final String? imgUrl;
  final String? id;
  final String? description;
  final ProfileState? profileState;
  final DateTime? lastTime;
  final List<String>? chattingUsersId;
  final List<String>? groupsId;

  Map<String, dynamic> toJson() => {
        if (email != null) 'email': email,
        if (name != null) 'name': name,
        if (imgUrl != null) 'imgUrl': imgUrl,
        if (description != null) 'description': description,
        if (id != null) 'id': id,
        if (profileState != null) 'profile_state': profileState?.name,
        if (lastTime != null) 'lastTime': lastTime,
        if (chattingUsersId != null) 'chattingUsersId': chattingUsersId,
        if (groupsId != null) 'groupsId': groupsId,
      };
}
