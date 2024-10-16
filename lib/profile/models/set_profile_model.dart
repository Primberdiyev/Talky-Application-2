class SetProfileModel {
  final String name;
  final String description;
  final String? photoUrl;
  SetProfileModel(
      {required this.name, required this.description, required this.photoUrl});
  factory SetProfileModel.fromJson(Map<String, dynamic> json) {
    return SetProfileModel(
        name: json['name'],
        description: json['description'],
        photoUrl: json['imgUrl']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imgUrl': photoUrl,
    };
  }
}
