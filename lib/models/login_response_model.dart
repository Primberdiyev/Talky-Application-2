import "dart:convert";

LoginResponseModel loginResponseModel(String str) {
  return LoginResponseModel.fromJson(
    json.decode(str),
  );
}

class LoginResponseModel {
  late final String message;
  late final String? data;
  LoginResponseModel({
    required this.message,
    this.data,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
