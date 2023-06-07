import 'package:chat_app/data/authentification/helpers/auth_exception.dart';
import 'package:chat_app/data/authentification/repositories/auth_repository.dart';
import 'package:chat_app/data/stream_api/repositories/stream_api_repository.dart';

class LoginUseCase{
  LoginUseCase(this.authRepository, this.streamApiRepository);
  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  Future<bool> validateLogin() async{
    print("validate login use case");
    final user = await authRepository.getAuthUser();
    final result = await streamApiRepository.connectIfExist(user.id);
    if (result) {
      return true;
    } else {
       throw AuthException(AuthErrorCode.no_chat_user);
    }
     throw AuthException(AuthErrorCode.no_auth);
  }
}