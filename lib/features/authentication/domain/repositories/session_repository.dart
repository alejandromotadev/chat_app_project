
abstract class SessionRepository {
  Future<void> signOut();
  Future<bool> isSignedIn();
}