import 'package:chat_app/features/authentication/data/datasources/authentication_remote_datasources.dart';
import 'package:chat_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:chat_app/features/authentication/domain/use_cases/login.dart';

class UseCaseConfig {
  //===================================== Authentication =====================================
  AuthenticationUseCase? authenticationUseCase;
  AuthenticationRepositoryImpl? authenticationRepositoryImpl;
  AuthenticationRemoteDataSourceImpl? authenticationRemoteDataSourceImpl;

  UseCaseConfig() {
    //===================================== Authentication =====================================
    authenticationRemoteDataSourceImpl = AuthenticationRemoteDataSourceImpl();
    authenticationRepositoryImpl = AuthenticationRepositoryImpl(authenticationRemoteDataSource: authenticationRemoteDataSourceImpl!);
    authenticationUseCase =
        AuthenticationUseCase(authenticationRepositoryImpl!);
  }
}
