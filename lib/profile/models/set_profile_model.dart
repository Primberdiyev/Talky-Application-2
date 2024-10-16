class SetProfileModel {
  final String name;
  final String description;
  final String? imgUrl;
  SetProfileModel(
      {required this.name, required this.description, required this.imgUrl});
  factory SetProfileModel.fromJson(Map<String, dynamic> json) {
    return SetProfileModel(
        name: json['name'],
        description: json['description'],
        imgUrl: json['imgUrl']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imgUrl': imgUrl,
    };
  }
}
