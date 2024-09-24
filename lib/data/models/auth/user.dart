import 'package:spotify_project/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? profileImageURL;

  UserModel({this.fullName, this.email, this.profileImageURL});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['name'];
    email = json['email'];
    profileImageURL = json['profileImageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = fullName;
    data['email'] = email;
    data['profileImageURL'] = profileImageURL;
    return data;
  }
}

extension UserModelx on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
      profileImageURL: profileImageURL,
    );
  }
}
