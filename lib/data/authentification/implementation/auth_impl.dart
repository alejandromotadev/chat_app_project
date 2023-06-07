import 'package:chat_app/data/authentification/repositories/auth_repository.dart';
import 'package:chat_app/domain/authentification/entities/auth_user.dart';

class AuthLocalImpl extends AuthRepository{
  @override
  Future<AuthUser> getAuthUser() async{
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser("mota");
  }

  @override
  Future<AuthUser> signIn() async{
    await Future.delayed(const Duration(seconds:2));
    return AuthUser("mota");
  }

  @override
  Future<void> logout() async{
    return;
  }
}
