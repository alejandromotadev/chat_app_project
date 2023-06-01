
import 'package:chat_app/features/authentication/domain/entities/session.dart';

class SessionModel extends Session{
  SessionModel({
    required String id,
    required String userId,
    required String token,
  }) : super(
    id: id,
    userId: userId,
    token: token,
  );
  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    id: json['id'],
    userId: json['userId'],
    token: json['token'],
  );
  factory SessionModel.fromEntity(Session session) => SessionModel(
    id: session.id,
    userId: session.userId,
    token: session.token,
  );
  @override
  Map<String, dynamic>toJson(){
    return {
      'id': id,
      'userId': userId,
      'token': token,
    };
  }
}