class GroupModel {
  GroupModel({
    this.usersId,
    this.title,
    this.lastMessage,
    this.imgUrl,
    this.adminId,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      usersId: (json['usersId'] as List<String>?)?.map((e) => e).toList(),
      title: json['title'] as String?,
      lastMessage: json['lastMessage'] as String?,
      imgUrl: json['imgUrl'] as String?,
      adminId: json['adminId'],
    );
  }
  final List<String>? usersId;
  final String? title;
  final String? lastMessage;
  final String? imgUrl;
  final String? adminId;

  Map<String, dynamic> toJson() {
    return {
      if (usersId != null) 'usersId': usersId,
      if (title != null) 'title': title,
      if (lastMessage != null) 'lastMessage': lastMessage,
      if (imgUrl != null) 'imgUrl': imgUrl,
      if (adminId != null) 'adminId': adminId,
    };
  }
}
