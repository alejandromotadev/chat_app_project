import 'package:chat_app/features/authentication/data/datasources/user_remote_datasources.dart';
import 'package:chat_app/features/authentication/domain/entities/user.dart';
import 'package:chat_app/features/authentication/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({
    required this.userRemoteDataSource,
  });

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return await userRemoteDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    return await userRemoteDataSource.createUserWithEmailAndPassword(email, password);
  }

  @override
  Future<User> getCurrentUser() async {
    return await userRemoteDataSource.getCurrentUser();
  }

  @override
  Future<bool> isSignedIn() async {
    return await userRemoteDataSource.isSignedIn();
  }

  @override
  Future<void> signOut() async {
    return await userRemoteDataSource.signOut();
  }
}