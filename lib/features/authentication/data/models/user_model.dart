import 'package:chat_app/features/authentication/domain/entities/user.dart';

class UserModel extends UserDomain{
  UserModel({
    required String phoneNumber,
  }) : super(
    phoneNumber: phoneNumber,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
    };
  }
}