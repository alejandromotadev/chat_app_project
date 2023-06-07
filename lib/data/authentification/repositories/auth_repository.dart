import 'package:chat_app/domain/authentification/entities/auth_user.dart';

abstract class AuthRepository{
  Future<AuthUser> getAuthUser();
  Future<AuthUser> signIn();
  Future<void> logout();
}