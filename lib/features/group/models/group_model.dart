class GroupModel {
  GroupModel({
    this.usersId,
    this.title,
    this.lastMessage,
    this.imgUrl,
    this.adminId,
    this.id,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      usersId: (json['usersId'] as List?)?.map((e) => e as String).toList(),
      title: json['title'] as String?,
      lastMessage: json['lastMessage'] as String?,
      imgUrl: json['imgUrl'] as String?,
      adminId: json['adminId'],
      id: json['id'],
    );
  }
  final List<String>? usersId;
  final String? title;
  final String? lastMessage;
  final String? imgUrl;
  final String? adminId;
  final String? id;

  Map<String, dynamic> toJson() {
    return {
      if (usersId != null) 'usersId': usersId,
      if (title != null) 'title': title,
      if (lastMessage != null) 'lastMessage': lastMessage,
      if (imgUrl != null) 'imgUrl': imgUrl,
      if (adminId != null) 'adminId': adminId,
      if (id != null) 'id': id,
    };
  }
}
