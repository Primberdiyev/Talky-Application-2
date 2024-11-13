import 'package:talky_aplication_2/unilities/profile_state.dart';

class UserModel {
  final String? email;
  final String? name;
  final String? imgUrl;
  final String? id;
  final String? description;
  final ProfileState? profileState;
  final DateTime? lastTime;
  final List? chattingUsersId;

  const UserModel(
      {this.email,
      this.name,
      this.imgUrl,
      this.description,
      this.id,
      this.profileState,
      this.lastTime,
      this.chattingUsersId});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      description: json['description'],
      id: json['id'],
      profileState: ProfileState.fromString(
        json['profile_state'],
      ),
      lastTime: json['lastTime'],
      chattingUsersId: json['chattingUsersId']);

  Map<String, dynamic> toJson() => {
        if (email != null) 'email': email,
        if (name != null) 'name': name,
        if (imgUrl != null) 'imgUrl': imgUrl,
        if (description != null) 'description': description,
        if (id != null) 'id': id,
        if (profileState != null) 'profile_state': profileState?.name,
        if (lastTime != null) 'lastTime': lastTime,
        if (chattingUsersId != null) 'chattingUsersId': chattingUsersId,
      };
}
