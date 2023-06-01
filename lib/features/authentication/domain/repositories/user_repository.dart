import 'package:chat_app/features/authentication/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User> getCurrentUser();
  Future<bool> isSignedIn();
}