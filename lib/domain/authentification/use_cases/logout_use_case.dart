import 'package:chat_app/domain/authentification/repositories/auth_repository.dart';
import 'package:chat_app/domain/stream_api/repositories/stream_api_repository.dart';

class LogoutUseCase{
  LogoutUseCase(this.streamApiRepository, this.authRepository);
  final StreamApiRepository streamApiRepository;
  final AuthRepository authRepository;

  Future<void> logout() async{
    await streamApiRepository.logoutStreamChat();
    await authRepository.logout();
  }
}
