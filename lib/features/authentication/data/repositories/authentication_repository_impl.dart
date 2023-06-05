import 'package:chat_app/features/authentication/data/datasources/authentication_remote_datasources.dart';
import 'package:chat_app/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository{
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  AuthenticationRepositoryImpl({
    required this.authenticationRemoteDataSource,
  });

  @override
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    return await authenticationRemoteDataSource.signInWithPhoneNumber(phoneNumber);
  }

  @override
  Future<void> signInWithVerificationCode(String verificationCode) async {
    return await authenticationRemoteDataSource.signInWithVerificationCode(verificationCode);
  }
}




