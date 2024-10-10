class MessageModel {
  late String toId;
  late String msg;
  late String read;
  late TypeMessage type;
  late String fromId;
  late String sent;
  MessageModel({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'];
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}

enum TypeMessage { text, image, file, audio }
