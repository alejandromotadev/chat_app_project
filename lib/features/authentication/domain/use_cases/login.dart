import 'package:chat_app/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationUseCase{
  final AuthenticationRepository authenticationRepository;
  AuthenticationUseCase(this.authenticationRepository);

  Future<void> signInWithPhoneNumber(String phone) async{
    return await authenticationRepository.signInWithPhoneNumber(phone);
  }
  Future<void> signInWithVerificationCode(String phone) async{
    return await authenticationRepository.signInWithVerificationCode(phone);
  }
}