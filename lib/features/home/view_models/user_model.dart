class UserModel {
  late final String name;
  String? profileImage;
  String? uId;

  UserModel({required this.name, required this.uId, this.profileImage = ''});

  UserModel.fromJson(json) {
    name = json['name'] as String;
    profileImage = json['profileImage'] as String?;
    uId = json['uId'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profileImage': profileImage,
      'uId': uId,
    };
  }
}
