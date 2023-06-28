import 'package:chat_app/data/authentification/helpers/auth_exception.dart';
import 'package:chat_app/domain/authentification/entities/auth_user.dart';
import 'package:chat_app/domain/authentification/repositories/auth_repository.dart';
import 'package:chat_app/domain/stream_api/repositories/stream_api_repository.dart';

class LoginUseCase{
  LoginUseCase(this.authRepository, this.streamApiRepository);
  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  Future<bool> validateLogin() async{
    final user = await authRepository.getAuthUser();
    print("user: ${user.id}");
    final result = await streamApiRepository.connectIfExist(user.id);
    print("result: $result");
    if (result) {
      return true;
    } else if (user == null) {
      throw AuthException(AuthErrorCode.no_auth);
    } else {
       throw AuthException(AuthErrorCode.no_chat_user);
    }
  }
  Future<AuthUser>signIn()async{
    return await authRepository.signIn();
  }
}