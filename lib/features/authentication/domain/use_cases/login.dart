import 'package:chat_app/features/authentication/domain/entities/user.dart';
import 'package:chat_app/features/authentication/domain/repositories/user_repository.dart';

class LoginUseCase{
  final UserRepository userRepository;
  LoginUseCase(this.userRepository);

  Future<User> execute(String email, String password) async{
    return await userRepository.signInWithEmailAndPassword(email, password);
  }
}