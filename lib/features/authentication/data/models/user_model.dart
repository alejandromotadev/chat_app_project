
import 'package:chat_app/features/authentication/domain/entities/user.dart';

class UserModel extends User{
  UserModel({
    required int id,
    required String username,
    required String password,
    required String email,
    required String name,
  }) : super(
    id: id,
    username: username,
    password: password,
    email: email,
    name: name,
  );
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    username: json['username'],
    password: json['password'],
    email: json['email'],
    name: json['name'],
  );
  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    username: user.username,
    password: user.password,
    email: user.email,
    name: user.name,
  );
  @override
  Map<String, dynamic>toJson(){
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'name': name,
    };
  }
}